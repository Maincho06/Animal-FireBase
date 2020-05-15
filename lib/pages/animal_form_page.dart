import 'dart:io';

import 'package:appfirebase/classes/animal.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class FormAnimal extends StatefulWidget {
  FormAnimal({Key key,this.title,this.animal}) : super(key: key);
  final title;
  Animal animal;
  @override
  _FormAnimalState createState() => _FormAnimalState();
}

class _FormAnimalState extends State<FormAnimal> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  File galleryFile;
  String urlImage;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: getFormAnimal(),
      ),
    );
  }

  Widget getFormAnimal() {
    return new Column(
      children: <Widget>[
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            icon: Icon(Icons.pets),
            hintText: '¿Cuál es el nombre del animal?',
            labelText: 'Nombre',
          ),
        ),
        TextFormField(
          controller: ageController,
          decoration: InputDecoration(
            icon: Icon(Icons.pets),
            hintText: '¿Cuál es la edad?',
            labelText: 'Edad',
          ),
        ),
        RaisedButton(
          child: Text('Seleccionada una imagen'),
          onPressed: imageSelectorGallery,
        ),
        SizedBox(
          child: showImage(),
        ),
        RaisedButton(
          onPressed: sendData,
          child: Text('Guardar'),
        )
      ],
    );
  }

  void initState() {
    if (widget.animal != null) {
      nameController.text =widget.animal.name;
      ageController.text =widget.animal.age;
    }
  }

  sendData() {
    saveFirebase(nameController.text).then((_){ 
      DatabaseReference db = FirebaseDatabase.instance.reference().child('Animal');
      if (widget.animal != null) {
        db.child(widget.animal.key).set(getAnimal()).then((_){
          Navigator.pop(context);
        }); 
      } else {
        db.push().set(getAnimal()).then((_){
          Navigator.pop(context);
        });
      }
    });    
  }

  Map<String,dynamic> getAnimal() {
    Map<String,dynamic> data = new Map();
    data['name'] = nameController.text;
    data['age'] = ageController.text;
    if(widget.animal != null && galleryFile == null) {
      data['image'] = widget.animal.imagen;
    } else {
      data['image'] = urlImage!=null?urlImage:"";
    }
    return data;
  }

  Future<void> saveFirebase (String imageId) async {
    if (galleryFile != null) {
      StorageReference reference = FirebaseStorage.instance.ref().child('animal').child(imageId);
      StorageUploadTask uploadTask = reference.putFile(galleryFile);
      StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
      urlImage = (await downloadUrl.ref.getDownloadURL());
      print(urlImage);
    }
  }

  showImage() {
    if(galleryFile != null) {
      return Image.file(galleryFile);
    } else {
      if(widget.animal != null) {
        return FadeInImage.assetNetwork(
          placeholder: "img/default.png",
          image: widget.animal.imagen,
          height: 800.0,
          width: 700.0,
        );
      } else {
        return Text('Imagen no seleccionada');
      }
    }
  }

  imageSelectorGallery() async{
    galleryFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800.0,
      maxWidth: 700.0
    );
    setState(() {
      
    });
  }
}