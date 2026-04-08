from . import views
from django.urls import path
from django.conf.urls.static import static
from django.conf import settings


urlpatterns = [
    path('upload/', views.FileUploadAPI.as_view(), name='file-upload'),
    path('mutiple/',views.MutlipleFileUploadAPI.as_view(), name='mutiple-file-upload'),
    path('base64/',views.Base64Upload.as_view(), name='base64-upload'),
] 