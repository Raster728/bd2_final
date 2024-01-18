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
    path('', views.user_login, name='login'),
    path('logout/', views.custom_logout, name='logout'),

    path ('dashboard', views.index, name='index'), 
    
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
    path('armazenar/<int:ficha_prod_id>', views.armazem_fichaprod_eq_arm, name="armazenar"),

    path('fatura_and_items', views.fatura_and_items, name="vista_fatura_and_items"),
    path('fatura_encomenda', views.fatura_encomenda, name="vista_fatura_encomenda"),
    path('fatura_encomenda_armazem', views.fatura_encomenda_armazem, name="vista_fatura_encomenda_armazem"),


    path('fatura_venda', views.fatura_venda, name="vista_fatura_venda"),
    path('ver_fatura/<int:fatura_id>', views.fatura_venda_ver, name="ver_fatura"),
    
    
    


    path('fornecedores', views.fornecedores, name="vista_fornecedores"),
    path('guia_remessa', views.guia_remessa, name="vista_guia_remessa"),
    path('itens_encomenda', views.itens_encomenda, name="vista_itens_encomenda"),
    path('itens_remessa', views.itens_remessa, name="vista_itens_remessa"),
    path('mao_obra', views.mao_obra, name="vista_mao_obra"),


    path('comp_stock', views.comp_stock, name="comp_stock"),
    path('comp_stock_prod', views.comp_stock_prod, name="comp_stock_prod"),
    


    path('fichas_producao', views.ficha_prod, name="fichas_producao"),
    path('ficha_prod_producao', views.ficha_prod_producao, name="ficha_prod_producao"),
    

    #############################################################  UPDATE  ##########################################################################################

    path('editar_Componentes/<int:componentes_id>/', views.editar_componentes, name='editar_Componentes'),


    path('editar_Clientes/<int:clientes_id>/', views.editar_clientes, name='editar_Clientes'),
    path('eliminar_Clientes/<int:clientes_id>/', views.eliminar_clientes, name='eliminar_Clientes'),



    path('editar_Fornecedores/<int:fornecedores_id>/', views.editar_Fornecedores, name='editar_Fornecedores'),
    path('eliminar_Fornecedores/<int:fornecedores_id>/', views.eliminar_fornecedores, name='eliminar_Fornecedores'),
    path('adicionar_Fornecedores', views.adicionar_fornecedores, name='adicionar_Fornecedores'),

    path('editar_Mao_de_obra/<int:mao_obra_id>/', views.editar_Mao_de_obra, name='editar_Mao_de_obra'),

    #############################################################  CREATE  ##########################################################################################

    path('adicionar_Clientes', views.adicionar_clientes, name='adicionar_Clientes'),
    path('adicionar_Encomendas', views.fazer_encomendas, name='adicionar_Encomenda'),
    path('adicionar_Encomendas/<int:encomenda_id>/', views.fazer_encomendas_2, name='adicionar_Encomenda_item'),
    path('export-encomendas/json/', views.export_encomendas_json, name='export_to_json'),

    path('adicionar_Guias', views.escolher_enc_para_guia, name='adicionar_Encomenda_guia'),
    path('editar_Guias/<int:encomenda_id>/<int:guia_id>/', views.criar_guia, name='adicionar_Guias_item'),
    path('editar_Guias/<int:encomenda_id>/<int:guia_id>/<int:item_id>/<int:quantidade_id>', views.adicionar_itens_guia, name='adicionar_Guias_item_retirar'),
    path('fatura_encomenda/<int:guia_id>/<int:encomenda_id>/<int:fatura_id>/', views.criar_fatura_enc, name='fatura_encomenda'),
    path('fatura/<int:guia_id>/<int:encomenda_id>/', views.fatura, name='fatura'),
    path('preco_item/<int:item_id>/<int:fatura_id>/<int:guia_id>/<int:encomenda_id>/', views.preco_por_item, name='preco_item'),

    path('adicionar_Equipamentos', views.criar_equipamentos, name='adicionar_Equipamentos'),
    path('criar_Ficha/<int:equipamento_id>/', views.criar_Ficha_Producao, name='adicionar_Ficha'),
    path('criar_Ficha_Item/<int:ficha_prod_id>/', views.itens_ficha_prod, name='criar_Ficha_Itens'),
    path('criar_Ficha_MO/<int:ficha_prod_id>/', views.mo_ficha_prod, name='criar_Ficha_MO'),


    path('componentes_import_json', views.componentes_import_json, name="componentes_import_json"),
    #############################################################  MONGO  ##########################################################################################

    path('exportar_Equipamentos_armazenados/<int:equipamentos_id>/', views.exportar_equipamento, name='exportar'),

    #############################################################  VENDER PRODUTO  ##########################################################################################

    path('produtos', views.produtos, name='produtos'),
    path('vender_produto/<int:eq_id>/<int:cliente_id>', views.vender_produto, name='vender_produto'),
    path('ver_produto/<int:eq_id>', views.ver_produto, name='ver_produto'),
    path('produtos/<int:cliente_id>', views.produtos_cliente, name='produtos_cliente'),
    path('escolher_cliente/', views.escolher_cliente, name='escolher_cliente'),

    path('carrinho/<int:cliente_id>', views.carrinho, name='carrinho'),
    path('concluir_compra/<int:cliente_id>', views.concluir_compra, name='concluir_compra'),
    

]
