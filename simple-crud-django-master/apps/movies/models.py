from django.db import models
from django.urls import reverse_lazy


# Create your models here.

class BaseName(models.Model):
    name = models.CharField(max_length=150, verbose_name='Nombre')
    created = models.DateTimeField(auto_now=False, auto_now_add=True)
    updated = models.DateTimeField(auto_now=True, auto_now_add=False)

    class Meta:
        abstract = True

    def __str__(self):
        return self.name


class Categories(BaseName):
    minimum_age = models.IntegerField(verbose_name='Edad Minima')

    class Meta:
        verbose_name = 'Categoria'
        verbose_name_plural = 'Categorias'



class Order(models.Model):
    customer_name = models.CharField(max_length=100)
    items = models.TextField()
    address = models.CharField(max_length=200)
    status = models.CharField(max_length=50, default='Pending')

    def __str__(self):
        return f"{self.customer_name} - {self.status}"
