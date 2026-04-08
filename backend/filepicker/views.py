import base64
from django.core.files.base import ContentFile
from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import FileUpload
from .serializers import FileUploadSerializer

class FileUploadAPI(APIView):
    def post(self, request, format=None):
        serializer = FileUploadSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    

class MutlipleFileUploadAPI(APIView):
    def post(self, request, format=None):
        files = request.FILES.getlist('files')  

        uploaded_files = []

        for f in files:
            file_instance = FileUpload.objects.create(file=f)
            uploaded_files.append(file_instance.file.url)

        return Response({
            "message": "Files uploaded successfully",
            "files": uploaded_files
        }, status=status.HTTP_201_CREATED)



class Base64Upload(APIView):
    def post(self, request):
        base64_data = request.data.get('base64')  
        filename = request.data.get('filename')

        file_bytes = base64.b64decode(base64_data)

        with open(f"media/uploads/{filename}", "wb") as f:
            f.write(file_bytes)

        return Response({"message": "Uploaded successfully"})