import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class Mutliplefile extends StatefulWidget {
  const Mutliplefile({super.key});

  @override
  State<Mutliplefile> createState() => _MutliplefileState();
}

class _MutliplefileState extends State<Mutliplefile> {
  final dio = Dio();
 
  String status = "No file selected";

  void pick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result != null) {
      List<PlatformFile> files = result.files;

      setState(() {
        status = "Uploading ${files.length} files";
      });

      try {
        List<MultipartFile> multipartFiles = [];

        for (var fi in files) {
          multipartFiles.add(
            await MultipartFile.fromFile(fi.path!, filename: fi.name),
          );
        }

        Response res = await dio.post(
          "https://7c23-2401-4900-8825-20f-981e-4842-5eea-d152.ngrok-free.app/mutiple/",
          data: FormData.fromMap({"files": multipartFiles}),
          options: Options(headers: {"Content-Type": "multipart/form-data"}),
        );

        setState(() {
          status = "Upload successful: ";
        });
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
            ElevatedButton(onPressed: () => pick(), child: Text("pick file")),
            SizedBox(height: 20),
            Text(
              status,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
