# utils.py

import pymongo
from django.http import HttpResponseForbidden
from functools import wraps


conexaomongo = pymongo.MongoClient("mongodb://localhost:27017/")["trabalho_final"]

def authenticate_user(email, password):
    # Conecte-se ao MongoDB
    db = conexaomongo
    col = db['users']

    # Consulte o usuário pelo e-mail e senha
    user = col.find_one({'email': email, 'password': password})

    return user


def has_permission(permission):
    def decorator(view_func):
        @wraps(view_func)
        def _wrapped_view(request, *args, **kwargs):
            
            # Conecte-se ao MongoDB
            if request.user.is_authenticated:
                # Connect to MongoDB
                db = conexaomongo
                col = db['users']

                # Query the user by email
                user = col.find_one({'email': request.user.email})
                # Check if the user has the specified permission
                request.user_role = user.get('role', None)
                if user and user.get('role') == permission:
                    return view_func(request, *args, **kwargs)
            return HttpResponseForbidden("You don't have permission to access this page.")
        return _wrapped_view
    return decorator
