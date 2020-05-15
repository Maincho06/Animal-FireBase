import 'package:appfirebase/classes/auth_firebase.dart';
import 'package:appfirebase/pages/animal_form_page.dart';
import 'package:appfirebase/widgets/listview_animal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key,this.onSignIn,this.authFirebase}) : super(key: key);
  final VoidCallback onSignIn;
  final AuthFirebase authFirebase;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          FlatButton(
            child: Text('Cerra Sesión'),
            onPressed: signOut,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => FormAnimal(title: 'Nuevo Animal',animal: null,)
          ));
        },
        shape: StadiumBorder(),
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add,size: 20.0),
      ),
      body: new ListViewAnimal(context: context),
    );
  }

  void signOut() {
    authFirebase.signOut();
    onSignIn();
  }
}