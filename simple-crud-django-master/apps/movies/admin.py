from django.contrib import admin
from .models import Categories, Order


# Register your models here.


@admin.register(Categories, Order)
class BaseAdminRegister(admin.ModelAdmin):
    pass
