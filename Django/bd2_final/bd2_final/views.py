from django.http import HttpResponse
from django.db import connections
from django.shortcuts import render, redirect
from . import forms
from .models import User
import pymongo
from django.contrib.auth.hashers import check_password

conexaomongo = pymongo.MongoClient("mongodb://localhost:27017/")["trabalho_final"]

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

    return render(request, 'lista.html', {'vista': equipamentos, 'columns': columns, 'tipo': 'Equipamentos'})



def equipamentos_armazenados(request):
    
    with connections['default'].cursor() as cursor:

        cursor.execute("SELECT * FROM exibir_equipamentos_armazenados();")
        columns = [col[0] for col in cursor.description]
        equipamentos_armazenados = cursor.fetchall()

    return render(request, 'lista.html', {'vista': equipamentos_armazenados, 'columns': columns, 'tipo': 'Equipamentos armazenados'})

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

    return render(request, 'lista.html', {'vista': fatura_encomenda, 'columns': columns, 'tipo': 'Faturas das encomendas'})

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

    return render(request, 'lista.html', {'vista': guia_remessa, 'columns': columns, 'tipo': 'Guias de remessa'})

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

    return render(request, 'lista.html', {'vista': itens_remessa, 'columns': columns, 'tipo': 'Itens das remessas'})


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
    
