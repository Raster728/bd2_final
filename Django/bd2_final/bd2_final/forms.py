from django import forms

from django.db import connections


class Equipamentos(forms.Form):
    nome_equipamento = forms.CharField(label='Nome do equipamento', max_length=100)
    tipo = forms.CharField(label='Tipo de equipamento')


class Componentes(forms.Form):
    nome_comp = forms.CharField(label='Nome do componente', max_length=100)
    desc_comp = forms.CharField(label='Descrição do componente', max_length=100)

class Clientes(forms.Form):
    nome_cliente = forms.CharField(label='Nome do cliente', max_length=100)

class Armazens(forms.Form):
    nome_arm = forms.CharField(label='Nome do armazem', max_length=100)
    setor = forms.CharField(label='Setor do armazem', max_length=100)
    notas = forms.CharField(label='Notas', max_length=100)

class Encomendas(forms.Form):
    with connections['default'].cursor() as cursor:
            cursor.execute("SELECT * FROM exibir_fornecedores();")
            fornecedores = cursor.fetchall()
        
    fornecedores_choices = [(fornecedor[0], fornecedor[1]) for fornecedor in fornecedores]

    id_forn = forms.ChoiceField(choices=fornecedores_choices, label='Fornecedor')
    notas_enc = forms.CharField(label='Notas da encomenda', max_length=100)
    data_enc = forms.DateField(label='Data da Encomenda', widget=forms.TextInput(attrs={'type': 'date'}))

class Itens_Encomendas(forms.Form):
    with connections['default'].cursor() as cursor:
            cursor.execute("SELECT * FROM exibir_componentes();")
            componentes = cursor.fetchall()
        
    componentes_choices = [(componente[0], componente[1]) for componente in componentes]
    componente = forms.ChoiceField(choices=componentes_choices, label='Componentes')
    quantidade = forms.IntegerField(label='Quantidade do componente')

class Guia_Remessa(forms.Form):
    with connections['default'].cursor() as cursor:
            cursor.execute("SELECT * FROM exibir_encomenda();")
            encomendas = cursor.fetchall()
        
    encomendas_choices = [(encomenda[0], encomenda[1]) for encomenda in encomendas]
    componente = forms.ChoiceField(choices=encomendas_choices, label='Componentes')
    quantidade = forms.IntegerField(label='Quantidade do componente')


class Login(forms.Form):
    username = forms.CharField(label='Nome do utilizador', max_length=100)
    password = forms.CharField(label='Palavra-Passe', max_length=100)