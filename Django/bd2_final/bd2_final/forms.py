from django import forms


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


class Login(forms.Form):
    username = forms.CharField(label='Nome do utilizador', max_length=100)
    password = forms.CharField(label='Palavra-Passe', max_length=100)