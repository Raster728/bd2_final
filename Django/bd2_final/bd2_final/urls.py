"""
URL configuration for bd2_final project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from django.urls import include
from . import views

urlpatterns = [

    #############################################################  ADMIN  ##########################################################################################

    path ('', views.index, name='index'), 
    path('login/', views.login_view, name='login'),
    path('Vendas/', views.clientes, name='vendas'),
    path('Producao/', views.equipamentos, name='producao'),
    path('Encomendas/', views.encomendas, name='encomendas'),
    
    #############################################################  READ  ##########################################################################################

    path('armazens', views.armazens, name="vista_armazens"),
    path('clientes', views.clientes, name="vista_clientes"),
    path('componentes', views.componentes, name="vista_componentes"),
    path('encomendas', views.encomendas, name="vista_encomendas"),
    path('equipamentos', views.equipamentos, name="vista_equipamentos"),
    path('equipamentos_armazenados', views.equipamentos_armazenados, name="vista_equipamentos_armazenados"),
    path('fatura_and_items', views.fatura_and_items, name="vista_fatura_and_items"),
    path('fatura_encomenda', views.fatura_encomenda, name="vista_fatura_encomenda"),
    path('fornecedores', views.fornecedores, name="vista_fornecedores"),
    path('guia_remessa', views.guia_remessa, name="vista_guia_remessa"),
    path('itens_encomenda', views.itens_encomenda, name="vista_itens_encomenda"),
    path('itens_remessa', views.itens_remessa, name="vista_itens_remessa"),
    path('mao_obra', views.mao_obra, name="vista_mao_obra"),

    #############################################################  UPDATE  ##########################################################################################

    path('editar_Equipamentos/<int:equipamentos_id>/', views.editar_equipamentos, name='editar_Equipamentos'),
    path('editar_Componentes/<int:componentes_id>/', views.editar_componentes, name='editar_Componentes'),
    path('editar_Clientes/<int:clientes_id>/', views.editar_clientes, name='editar_Clientes'),
    path('editar_Armazens/<int:armazens_id>/', views.editar_armazens, name='editar_Armazens'),
    path('editar_Faturas_das_encomendas/<int:fatura_encomenda_id>/', views.editar_Fatura_encomenda, name='editar_Fatura_encomenda'),
    path('editar_Fornecedores/<int:fornecedores_id>/', views.editar_Fornecedores, name='editar_Fornecedores'),
    path('editar_Mao_de_obra/<int:mao_obra_id>/', views.editar_Mao_de_obra, name='editar_Mao_de_obra'),

    #############################################################  CREATE  ##########################################################################################

    path('adicionar_Clientes', views.adicionar_clientes, name='adicionar_Clientes'),
    path('adicionar_Encomendas', views.fazer_encomendas, name='adicionar_Encomenda'),
    path('adicionar_Encomendas/<int:encomenda_id>/', views.fazer_encomendas_2, name='adicionar_Encomenda_item'),

    path('adicionar_Guias', views.escolher_enc_para_guia, name='adicionar_Encomenda_guia'),
    path('editar_Guias/<int:encomenda_id>/<int:guia_id>/', views.criar_guia, name='adicionar_Guias_item'),
    path('editar_Guias/<int:encomenda_id>/<int:guia_id>/<int:item_id>/<int:quantidade_id>', views.adicionar_itens_guia, name='adicionar_Guias_item_retirar'),

    path('adicionar_Equipamentos', views.criar_equipamentos, name='adicionar_Equipamentos'),
    path('criar_Ficha/<int:equipamento_id>/', views.criar_Ficha_Producao, name='adicionar_Ficha'),
    path('criar_Ficha_Item/<int:ficha_prod_id>/', views.itens_ficha_prod, name='criar_Ficha_Itens'),
    path('criar_Ficha_MO/<int:ficha_prod_id>/', views.mo_ficha_prod, name='criar_Ficha_MO'),
]
