import 'package:firebase_database/firebase_database.dart';

class Animal{

  String key;
  String name;
  String age;
  String imagen;

  Animal(this.key,this.name,this.age,this.imagen);

  Animal.getAnimal(DataSnapshot snapshot) :
  key = snapshot.key,
  name = snapshot.value['name'],
  age = snapshot.value['age'],
  imagen = snapshot.value['image'];

}