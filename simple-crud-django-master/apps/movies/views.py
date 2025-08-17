from django.contrib.auth.decorators import login_required
from django.http import Http404
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login, logout
from .models import Order, Categories
from .forms import OrderForm, LoginForm


# Create your views here.


def log_in(request):
    # Diccionario que almacena los datos que enviamos a la vista
    form = LoginForm(
        request.POST or None
    )
    context = {'message': None, 'form': form}
    if request.POST and form.is_valid():
        # Verificar credenciales
        # Devuelve un objeto User si las credenciales son válidas.
        # Si las credenciales no son válidas, devuelve None
        user = authenticate(**form.cleaned_data)
        if user is not None:
            # Verificar si el usuario esta activo
            if user.is_active:
                # Adjuntar usuario autenticado a la sesión actual
                login(request, user)
                # Redireccionar a una vista utilizando el nombre de la url
                return redirect('movies:home')
            else:
                context['message'] = 'El usuario ha sido desactivado'
        else:
            context['message'] = 'Usuario o contraseña incorrecta'
    return render(request, 'movies/login.html', context)


# decorador para restringir el acceso a solo usuarios autenticados
@login_required
def log_out(request):
    logout(request)
    return redirect('movies:log-in')



@login_required
def list_orders(request):
    orders = Order.objects.all()
    return render(request, 'movies/index.html', {'orders': orders})



@login_required
def order_detail(request, pk):
    order = get_object_or_404(Order, pk=pk)
    return render(request, 'movies/detail.html', {'order': order})



@login_required
def add_order(request, **kwargs):
    form = OrderForm(request.POST or None)
    if request.POST and form.is_valid():
        form.save()
        return redirect('movies:home')
    return render(request, 'movies/form.html', {'form': form})



@login_required
def update_order(request, **kwargs):
    order = Order.objects.get(pk=kwargs.get('pk'))
    form = OrderForm(request.POST or None, instance=order)
    if request.POST and form.is_valid():
        form.save()
        return redirect('movies:home')
    return render(request, 'movies/form.html', {'form': form})



@login_required
def delete_order(request, **kwargs):
    order = Order.objects.get(pk=kwargs.get('pk'))
    order.delete()
    return redirect('movies:home')


@login_required
def category_list(request):
    categories = Categories.objects.all()
    return render(request, 'movies/category/category_list.html', {'categories': categories})