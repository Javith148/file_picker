import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';



class Base64 extends StatefulWidget {
  const Base64({super.key});

  @override
  State<Base64> createState() => _Base64State();
}

class _Base64State extends State<Base64> {
  final dio = Dio();  
  String status = "No file selected";  

void pick() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.first.path!);

    String fileName = result.files.first.name;
    String extension = result.files.first.extension ?? "jpg";

    List<int> fileBytes = await file.readAsBytes();
    String base64String = base64Encode(fileBytes);
    print("****************BASE64 STRING****************");
    print(base64String);
    print("****************BASE64 STRING****************");


    setState(() {
      status = "Uploading";
    });

    try {
      Response res = await dio.post(
        "https://7c23-2401-4900-8825-20f-981e-4842-5eea-d152.ngrok-free.app/base64/",
        data: {
          "base64": base64String,
          "filename": fileName,
          "ext": extension
        },
      );

      setState(() {
        status = "Upload successful";
      });

      print(res.data);
    } catch (e) {
      setState(() {
        status = "Upload failed: $e";
      });
    }
  }
}
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: ()=>pick(), child: Text("pick file")),
            SizedBox(height: 20,),
            Text(status, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
          ],))
    );
  }
}
