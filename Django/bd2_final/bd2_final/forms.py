from django import forms
from django.db import connections
from django.core.validators import MaxValueValidator
from datetime import datetime, timezone

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
    nif = forms.CharField(label='NIF', max_length=100)

class Procura_cliente(forms.Form):
    nif = forms.CharField(label='NIF', max_length=100)

class Armazens(forms.Form):
    nome_arm = forms.CharField(label='Nome do armazem', max_length=100)
    setor = forms.CharField(label='Setor do armazem', max_length=100)
    notas = forms.CharField(label='Notas', max_length=100)

class item_fatura(forms.Form):
    preco = forms.CharField(label='Custo de cada componente', max_length=100)

class Ficha_Producao(forms.Form):
    custo_producao = forms.CharField(label='Custo da producao', max_length=100)

class Mao_Obra_Usada(forms.Form):
    with connections['default'].cursor() as cursor:
            cursor.execute("SELECT * FROM exibir_mo();")
            mos = cursor.fetchall()
        
    mos_choices = [(mo[0], mo[1]) for mo in mos]
    
    id_mao_obra = forms.ChoiceField(choices=mos_choices, label='Mão de obra utilizada')
    hora_inicio = forms.DateField(label='Hora de comeco da mao de obra',  widget=forms.TextInput(attrs={'type': 'date'}))
    hora_fim = forms.DateField(label='Hora de fim da mao de obra',  widget=forms.TextInput(attrs={'type': 'date'}))

class Encomendas(forms.Form):
    with connections['default'].cursor() as cursor:
            cursor.execute("SELECT * FROM exibir_fornecedores();")
            fornecedores = cursor.fetchall()
        
    fornecedores_choices = [(fornecedor[0], fornecedor[1]) for fornecedor in fornecedores]

    id_forn = forms.ChoiceField(choices=fornecedores_choices, label='Fornecedor')
    notas_enc = forms.CharField(label='Notas da encomenda', max_length=100)
    data_enc = forms.DateTimeField(label='Data da Encomenda', widget=forms.DateTimeInput(attrs={'type': 'datetime-local'}))
    def clean_data_enc(self):
        data_enc = self.cleaned_data['data_enc']


        # Convert to UTC to store in the database without timezone info
        data_enc_utc = data_enc.astimezone(timezone.utc)

        # Remove timezone information
        data_enc_utc = data_enc_utc.replace(tzinfo=None)

        return data_enc_utc

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


class Componentes_Producao(forms.Form):
    with connections['default'].cursor() as cursor:
            cursor.execute("SELECT * FROM componentes_em_stock();")
            componentes = cursor.fetchall()
        
    componentes_choices = [(componente[0], componente[2]) for componente in componentes]

    componente = forms.ChoiceField(choices=componentes_choices, label='Componentes')
    quantidade_usada = forms.IntegerField(label='Quantidade do componente usado')


class Equipamentos_armazenados(forms.Form):
    with connections['default'].cursor() as cursor:
            cursor.execute("SELECT * FROM exibir_armazem();")
            armazens = cursor.fetchall()
        
    armazens_choices = [(armazem[0], armazem[1]) for armazem in armazens]

    armazem = forms.ChoiceField(choices=armazens_choices, label='Armazens')


class Login(forms.Form):
    email = forms.CharField(label='email', max_length=100)
    password = forms.CharField(label='Palavra-Passe', max_length=100)

class EquipamentosExportados(forms.Form):
    nome_equipamento = forms.CharField(label='Nome do equipamento', max_length=100)
    atributo = forms.CharField(label='Novo Atributo', max_length=100)
    valorum = forms.CharField(label='Valor', max_length=100)
