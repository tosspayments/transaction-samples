from django.urls import path
from . import views

urlpatterns = [
  path('', views.index),

  path('transactions', views.transactions),
  path('settlements', views.settlements),
  path('promotion', views.promotion),
  path('cashreceipt', views.cashreceipt),
  path('cancelcashreceipt', views.cancelcashreceipt),
]