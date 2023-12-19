from django.http import HttpResponse
from django.db import connection
from django.shortcuts import render

def index(request):
    
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM exibir_armazem();")
    columns = [col[0] for col in cursor.description]


    cursor.execute("SELECT * FROM exibir_armazem();")
    armazem = cursor.fetchall()
    return render(request, 'lista.html', {'armazem': armazem, 'columns': columns})