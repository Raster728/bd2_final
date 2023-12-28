from django.http import HttpResponse
from django.db import connection
from django.shortcuts import render
from .forms import Equipamentos



def armazens(request):
    
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM exibir_armazem();")
    columns = [col[0] for col in cursor.description]
    armazem = cursor.fetchall()
    
    return render(request, 'lista.html', {'vista': armazem, 'columns': columns, 'tipo': 'Armazens'})

def clientes(request):
    
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM exibir_clients();")
    columns = [col[0] for col in cursor.description]
    clientes = cursor.fetchall()

    return render(request, 'lista.html', {'vista': clientes, 'columns': columns, 'tipo': 'Clientes'})

def componentes(request):
    
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM exibir_componentes();")
    columns = [col[0] for col in cursor.description]
    componentes = cursor.fetchall()

    return render(request, 'lista.html', {'vista': componentes, 'columns': columns, 'tipo': 'Componentes'})


def encomendas(request):
    
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM exibir_encomenda();")
    columns = [col[0] for col in cursor.description]
    encomendas = cursor.fetchall()

    return render(request, 'lista.html', {'vista': encomendas, 'columns': columns, 'tipo': 'Encomendas'})

def equipamentos(request):
    
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM exibir_equipamentos();")
    columns = [col[0] for col in cursor.description]
    equipamentos = cursor.fetchall()

    return render(request, 'lista.html', {'vista': equipamentos, 'columns': columns, 'tipo': 'Equipamentos'})


def editar_equipamentos(request, equipamentos_id):

    cursor = connection.cursor()

    query = "SELECT * FROM func_equipamento_nome(%s);"
    cursor.execute(query, [equipamentos_id])
    columns = [col[0] for col in cursor.description]
    equipamentos = cursor.fetchall()

    if request.method == 'POST':
        form = Equipamentos(request.POST)
        if form.is_valid():
            nome_equ = form.cleaned_data["nome_equipamento"]
    else:
        form = Equipamentos()
    
    return render(request, 'editar_registro.html', {'form': form, 'vista': equipamentos, 'columns': columns})




def equipamentos_armazenados(request):
    
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM exibir_equipamentos_armazenados();")
    columns = [col[0] for col in cursor.description]
    equipamentos_armazenados = cursor.fetchall()

    return render(request, 'lista.html', {'vista': equipamentos_armazenados, 'columns': columns, 'tipo': 'Equipamentos armazenados'})

def fatura_and_items(request):
    
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM exibir_fatura_and_items();")
    columns = [col[0] for col in cursor.description]
    fatura_and_items = cursor.fetchall()

    return render(request, 'lista.html', {'vista': fatura_and_items, 'columns': columns, 'tipo': 'Faturas com os itens'})

def fatura_encomenda(request):
    
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM exibir_fatura_encomenda();")
    columns = [col[0] for col in cursor.description]
    fatura_encomenda = cursor.fetchall()

    return render(request, 'lista.html', {'vista': fatura_encomenda, 'columns': columns, 'tipo': 'Faturas das encomendas'})

def fornecedores(request):
    
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM exibir_fornecedores();")
    columns = [col[0] for col in cursor.description]
    fornecedores = cursor.fetchall()

    return render(request, 'lista.html', {'vista': fornecedores, 'columns': columns, 'tipo': 'Fornecedores'})

def guia_remessa(request):
    
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM exibir_guia_remessa();")
    columns = [col[0] for col in cursor.description]
    guia_remessa = cursor.fetchall()

    return render(request, 'lista.html', {'vista': guia_remessa, 'columns': columns, 'tipo': 'Guias de remessa'})

def itens_encomenda(request):
    
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM exibir_itens_encomenda();")
    columns = [col[0] for col in cursor.description]
    itens_encomenda = cursor.fetchall()

    return render(request, 'lista.html', {'vista': itens_encomenda, 'columns': columns, 'tipo': 'Itens das encomendas'})

def itens_remessa(request):
    
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM exibir_itens_remessa();")
    columns = [col[0] for col in cursor.description]
    itens_remessa = cursor.fetchall()

    return render(request, 'lista.html', {'vista': itens_remessa, 'columns': columns, 'tipo': 'Itens das remessas'})