@echo off


git clone https://github.com/Raster728/bd2_final.git


cd bd2_final/Django/bd2_final
python manage.py makemigrations
python manage.py migrate
python manage.py runserver