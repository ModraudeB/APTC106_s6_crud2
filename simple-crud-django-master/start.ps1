# Script de inicio para Windows PowerShell
# Inicia el backend Django y el frontend Flutter en terminales separadas

# Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
# .\start.ps1
Start-Process powershell -ArgumentList '-NoExit', '-Command', 'cd "C:\Users\Eduardo\Documents\APTC106_s6_crud2\simple-crud-django-master"; python manage.py runserver'
Start-Process powershell -ArgumentList '-NoExit', '-Command', 'cd "C:\Users\Eduardo\Documents\APTC106_s6_crud2\simple-crud-django-master\flutter"; flutter run'