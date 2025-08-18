from django.urls import path, include
from apps.movies import views
from rest_framework.routers import DefaultRouter
from .serializers import OrderSerializer
from rest_framework import viewsets
from .models import Order
from django.conf import settings
from django.conf.urls.static import static
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

app_name = 'movies'


# API ViewSet
class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

router = DefaultRouter()
router.register(r'orders', OrderViewSet, basename='order')

orders_patterns = [
    path('inicio/', views.list_orders, name='home'),
    path('<int:pk>/', views.order_detail, name='order-detail'),
    path('crear/', views.add_order, name='order-create'),
    path('<int:pk>/editar/', views.update_order, name='order-edit'),
    path('<int:pk>/eliminar/', views.delete_order, name='order-delete')
]


urlpatterns = [
    path('', views.log_in, name='log-in'),
    path('log-out/', views.log_out, name='log-out'),
    path('categorias/', views.category_list, name='category-list'),
    path('orders/', include(orders_patterns)),
    path('api/', include(router.urls)),
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)