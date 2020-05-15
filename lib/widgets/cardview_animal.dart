import 'package:appfirebase/classes/animal.dart';
import 'package:appfirebase/pages/animal_form_page.dart';
import 'package:flutter/material.dart';

class CardViewAnimal extends StatelessWidget {
  
  const CardViewAnimal({Key key,this.animal,this.context}) : super(key: key);
  final Animal animal;
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormAnimal(title: 'Editar Animal',animal: animal,)));
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              height: 144.0,
              width: 500.0,
              color: Colors.white,
              child: FadeInImage.assetNetwork(
                placeholder: 'img/dafault.png',
                image: animal.imagen,
                height: 144.0,
                width: 160.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(7.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Icon(Icons.pets),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(animal.name,style: TextStyle(fontSize: 18.0),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Icon(Icons.cake),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(animal.age,style: TextStyle(fontSize: 18.0),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}