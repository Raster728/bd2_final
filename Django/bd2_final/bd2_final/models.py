from django.db import models
from django.contrib.auth.hashers import make_password, check_password

class User(models.Model):
    _id = models.IntegerField()
    username = models.CharField(max_length=150)
    password = models.CharField(max_length=128)

