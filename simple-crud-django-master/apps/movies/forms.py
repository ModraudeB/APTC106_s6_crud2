from django import forms
from .models import Order



class OrderForm(forms.ModelForm):
    class Meta:
        model = Order
        fields = '__all__'


class LoginForm(forms.Form):
    username = forms.CharField(label='Usuario')
    password = forms.CharField(widget=forms.PasswordInput, label="Contraseña")
