import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/base64.dart';
import 'package:my_flutter_app/filepick_dio.dart';
import 'package:my_flutter_app/mutliplefile.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Scaffold(
        body: Filepicker(),
      ),
    );
  }
}

class Filepicker extends StatefulWidget {
  const Filepicker({super.key});

  @override
  State<Filepicker> createState() => _FilepickerState();
}

class _FilepickerState extends State<Filepicker> {

  PlatformFile? file; 

void pick()async{

FilePickerResult? result = await FilePicker.platform.pickFiles();

if(result != null){

  setState(() {
     file = result.files.first;
  });
  
}

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: 
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [

ElevatedButton(onPressed: ()=> pick(), child: Text("pick file")),
SizedBox(height: 20,),
Text("file name ${file != null ? file!.name : "file no selected"}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
Text("file Size ${file != null ? file!.size : "file no selected"}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
Text("file Extension ${file != null ? file!.extension : "file no selected"}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

ElevatedButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>DioFilepicker() )), child: Text("Dio Filepicker")),
ElevatedButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Mutliplefile() )), child: Text("muliple file upload")),
ElevatedButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Base64())), child: Text("Base64 file upload")),
        ]
      ))
    );
  }
}