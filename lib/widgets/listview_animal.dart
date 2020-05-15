import 'dart:async';

import 'package:appfirebase/classes/animal.dart';
import 'package:appfirebase/widgets/cardview_animal.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class ListViewAnimal extends StatefulWidget {
  ListViewAnimal({Key key,this.context}) : super(key: key);
  BuildContext context;
  @override
  _ListViewAnimalState createState() => _ListViewAnimalState();
}

class _ListViewAnimalState extends State<ListViewAnimal> {
  List<Animal> animals = new List();
  DatabaseReference reference = FirebaseDatabase.instance.reference().child('Animal');
  StreamSubscription<Event> onAddedSubs;
  StreamSubscription<Event> onChangeSubs;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: animals.length,
      itemBuilder: (BuildContext context,int index){
        return Dismissible(
          key: ObjectKey(animals[index]),
          child: CardViewAnimal(animal: animals[index], context: context),
          onDismissed: (direction) {
            deleteItem(index);
          },
        );
      }
    );
  }

  void deleteItem(index) {
    
    setState(() {
      reference.child(animals[index].key).remove();
      animals.removeAt(index);
    });
  }

  void initState() {
    onAddedSubs = reference.onChildAdded.listen(onEntryAdded);
    onChangeSubs = reference.onChildChanged.listen(onEntryChanged);
  }

  onEntryAdded(Event event) {
    setState(() {
      animals.add(Animal.getAnimal(event.snapshot));
    });
  }

  onEntryChanged(Event event) {
    Animal oldEntry = animals.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      animals[animals.indexOf(oldEntry)]=Animal.getAnimal(event.snapshot);
    });
  }

  void disponse() {
    onAddedSubs.cancel();
    onChangeSubs.cancel();
  }
}