import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';


class DioFilepicker extends StatefulWidget {
  const DioFilepicker({super.key});

  @override
  State<DioFilepicker> createState() => _DioFilepickerState();
}

class _DioFilepickerState extends State<DioFilepicker> {
  final dio = Dio();
  PlatformFile? file;
  String status = "No file selected";

  void pick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = result.files.first;
      String filePath = file!.path!;
      String fileName = file!.name;

      setState(() {
        status = "Uploading $fileName"; 
      });

try{

FormData formData = FormData.fromMap({
  "file": await MultipartFile.fromFile(filePath, filename: fileName)
} ); 


Response res = await dio.post("https://7c23-2401-4900-8825-20f-981e-4842-5eea-d152.ngrok-free.app/upload/",
data: formData,
options: Options(headers: {
  "Content-Type": "multipart/form-data"}));

setState(() {
  status = "Upload successful: ${res.data}";
});

}
catch(e){
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


