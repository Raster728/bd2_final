from django.http import HttpResponse
from django.db import connections
from django.shortcuts import render, redirect
from . import forms

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