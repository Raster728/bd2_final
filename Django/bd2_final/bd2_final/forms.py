from django import forms


class Equipamentos(forms.Form):
    nome_equipamento = forms.CharField(label='Nome do equipamento', max_length=100)
    tipo = forms.CharField(label='Tipo de equipamento')


class Componentes(forms.Form):
    nome_comp = forms.CharField(label='Nome do componente', max_length=100)
    desc_comp = forms.CharField(label='Descrição do componente', max_length=100)

class Clientes(forms.Form):
    nome_cliente = forms.CharField(label='Nome do cliente', max_length=100)