from django.http import HttpResponse, HttpResponseRedirect
from django.db import connections
from django.shortcuts import render, redirect
from . import forms
from .models import User
import pymongo
from datetime import date

conexaomongo = pymongo.MongoClient("mongodb://localhost:27017/")["trabalho_final"]


#############################################################  ADMIN  ##########################################################################################

def index(request):
    return render(request, 'index.html')


#############################################################  READ  ##########################################################################################

def armazens(request):
    
    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM exibir_armazem();")
        columns = [col[0] for col in cursor.description]
        armazem = cursor.fetchall()
    
    return render(request, 'lista.html', {'vista': armazem, 'columns': columns, 'tipo': 'Armazens'})

def clientes(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_clients();")
        columns = [col[0] for col in cursor.description]
        clientes = cursor.fetchall()

    return render(request, 'lista.html', {'vista': clientes, 'columns': columns, 'tipo': 'Clientes'})

def componentes(request):
    
    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM exibir_componentes();")
        columns = [col[0] for col in cursor.description]
        componentes = cursor.fetchall()

    return render(request, 'lista.html', {'vista': componentes, 'columns': columns, 'tipo': 'Componentes'})


def encomendas(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_encomenda();")
        columns = [col[0] for col in cursor.description]
        encomendas = cursor.fetchall()

    return render(request, 'lista.html', {'vista': encomendas, 'columns': columns, 'tipo': 'Encomendas'})

def equipamentos(request):
    
    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM exibir_equipamentos();")
        columns = [col[0] for col in cursor.description]
        equipamentos = cursor.fetchall()

    return render(request, 'equipamentos.html', {'vista': equipamentos, 'columns': columns, 'tipo': 'Equipamentos'})



def equipamentos_armazenados(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_equipamentos_armazenados();")
        columns = [col[0] for col in cursor.description]
        equipamentos_armazenados = cursor.fetchall()

    return render(request, 'equipamentos_armazenados.html', {'vista': equipamentos_armazenados, 'columns': columns, 'tipo': 'Equipamentos_armazenados'})

def fatura_and_items(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_fatura_and_items();")
        columns = [col[0] for col in cursor.description]
        fatura_and_items = cursor.fetchall()

    return render(request, 'lista.html', {'vista': fatura_and_items, 'columns': columns, 'tipo': 'Faturas com os itens'})

def fatura_encomenda(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_fatura_encomenda();")
        columns = [col[0] for col in cursor.description]
        fatura_encomenda = cursor.fetchall()

    return render(request, 'lista.html', {'vista': fatura_encomenda, 'columns': columns, 'tipo': 'Faturas_das_encomendas'})

def fornecedores(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_fornecedores();")
        columns = [col[0] for col in cursor.description]
        fornecedores = cursor.fetchall()

    return render(request, 'lista.html', {'vista': fornecedores, 'columns': columns, 'tipo': 'Fornecedores'})

def guia_remessa(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_guia_remessa();")
        columns = [col[0] for col in cursor.description]
        guia_remessa = cursor.fetchall()

    return render(request, 'lista.html', {'vista': guia_remessa, 'columns': columns, 'tipo': 'Guias'})

def itens_encomenda(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_itens_encomenda();")
        columns = [col[0] for col in cursor.description]
        itens_encomenda = cursor.fetchall()

    return render(request, 'lista.html', {'vista': itens_encomenda, 'columns': columns, 'tipo': 'Itens das encomendas'})

def itens_remessa(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_itens_remessa();")
        columns = [col[0] for col in cursor.description]
        itens_remessa = cursor.fetchall()

    return render(request, 'lista.html', {'vista': itens_remessa, 'columns': columns, 'tipo': 'Itens_das_remessas'})

def mao_obra(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_mo();")
        columns = [col[0] for col in cursor.description]
        mao_obra = cursor.fetchall()

    return render(request, 'lista.html', {'vista': mao_obra, 'columns': columns, 'tipo': 'Mao_de_obra'})

#############################################################  UPDATE  ##########################################################################################

def editar_equipamentos(request, equipamentos_id):

    with connections['default'].cursor() as cursor:
        query = "SELECT * FROM func_equipamento_nome(%s);"
        cursor.execute(query, [equipamentos_id])
        columns = [col[0] for col in cursor.description]
        equipamentos = cursor.fetchall()

    if request.method == 'POST':
        form = forms.Equipamentos(request.POST)
        if form.is_valid():
            nome_equ = form.cleaned_data["nome_equipamento"]
            tipo = form.cleaned_data["tipo"]
            cur = connections['default'].cursor()
            cur.execute("SELECT public.editar_equipamentos(%s, %s, %s);", [equipamentos_id, nome_equ, tipo])
            return redirect('http://127.0.0.1:8000/equipamentos')  
    else:
        form_initial_data = {}
        if equipamentos:
            equipamento = equipamentos[0]
            for idx, column in enumerate(columns):
                form_initial_data[column] = equipamento[idx]
        form = forms.Equipamentos(initial=form_initial_data)
    
    return render(request, 'editar_registro.html', {'form': form})


def editar_componentes(request, componentes_id):

    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM func_componente_nome(%s);", [componentes_id])
        columns = [col[0] for col in cursor.description]
        componentes = cursor.fetchall()

    if request.method == 'POST':
        form = forms.Componentes(request.POST)
        if form.is_valid():
            nome_comp = form.cleaned_data["nome_componente"]
            desc_comp = form.cleaned_data["desc_componente"]
            cur = connections['default'].cursor()
            cur.execute("SELECT public.editar_componentes(%s, %s, %s);", [componentes_id, nome_comp, desc_comp])
            return redirect('http://127.0.0.1:8000/componentes')  
    else:
        form_initial_data = {}
        if componentes:
            component = componentes[0]
            for idx, column in enumerate(columns):
                form_initial_data[column] = component[idx]
        form = forms.Componentes(initial=form_initial_data)
    
    return render(request, 'editar_registro.html', {'form': form})

def editar_clientes(request, clientes_id):

    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM func_cliente_id(%s);", [clientes_id])
        columns = [col[0] for col in cursor.description]
        clientes = cursor.fetchall()

    if request.method == 'POST':
        form = forms.Clientes(request.POST)
        if form.is_valid():
            nome_cliente = form.cleaned_data["nome_cliente"]
            cur = connections['default'].cursor()
            cur.execute("SELECT public.editar_clients(%s, %s);", [clientes_id, nome_cliente])
            return redirect('http://127.0.0.1:8000/clientes')  
    else:
        form_initial_data = {}
        if clientes:
            cliente = clientes[0]
            for idx, column in enumerate(columns):
                form_initial_data[column] = cliente[idx]
        form = forms.Clientes(initial=form_initial_data)
    
    return render(request, 'editar_registro.html', {'form': form})

def editar_armazens(request, armazens_id):

    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM func_armazem_id(%s);", [armazens_id])
        columns = [col[0] for col in cursor.description]
        armazens = cursor.fetchall()

    if request.method == 'POST':
        form = forms.Armazens(request.POST)
        if form.is_valid():
            nome_arm = form.cleaned_data["nome_arm"]
            setor = form.cleaned_data["setor"]
            notas = form.cleaned_data["notas"]
            cur = connections['default'].cursor()
            cur.execute("SELECT public.editar_armazem(%s, %s, %s, %s);", [armazens_id, nome_arm, setor, notas])
            return redirect('http://127.0.0.1:8000/armazens')  
    else:
        form_initial_data = {}
        if armazens:
            armazem = armazens[0]
            for idx, column in enumerate(columns):
                form_initial_data[column] = armazem[idx]
        form = forms.Armazens(initial=form_initial_data)
    
    return render(request, 'editar_registro.html', {'form': form})

def editar_Fatura_encomenda(request, fatura_encomenda_id):

    with connections['default'].cursor() as cursor:
        cursor.execute("SELECT * FROM func_fatura_id(%s);", [fatura_encomenda_id])
        columns = [col[0] for col in cursor.description]
        faturas_encomenda = cursor.fetchall()

    if request.method == 'POST':
        form = forms.fatura_encomenda(request.POST)
        if form.is_valid():
            preco_total_enc = form.cleaned_data["preco_total_enc"]
            cur = connections['default'].cursor()
            cur.execute("SELECT public.editar_fatura_encomenda(%s, %s);", [fatura_encomenda_id, preco_total_enc])
            return redirect('http://127.0.0.1:8000/fatura_encomenda')  
    else:
        form_initial_data = {}
        if faturas_encomenda:
            fatura_encomenda = faturas_encomenda[0]
            for idx, column in enumerate(columns):
                form_initial_data[column] = fatura_encomenda[idx]
        form = forms.fatura_encomenda(initial=form_initial_data)
    
    return render(request, 'editar_registro.html', {'form': form})

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
            cur.execute("SELECT public.editar_fornecedores(%s, %s);", [fornecedores_id, nome_forn])
            return redirect('http://127.0.0.1:8000/fornecedores')  
    else:
        form_initial_data = {}
        if fornecedores:
            fornecedor= fornecedores[0]
            for idx, column in enumerate(columns):
                form_initial_data[column] = fornecedor[idx]
        form = forms.fornecedores(initial=form_initial_data)
    
    return render(request, 'editar_registro.html', {'form': form})

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
    
    return render(request, 'editar_registro.html', {'form': form})

#############################################################  CREATE  ##########################################################################################


def adicionar_clientes(request):

    if request.method == "POST":
        form = forms.Clientes(request.POST)
        if form.is_valid():
            nome_cliente = form.cleaned_data['nome_cliente']
            cur = connections['default'].cursor()
            cur.execute("call public.proc_inserir_cliente(%s);", [nome_cliente,])
            return redirect('http://127.0.0.1:8000/clientes')  
    else:
        form = forms.Clientes()
    return render(request, 'adicionar.html', {'form': form})


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

    return render(request, 'adicionar.html', {'form': form})

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

    return render(request, 'criar_enc.html', {'vista': item, 'columns': columns,'form': form})

def escolher_enc_para_guia(request):
    current_datetime = date.today()
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_encomenda();")
        columns = [col[0] for col in cursor.description]
        encomendas = cursor.fetchall()

        cursor.execute("call public.proc_inserir_guia_remessa(%s, NULL);", [current_datetime])
        id_output = cursor.fetchone()[0]

    return render(request, 'enc_guias.html', {'vista': encomendas, 'columns': columns, 'tipo': 'Guias', 'guia': id_output})

def criar_guia(request, encomenda_id, guia_id):
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM func_itens_enc_id_com_id(%s);", [encomenda_id])
        columns = [col[0] for col in cursor.description]
        encomendas = cursor.fetchall()

    return render(request, 'item_enc_para_guia.html', {'vista': encomendas, 'columns': columns, 'tipo': 'Guias', 'guia': guia_id, 'encomenda': encomenda_id})

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

    return render(request, 'adicionar.html', {'form': form, 'tipo': 'Guias', 'guia': guia_id, 'encomenda': encomenda_id})



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

    return render(request, 'adicionar.html', {'form': form})

def criar_Ficha_Producao(request, equipamento_id):
    if request.method == "POST":
        form = forms.Ficha_Producao(request.POST)
        if form.is_valid():
            custo_producao = form.cleaned_data['custo_producao']
            cur = connections['default'].cursor()
            cur.execute("call public.proc_inserir_ficha_producao(%s, %s, NULL);", [equipamento_id, custo_producao])
            id_output = cur.fetchone()[0]
            redirect_url = f'/criar_Ficha_Item/{id_output}/'
            return HttpResponseRedirect(redirect_url)  
    else:
        form = forms.Ficha_Producao()

    return render(request, 'adicionar.html', {'form': form})

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
            cur.execute("call public.proc_inserir_componentes_producao(%s, %s, %s);", [componente, ficha_prod_id, quantidade_usada])
            redirect_url = f'/criar_Ficha_Item/{ficha_prod_id}/'
            return HttpResponseRedirect(redirect_url)  
    else:
        form = forms.Componentes_Producao()

    return render(request, 'criar_ficha_comp.html', {'form': form, 'vista': encomendas, 'columns': columns, 'ficha': ficha_prod_id})

def mo_ficha_prod(request, ficha_prod_id):

    if request.method == "POST":
        form = forms.Mao_Obra_Usada(request.POST)
        if form.is_valid():
            id_mao_obra = form.cleaned_data['id_mao_obra']
            hora_inicio = form.cleaned_data['hora_inicio']
            hora_fim = form.cleaned_data['hora_fim']
            cur = connections['default'].cursor()
            cur.execute("call public.proc_inserir_mo_usada(%s, %s, %s, %s);", [ficha_prod_id, id_mao_obra, hora_inicio, hora_fim])
            return redirect('http://127.0.0.1:8000/equipamentos')
    else:
        form = forms.Mao_Obra_Usada()

    return render(request, 'adicionar.html', {'form': form})


#############################################################  LOGIN  ##########################################################################################

def login_view(request):
    if request.method == 'POST':
        form = forms.Login(request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            bd = conexaomongo
            col = bd["users"]
            utilizador = col.find_one({'username': username})
            if utilizador:
                palavra_passe = utilizador.get('password')
                if (password == palavra_passe):
                    return redirect('http://127.0.0.1:8000/clientes')
    else: 
        form = forms.Login()
    return render(request, 'login.html', {'form': form})

#############################################################  EXPORTAR PARA MONGO  ##########################################################################################

def exportar_equipamento(request, equipamentos_id):
    with connections['default'].cursor() as cursor:
        query = "SELECT * FROM func_equipamento_nome(%s);"
        cursor.execute(query, [equipamentos_id])
        columns = [col[0] for col in cursor.description]
        equipamentos = cursor.fetchall()

    if request.method == 'POST':
        form = forms.EquipamentosExportados(request.POST)

        if form.is_valid():
            pgsid_eq_arm = form.cleaned_data['pgsid_eq_arm']
            nome_equipamento = form.cleaned_data['nome_equipamento']
            atributoum = form.cleaned_data['atributoum']
            valorum = form.cleaned_data['valorum']
            atributodois = form.cleaned_data['atributodois']
            valordois = form.cleaned_data['valordois']
            atributotres = form.cleaned_data['atributotres']
            valortres = form.cleaned_data['valortres']
            atributoquatro = form.cleaned_data['atributoquatro']
            valorquatro = form.cleaned_data['valorquatro']

            db = conexaomongo
            produtos_collection = db["produtos"]

            novo_equipamento = {
                'pgsid_eq_arm': pgsid_eq_arm,
                'nome_equipamento': nome_equipamento,
                atributoum : valorum,
                atributodois : valordois,
                atributotres : valortres,
                atributoquatro : valorquatro,
            }

            produtos_collection.insert_one(novo_equipamento)
                
            return redirect('http://127.0.0.1:8000/equipamentos')

    else:
        form = forms.EquipamentosExportados()  
        
    return render(request, 'exportar.html', {'form': form, 'columns': columns, 'equipamentos': equipamentos})
    
