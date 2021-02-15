import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'op.dart';


File inputImage;
class Input extends StatefulWidget {
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  String fileName;
  List<String> imagePaths = [];
  final picker = ImagePicker();
  bool wannaSave = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload damaged photo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              // width: 500,
              // height: 700,          
              child: inputImage == null ?
              Text("Upload the digital form of the damaged image!") :
              Image.file(inputImage),
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            child: Text("Pick photo"),
            onPressed: (){
              takeInput("gallery");
            })
          ]),
        ),
        floatingActionButton: 
        inputImage != null ?
        FloatingActionButton.extended(     
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          label: Text("Restore!"),
          icon: Icon(Icons.arrow_forward),
          onPressed: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => Op())
              );
          })
          : Container(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }


    takeInput(String mode) async{
    if (mode == "cam"){
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      fileName = basename(pickedFile.path);
      setState(() {
      inputImage = File(pickedFile.path);
      });
    }
    if (mode == "gallery") {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      fileName = basename(pickedFile.path);     
      setState(() {
      inputImage = File(pickedFile.path);
      });
    }
    }

}