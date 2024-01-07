from django import forms
from django.db import connections


class mao_de_obra(forms.Form):
    nome_mo = forms.CharField(label='Nome da mão de obra', max_length=100)
    custo_mo = forms.CharField(label='Custo da mão de obra')
    tipo_mo = forms.CharField(label='Tipo de mão de obra', max_length=100)


class fornecedores(forms.Form):
    nome_forn = forms.CharField(label='Nome Fornecedor', max_length=100)


class fatura_encomenda(forms.Form):
    preco_total_enc = forms.CharField(label='Preço Total Encomenda')


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
            cursor.execute("SELECT * FROM exibir_armazem();")
            armazens = cursor.fetchall()
        
    armazens_choices = [(armazem[0], armazem[1]) for armazem in armazens]
    armazem = forms.ChoiceField(choices=armazens_choices, label='Armazem')
    quantidade = forms.IntegerField(label='Quantidade do componente que chegou')


class Login(forms.Form):
    username = forms.CharField(label='Nome do utilizador', max_length=100)
    password = forms.CharField(label='Palavra-Passe', max_length=100)

class EquipamentosExportados(forms.Form):
    pgsid_eq_arm = forms.CharField(label='ID do equipamento')
    nome_equipamento = forms.CharField(label='Nome do equipamento', max_length=100)
    atributoum = forms.CharField(label='Novo Atributo', max_length=100)
    valorum = forms.CharField(label='Valor', max_length=100)
    atributodois = forms.CharField(label='Novo Atributo', max_length=100)
    valordois = forms.CharField(label='Valor', max_length=100)
    atributotres = forms.CharField(label='Novo Atributo', max_length=100)
    valortres = forms.CharField(label='Valor', max_length=100)
    atributoquatro = forms.CharField(label='Novo Atributo', max_length=100)
    valorquatro = forms.CharField(label='Valor', max_length=100)
