from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
import json
from django.db import connections
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from django.contrib import messages
from . import forms
import pymongo
from .utils import authenticate_user, has_permission
from .models import CustomUser
from datetime import date
from django.contrib.auth import logout
from django.contrib import messages
import json

conexaomongo = pymongo.MongoClient("mongodb://localhost:27017/")["trabalho_final"]

#############################################################  ADMIN  ##########################################################################################

def index(request):
    return render(request, 'index.html')


#############################################################  VENDEDOR  ##########################################################################################

@has_permission('vendedor')
def fatura_venda(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_faturas_venda();")
        columns = [col[0] for col in cursor.description]
        fatura_venda = cursor.fetchall()

    return render(request, 'lista_faturas.html', {'vista': fatura_venda, 'columns': columns, 'tipo': 'fatura_venda', 'role': request.user_role})

@has_permission('vendedor')
def fatura_venda_ver(request, fatura_id):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_fatura_venda(%s);", [fatura_id])
        columns = [col[0] for col in cursor.description]
        fatura_venda = cursor.fetchall()

    return render(request, 'ver_fatura.html', {'vista': fatura_venda, 'columns': columns, 'tipo': 'fatura_venda', 'role': request.user_role})

@has_permission('vendedor')
def clientes(request):
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_clients();")
        columns = [col[0] for col in cursor.description]
        clientes = cursor.fetchall()
    return render(request, 'lista.html', {'vista': clientes, 'columns': columns, 'tipo': 'Clientes', 'role': request.user_role})


@has_permission('vendedor')
def equipamentos_armazenados(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_equipamentos_armazenados();")
        columns = [col[0] for col in cursor.description]
        equipamentos_armazenados = cursor.fetchall()

    return render(request, 'equipamentos_armazenados.html', {'vista': equipamentos_armazenados, 'columns': columns, 'tipo': 'Equipamentos_armazenados', 'role': request.user_role})


@has_permission('vendedor')
def editar_clientes(request, clientes_id):

    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM func_cliente_id(%s);", [clientes_id])
        columns = [col[0] for col in cursor.description]
        clientes = cursor.fetchall()

    if request.method == 'POST':
        form = forms.Clientes(request.POST)
        if form.is_valid():
            nome_cliente = form.cleaned_data["nome_cliente"]
            nif = form.cleaned_data["nif"]
            cur = connections['default'].cursor()
            cur.execute("CALL public.proc_editar_clients(%s, %s, %s);", [clientes_id, nome_cliente, nif])
            return redirect('http://127.0.0.1:8000/clientes')  
    else:
        form_initial_data = {}
        if clientes:
            cliente = clientes[0]
            for idx, column in enumerate(columns):
                form_initial_data[column] = cliente[idx]
        form = forms.Clientes(initial=form_initial_data)
    
    return render(request, 'editar_registro.html', {'form': form, 'role': request.user_role})

@has_permission('vendedor')
def adicionar_clientes(request):

    if request.method == "POST":
        form = forms.Clientes(request.POST)
        if form.is_valid():
            nome_cliente = form.cleaned_data['nome_cliente']
            nif = form.cleaned_data['nif']
            cur = connections['default'].cursor()
            cur.execute("call public.proc_inserir_cliente(%s);", [nome_cliente])
            return redirect('http://127.0.0.1:8000/clientes')  
    else:
        form = forms.Clientes()
    return render(request, 'adicionar.html', {'form': form, 'role': request.user_role})


@has_permission('vendedor')
def eliminar_clientes(request, clientes_id):

    if request.method == "POST":
            cur = connections['default'].cursor()
            cur.execute("call public.proc_eliminar_cliente(%s);", [clientes_id])
            return redirect('http://127.0.0.1:8000/clientes')  
    return render(request, 'cliente_eliminar_confirm.html', {'role': request.user_role})

@has_permission('vendedor')
def exportar_equipamento(request, equipamentos_id):
    

    if request.method == 'POST':
        form = forms.EquipamentosExportados(request.POST)

        if form.is_valid():
            nome_equipamento = form.cleaned_data['nome_equipamento']
            atributo = form.cleaned_data['atributo']
            valorum = form.cleaned_data['valorum']

            with connections['default'].cursor() as cursor:
                cursor.execute("SELECT preco_equipamento(%s);", [equipamentos_id])
                custo = cursor.fetchall()

            db = conexaomongo
            produtos_collection = db["produtos"]

            cur = connections['default'].cursor()
            cur.execute("CALL public.proc_editar_eq_arm(%s);", [equipamentos_id])

            novo_equipamento = {
                'pgsid_eq_arm': equipamentos_id,
                'nome_equipamento': nome_equipamento,
                atributo : valorum,
                'Preço': custo[0][0]
            }

            produtos_collection.insert_one(novo_equipamento)
                
            return redirect('http://127.0.0.1:8000/equipamentos_armazenados')

    else:
        form = forms.EquipamentosExportados()  
        
    return render(request, 'exportar.html', {'form': form, 'role': request.user_role})

@has_permission('vendedor')
def produtos(request):

    db = conexaomongo
    col = db["produtos"]
    produtos = col.find()
    context = {'documentos': produtos, 'role': request.user_role}
        
    return render(request, 'eq_para_venda.html', context)

@has_permission('vendedor')
def produtos_cliente(request, cliente_id):

    db = conexaomongo
    col = db["produtos"]
    produtos = col.find()
    context = {'documentos': produtos, 'cliente': cliente_id, 'role': request.user_role}
        
    return render(request, 'ver_produtos_cliente.html', context)

@has_permission('vendedor')
def vender_produto(request, eq_id, cliente_id):

    db = conexaomongo
    col = db["produtos"]
    produtos = col.find_one({"pgsid_eq_arm": eq_id})
    context = {'documentos': produtos, 'role': request.user_role}
    if request.method == "POST":
        db = conexaomongo
        col = db["carrinho"]

        carrinho_existente = col.find_one({"pgsid_cliente": cliente_id})
        if carrinho_existente:
            col.update_one({'pgsid_cliente': cliente_id}, {'$push': {'pgsid_eq_arm': eq_id}})
            redirect_url = f'/produtos/{cliente_id}'
            return HttpResponseRedirect(redirect_url) 
        else:
            col.insert_one({'pgsid_cliente': cliente_id, 'pgsid_eq_arm': [eq_id]})
            redirect_url = f'/produtos/{cliente_id}'
            return HttpResponseRedirect(redirect_url) 
        
    return render(request, 'ver_produto.html', context)

@has_permission('vendedor')
def ver_produto(request, eq_id):

    db = conexaomongo
    col = db["produtos"]
    produtos = col.find_one({"pgsid_eq_arm": eq_id})
    context = {'documentos': produtos, 'role': request.user_role}
        
    return render(request, 'ver_produto.html', context)

@has_permission('vendedor')
def escolher_cliente(request):

    if request.method == "POST":
        form = forms.Procura_cliente(request.POST)
        if form.is_valid():
            nif = form.cleaned_data['nif']
            cur = connections['default'].cursor()
            cur.execute("SELECT * FROM func_cliente_nif(%s);", [nif])
            result = cur.fetchone()
            
            if result:
                id = result[0]
                redirect_url = f'/produtos/{id}'
                return HttpResponseRedirect(redirect_url) 
            else:
                redirect_url = f'/escolher_cliente/'
                return HttpResponseRedirect(redirect_url)  
    else:
        form = forms.Procura_cliente()

    context = {'documentos': produtos, 'clientes': clientes, 'form': form, 'role': request.user_role}
        
    return render(request, 'adicionar.html', context)

@has_permission('vendedor')
def carrinho(request, cliente_id):

    db = conexaomongo
    col = db["carrinho"]
    col1 = db["produtos"]

    carrinho = col.find_one({"pgsid_cliente": cliente_id})
    equipamentos = col1.find()
    nomes_equipamentos = []
    if carrinho:
        ids_equipamentos = carrinho["pgsid_eq_arm"]
        
        
        if ids_equipamentos:
            for id_equipamento in ids_equipamentos:
                equipamento = col1.find_one({"pgsid_eq_arm": id_equipamento})
                nome_equipamento = equipamento["nome_equipamento"]
                preco = equipamento["Preço"]
                nomes_equipamentos.append({'nome': nome_equipamento, 'preco': preco})

    context = {'documentos': carrinho, 'equipamentos': equipamentos, 'nomes_equipamentos': nomes_equipamentos, 'cliente': cliente_id, 'role': request.user_role}
    
    return render(request, 'carrinho.html', context)

@has_permission('vendedor')
def concluir_compra(request, cliente_id):

    db = conexaomongo
    col = db["carrinho"]
    col1 = db["produtos"]

    carrinho = col.find_one({"pgsid_cliente": cliente_id})
    equipamentos = col1.find()
    nomes_equipamentos = []
    if carrinho:
        ids_equipamentos = carrinho["pgsid_eq_arm"]
        if ids_equipamentos:
            for id_equipamento in ids_equipamentos:
                equipamento = col1.find_one({"pgsid_eq_arm": id_equipamento})
                nome_equipamento = equipamento["nome_equipamento"]
                preco = equipamento["Preço"]
                nomes_equipamentos.append({'id': id_equipamento, 'nome': nome_equipamento, 'preco': preco})

    
    cur = connections['default'].cursor()
    cur.execute("CALL public.proc_inserir_fatura_venda(%s, NULL);", [cliente_id])
    d_output = cur.fetchone()[0]

    for equipamento in nomes_equipamentos:
        cur.execute("CALL public.proc_inserir_itens_fatura_venda(%s, %s, %s);", [d_output, equipamento['id'], equipamento['preco'].replace("R$", "")])
        print(equipamento['id'])
        col.update_one({"pgsid_cliente": cliente_id}, {'$pull': {'pgsid_eq_arm': equipamento['id']}})
        col1.delete_one({"pgsid_eq_arm": equipamento['id']})


    context = {'documentos': carrinho, 'equipamentos': equipamentos, 'nomes_equipamentos': nomes_equipamentos, 'cliente': cliente_id, 'role': request.user_role}
    
    return render(request, 'concluido.html', context)



#############################################################  ARMAZEM  ##########################################################################################

@has_permission('armazem')
def armazens(request):
    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM exibir_armazem();")
        columns = [col[0] for col in cursor.description]
        armazem = cursor.fetchall()
    
    return render(request, 'lista_sem_acoes.html', {'vista': armazem, 'columns': columns, 'tipo': 'Armazens', 'role': request.user_role})

@has_permission('armazem')
def escolher_enc_para_guia(request):
    current_datetime = date.today()
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_encomenda();")
        columns = [col[0] for col in cursor.description]
        encomendas = cursor.fetchall()

        cursor.execute("call public.proc_inserir_guia_remessa(%s, NULL);", [current_datetime])
        id_output = cursor.fetchone()[0]

    return render(request, 'enc_guias.html', {'vista': encomendas, 'columns': columns, 'tipo': 'Guias', 'guia': id_output, 'role': request.user_role})

@has_permission('armazem')
def criar_guia(request, encomenda_id, guia_id):
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM func_itens_enc_id_com_id(%s);", [encomenda_id])
        columns = [col[0] for col in cursor.description]
        encomendas = cursor.fetchall()

    return render(request, 'item_enc_para_guia.html', {'vista': encomendas, 'columns': columns, 'tipo': 'Guias', 'guia': guia_id, 'encomenda': encomenda_id, 'role': request.user_role})

@has_permission('armazem')
def adicionar_itens_guia(request, encomenda_id, guia_id, item_id, quantidade_id):
    if request.method == "POST":
        form = forms.Guia_Remessa(request.POST)
        if form.is_valid():
            armazem = form.cleaned_data['armazem']
            quantidade = form.cleaned_data['quantidade']
            cur = connections['default'].cursor()
            cur.execute("call public.proc_criar_guia_remessa_com_itens(%s, %s, %s, %s, %s);", [armazem, item_id, guia_id, quantidade, quantidade_id])
            redirect_url = f'/editar_Guias/{encomenda_id}/{guia_id}/'
            return HttpResponseRedirect(redirect_url)  
    else:
        form = forms.Guia_Remessa()

    return render(request, 'adicionar.html', {'form': form, 'tipo': 'Guias', 'guia': guia_id, 'encomenda': encomenda_id, 'role': request.user_role})

@has_permission('armazem')
def fatura(request, guia_id, encomenda_id):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("call public.proc_inserir_factura_enc(NULL)")
        id_output = cursor.fetchone()[0]


    return render(request, 'fatura.html', {'fatura': id_output, 'guia': guia_id, 'encomenda': encomenda_id, 'role': request.user_role})

@has_permission('armazem')
def criar_fatura_enc(request, guia_id, encomenda_id, fatura_id):
    
    with connections['default'].cursor() as cursor:
        print(guia_id)
        
        
        cursor.execute("SELECT * FROM public.func_itens_remessa_id_com_id(%s);", [guia_id])
        columns = [col[0] for col in cursor.description]
        itens = cursor.fetchall()

    return render(request, 'criar_fatura.html', {'fatura': fatura_id, 'vista': itens, 'columns': columns, 'guia': guia_id, 'encomenda': encomenda_id, 'role': request.user_role})

@has_permission('armazem')
def preco_por_item(request, item_id, fatura_id, guia_id, encomenda_id):

    if request.method == "POST":
        form = forms.item_fatura(request.POST)
        if form.is_valid():
            preco = form.cleaned_data['preco']
            cur = connections['default'].cursor()
            print(item_id)
            cur.execute("call public.proc_inserir_item_fatura(%s, %s, %s)", [fatura_id, item_id, preco])
            redirect_url = f'/fatura_encomenda/{guia_id}/{encomenda_id}/{fatura_id}/'
            return HttpResponseRedirect(redirect_url)  
    else:
        form = forms.item_fatura()
    

    return render(request, 'adicionar.html', {'form': form, 'role': request.user_role})

@has_permission('armazem')
def guia_remessa(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_guia_remessa();")
        columns = [col[0] for col in cursor.description]
        guia_remessa = cursor.fetchall()

    return render(request, 'lista.html', {'vista': guia_remessa, 'columns': columns, 'tipo': 'Guias', 'role': request.user_role})


@has_permission('armazem')
def itens_remessa(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_itens_remessa();")
        columns = [col[0] for col in cursor.description]
        itens_remessa = cursor.fetchall()

    return render(request, 'lista.html', {'vista': itens_remessa, 'columns': columns, 'tipo': 'Itens_das_remessas', 'role': request.user_role})

@has_permission('armazem')
def fatura_encomenda_armazem(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_fatura_encomenda();")
        columns = [col[0] for col in cursor.description]
        fatura_encomenda = cursor.fetchall()

    return render(request, 'lista_sem_acoes.html', {'vista': fatura_encomenda, 'columns': columns, 'tipo': 'Faturas_das_encomendas', 'role': request.user_role})


@has_permission('armazem')
def ficha_prod(request):
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_fp();")
        columns = [col[0] for col in cursor.description]
        fp = cursor.fetchall()
    return render(request, 'lista_sem_acoes.html', {'vista': fp, 'columns': columns, 'tipo': 'Ficha_Producao', 'role': request.user_role})




#############################################################  PRODUCAO  ##########################################################################################

@has_permission('producao')
def ficha_prod_producao(request):
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_fp();")
        columns = [col[0] for col in cursor.description]
        fp = cursor.fetchall()
    return render(request, 'fichas_producao.html', {'vista': fp, 'columns': columns, 'tipo': 'Ficha_Producao', 'role': request.user_role})


@has_permission('producao')
def criar_equipamentos(request):
    if request.method == "POST":
        form = forms.Equipamentos(request.POST)
        if form.is_valid():
            nome_equipamento = form.cleaned_data['nome_equipamento']
            tipo = form.cleaned_data['tipo']
            cur = connections['default'].cursor()
            cur.execute("call public.proc_inserir_equipamento(%s, %s);", [nome_equipamento, tipo])
            return redirect('http://127.0.0.1:8000/equipamentos')
    else:
        form = forms.Equipamentos()

    return render(request, 'adicionar.html', {'form': form, 'role': request.user_role})

@has_permission('producao')
def criar_Ficha_Producao(request, equipamento_id):
    if request.method == "POST":
        cur = connections['default'].cursor()
        cur.execute("call public.proc_inserir_ficha_producao(%s, NULL);", [equipamento_id])
        id_output = cur.fetchone()[0]
        redirect_url = f'/criar_Ficha_Item/{id_output}/'
        return HttpResponseRedirect(redirect_url)  

    return render(request, 'ficha_prod_confirmar.html', {'role': request.user_role})

@has_permission('producao')
def itens_ficha_prod(request, ficha_prod_id):
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM func_comp_ficha_id_com_id(%s);", [ficha_prod_id])
        columns = [col[0] for col in cursor.description]
        encomendas = cursor.fetchall()

    if request.method == "POST":
        form = forms.Componentes_Producao(request.POST)
        if form.is_valid():
            componente = form.cleaned_data['componente']
            quantidade_usada = form.cleaned_data['quantidade_usada']
            cur = connections['default'].cursor()
            cur.execute("select * from public.componentes_em_stock_por_comp(%s);", [componente])
            q = cur.fetchone()[0]
            if quantidade_usada <= q :
                cur.execute("call public.proc_inserir_componentes_producao(%s, %s, %s);", [componente, ficha_prod_id, quantidade_usada])
            else:
                form.add_error('quantidade_usada', 'Quantidade usada maior do que a quantidade em estoque.')
            redirect_url = f'/criar_Ficha_Item/{ficha_prod_id}/'
            return HttpResponseRedirect(redirect_url)  
    else:
        form = forms.Componentes_Producao()

    return render(request, 'criar_ficha_comp.html', {'form': form, 'vista': encomendas, 'columns': columns, 'ficha': ficha_prod_id, 'role': request.user_role})

@has_permission('producao')
def mo_ficha_prod(request, ficha_prod_id):

    if request.method == "POST":
        form = forms.Mao_Obra_Usada(request.POST)
        if form.is_valid():
            id_mao_obra = form.cleaned_data['id_mao_obra']
            hora_inicio = form.cleaned_data['hora_inicio']
            hora_fim = form.cleaned_data['hora_fim']
            cur = connections['default'].cursor()
            cur.execute("call public.proc_inserir_mo_usada(%s, %s, %s, %s);", [ficha_prod_id, id_mao_obra, hora_inicio, hora_fim])
            redirect_url = f'/armazenar/{ficha_prod_id}'
            return HttpResponseRedirect(redirect_url)
    else:
        form = forms.Mao_Obra_Usada()

    return render(request, 'adicionar.html', {'form': form, 'role': request.user_role})

@has_permission('producao')
def armazem_fichaprod_eq_arm(request, ficha_prod_id):

    if request.method == 'POST':
        form = forms.Equipamentos_armazenados(request.POST)
        if form.is_valid():
            armazem = form.cleaned_data["armazem"]
            cur = connections['default'].cursor()
            cur.execute("CALL public.proc_inserir_equipamento_armazenado(%s, %s);", [armazem, ficha_prod_id])
            return redirect('http://127.0.0.1:8000/equipamentos')  
    else:
        form = forms.Equipamentos_armazenados()

    return render(request, 'adicionar.html', {'form': form, 'role': request.user_role})


@has_permission('producao') 
def equipamentos(request):
    
    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM exibir_equipamentos();")
        columns = [col[0] for col in cursor.description]
        equipamentos = cursor.fetchall()

    return render(request, 'equipamentos.html', {'vista': equipamentos, 'columns': columns, 'tipo': 'Equipamentos', 'role': request.user_role})



@has_permission('producao')
def mao_obra(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_mo();")
        columns = [col[0] for col in cursor.description]
        mao_obra = cursor.fetchall()

    return render(request, 'lista.html', {'vista': mao_obra, 'columns': columns, 'tipo': 'Mao_de_obra', 'role': request.user_role})





@has_permission('producao')
def editar_Mao_de_obra(request, mao_obra_id):

    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM func_mo_id(%s);", [mao_obra_id])
        columns = [col[0] for col in cursor.description]
        mao_obra = cursor.fetchall()

    if request.method == 'POST':
        form = forms.mao_de_obra(request.POST)
        if form.is_valid():
            nome_mo = form.cleaned_data["nome_mo"]
            custo_mo = form.cleaned_data["custo_mo"]
            tipo_mo = form.cleaned_data["tipo_mo"]
            cur = connections['default'].cursor()
            cur.execute("SELECT public.editar_mao_obra(%s, %s, %s, %s);", [mao_obra_id, nome_mo, custo_mo, tipo_mo])
            return redirect('http://127.0.0.1:8000/Mao_de_obra')  
    else:
        form_initial_data = {}
        if mao_obra:
            mo = mao_obra[0]
            for idx, column in enumerate(columns):
                form_initial_data[column] = mo[idx]
        form = forms.mao_de_obra(initial=form_initial_data)
    
    return render(request, 'editar_registro.html', {'form': form, 'role': request.user_role})

@has_permission('producao')
def comp_stock_prod(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM componentes_em_stock();")
        columns = [col[0] for col in cursor.description]
        comp_stock = cursor.fetchall()

    return render(request, 'lista.html', {'vista': comp_stock, 'columns': columns, 'tipo': 'comp_stock', 'role': request.user_role})


#############################################################  ENCOMENDA  ##########################################################################################

@has_permission('encomenda')
def fatura_encomenda(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_fatura_encomenda();")
        columns = [col[0] for col in cursor.description]
        fatura_encomenda = cursor.fetchall()

    return render(request, 'lista_sem_acoes.html', {'vista': fatura_encomenda, 'columns': columns, 'tipo': 'Faturas_das_encomendas', 'role': request.user_role})



@has_permission('encomenda')
def comp_stock(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM componentes_em_stock();")
        columns = [col[0] for col in cursor.description]
        comp_stock = cursor.fetchall()

    return render(request, 'lista.html', {'vista': comp_stock, 'columns': columns, 'tipo': 'comp_stock', 'role': request.user_role})

@has_permission('encomenda')
def encomendas(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_encomenda();")
        columns = [col[0] for col in cursor.description]
        encomendas = cursor.fetchall()

    return render(request, 'encomendas.html', {'vista': encomendas, 'columns': columns, 'tipo': 'Encomendas', 'role': request.user_role})

@has_permission('encomenda')
def export_encomendas_json(request):
    
    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM export_to_json();")
        encomenda = cursor.fetchall()

    return JsonResponse(encomenda)

@has_permission('encomenda')
def fatura_and_items(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_fatura_and_items();")
        columns = [col[0] for col in cursor.description]
        fatura_and_items = cursor.fetchall()

    return render(request, 'lista.html', {'vista': fatura_and_items, 'columns': columns, 'tipo': 'Faturas com os itens', 'role': request.user_role})

@has_permission('encomenda')
def itens_encomenda(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_itens_encomenda();")
        columns = [col[0] for col in cursor.description]
        itens_encomenda = cursor.fetchall()

    return render(request, 'lista.html', {'vista': itens_encomenda, 'columns': columns, 'tipo': 'Itens das encomendas', 'role': request.user_role})

@has_permission('encomenda')
def fazer_encomendas(request):

    if request.method == "POST":
        form = forms.Encomendas(request.POST)
        if form.is_valid():
            id_forn = form.cleaned_data['id_forn']
            notas_enc = form.cleaned_data['notas_enc']
            data_enc = form.cleaned_data['data_enc']
            cur = connections['default'].cursor()
            cur.execute("call public.proc_inserir_encomenda(%s, %s, %s, NULL);", [id_forn, notas_enc, data_enc])
            id_output = cur.fetchone()[0]
            redirect_url = f'/adicionar_Encomendas/{id_output}'
            return HttpResponseRedirect(redirect_url)
    else:
        form = forms.Encomendas()

    return render(request, 'adicionar.html', {'form': form, 'role': request.user_role})

@has_permission('encomenda')
def fazer_encomendas_2(request, encomenda_id):

    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM func_itens_enc_id(%s);", [encomenda_id])
        columns = [col[0] for col in cursor.description]
        item = cursor.fetchall()

    if request.method == "POST":
        form = forms.Itens_Encomendas(request.POST)
        if form.is_valid():
            componente = form.cleaned_data['componente']
            quantidade = form.cleaned_data['quantidade']
            cur = connections['default'].cursor()
            cur.execute("call public.proc_inserir_itens_encomenda(%s, %s, %s);", [encomenda_id, componente, quantidade])
            redirect_url = f'/adicionar_Encomendas/{encomenda_id}'
            return HttpResponseRedirect(redirect_url)  
    else:
        form = forms.Itens_Encomendas()

    return render(request, 'criar_enc.html', {'vista': item, 'columns': columns,'form': form, 'role': request.user_role})

@has_permission('encomenda')
def fornecedores(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_fornecedores();")
        columns = [col[0] for col in cursor.description]
        fornecedores = cursor.fetchall()

    return render(request, 'lista.html', {'vista': fornecedores, 'columns': columns, 'tipo': 'Fornecedores', 'role': request.user_role})


@has_permission('encomenda')
def eliminar_fornecedores(request, fornecedores_id):
    
    if request.method == "POST":
        cur = connections['default'].cursor()
        cur.execute("call public.proc_eliminar_fornecedores(%s);", [fornecedores_id])
        return redirect('http://127.0.0.1:8000/fornecedores')  
    return render(request, 'forn_eliminar_confirm.html', {'tipo': 'Fornecedores', 'role': request.user_role})

@has_permission('encomenda')
def adicionar_fornecedores(request):
    
    if request.method == "POST":
        form = forms.fornecedores(request.POST)
        if form.is_valid():
            nome_forn = form.cleaned_data['nome_forn']
            cur = connections['default'].cursor()
            cur.execute("call public.proc_inserir_fornecedor(%s);", [nome_forn])
            return redirect('http://127.0.0.1:8000/fornecedores')  
    else:
        form = forms.fornecedores()
    return render(request, 'adicionar.html', {'form': form, 'tipo': 'Fornecedores', 'role': request.user_role})



@has_permission('encomenda')
def editar_Fornecedores(request, fornecedores_id):

    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM func_fornecedores_id(%s);", [fornecedores_id])
        columns = [col[0] for col in cursor.description]
        fornecedores = cursor.fetchall()

    if request.method == 'POST':
        form = forms.fornecedores(request.POST)
        if form.is_valid():
            nome_forn = form.cleaned_data["nome_forn"]
            cur = connections['default'].cursor()
            cur.execute("CALL public.proc_editar_fornecedores(%s, %s);", [fornecedores_id, nome_forn])
            return redirect('http://127.0.0.1:8000/fornecedores')  
    else:
        form_initial_data = {}
        if fornecedores:
            fornecedor= fornecedores[0]
            for idx, column in enumerate(columns):
                form_initial_data[column] = fornecedor[idx]
        form = forms.fornecedores(initial=form_initial_data)
    
    return render(request, 'editar_registro.html', {'form': form, 'role': request.user_role})


@has_permission('encomenda')
def componentes(request):
    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM exibir_componentes();")
        columns = [col[0] for col in cursor.description]
        componentes = cursor.fetchall()

    return render(request, 'componentes.html', {'vista': componentes, 'columns': columns, 'tipo': 'Componentes', 'role': request.user_role})

@has_permission('encomenda')
def editar_componentes(request, componentes_id):

    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM func_componente_nome(%s);", [componentes_id])
        columns = [col[0] for col in cursor.description]
        componentes = cursor.fetchall()

    if request.method == 'POST':
        form = forms.Componentes(request.POST)
        if form.is_valid():
            nome_comp = form.cleaned_data["nome_comp"]
            desc_comp = form.cleaned_data["desc_comp"]
            cur = connections['default'].cursor()
            cur.execute("CALL public.proc_editar_componentes(%s, %s, %s);", [componentes_id, nome_comp, desc_comp])
            return redirect('http://127.0.0.1:8000/componentes')  
    else:
        form_initial_data = {}
        if componentes:
            component = componentes[0]
            for idx, column in enumerate(columns):
                form_initial_data[column] = component[idx]
        form = forms.Componentes(initial=form_initial_data)
    
    return render(request, 'editar_registro.html', {'form': form, 'role': request.user_role})


@has_permission('encomenda')
def componentes_import_json(request):
    if request.method == 'POST':
        arquivo_json = request.FILES.get('arquivo') 
        dados = json.loads(arquivo_json.read())
        # Faça algo com os dados (por exemplo, salve-os no banco de dados)
        with connections['default'].cursor() as cursor:
            cursor.execute('call public.proc_importar_json(%s);', [json.dumps(dados)])

    return redirect('http://127.0.0.1:8000/componentes')

@has_permission('encomenda')
def inserir_componentes(request):

    if request.method == "POST":
        form = forms.Componentes(request.POST)
        if form.is_valid():
            nome_comp = form.cleaned_data['nome_comp']
            desc_comp = form.cleaned_data['desc_comp']
            cur = connections['default'].cursor()
            cur.execute("call public.proc_inserir_componentes(%s, %s);", [nome_comp, desc_comp])
            redirect_url = f'/componentes'
            return HttpResponseRedirect(redirect_url)
    else:
        form = forms.Componentes()

    return render(request, 'adicionar.html', {'form': form, 'role': request.user_role})


#############################################################  LOGIN  ##########################################################################################

def user_login(request):
    if request.method == 'POST':
        form = forms.Login(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email']
            password = form.cleaned_data['password']
            
            # Autenticação no MongoDB
            user = authenticate_user(email, password)

            if user:
                # Crie uma instância do CustomUser e autentique o usuário na sessão
                custom_user, created = CustomUser.objects.get_or_create(email=email)
                login(request, custom_user)
                return redirect('http://127.0.0.1:8000/dashboard')
            else:
                messages.error(request, 'Invalid login credentials')
    else:
        form = forms.Login()  
    return render(request, 'login.html', {'form': form})

def custom_logout(request):
    logout(request)
    return redirect('http://127.0.0.1:8000/')
