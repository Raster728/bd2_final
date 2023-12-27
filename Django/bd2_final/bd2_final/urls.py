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
    path('editar_registro/<int:registro_id>/', views.encomendas, name='editar_registro'),
    path('editar_Equipamentos/<int:equipamentos_id>/', views.editar_equipamentos, name='editar_Equipamentos'),
    
]