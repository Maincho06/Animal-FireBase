import 'package:flutter/material.dart';
import 'package:appfirebase/classes/auth_firebase.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key,this.auth,this.onSignIn}) : super(key: key);
  final AuthFirebase auth;
  final VoidCallback onSignIn;
  @override
  _LoginPageState createState() => _LoginPageState();
}
enum FormType{
  login,
  registrar
}

class _LoginPageState extends State<LoginPage> {
  FormType formType = FormType.login;
  final formkey = new GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formkey,
          child: Column(
            children: formLogin(),
          ),
        ),
      ),
    );
  }

  List<Widget> formLogin() {
    List<Widget> lwidget = [];
    final correo = padded(
      TextFormField(
        controller: email,
        decoration: InputDecoration(
          icon: Icon(Icons.person),
          labelText: 'Correo',
        ),
        autocorrect: false,
      )
    );
    final clave = padded(
      TextFormField(
        controller: password,
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          labelText: 'Contraseña',
        ),
        autocorrect: false,
        obscureText: true,
      )
    );
    final opciones = Column(
      children: buttonWidget()
    );

    lwidget..add(correo)
           ..add(clave)
           ..add(opciones);
    return lwidget;
  }

  List<Widget> buttonWidget() {
    switch(formType){
      case FormType.login:
        return[styleButton('Iniciar Sesión',validateSubmit),
          FlatButton(
            child: Text("No tienes una cuenta? Registrate"),
            onPressed: () => updateFormType(FormType.registrar),
          )
        ];
      case FormType.registrar:
        return[styleButton('Crear Cuenta',validateSubmit),
          FlatButton(
            child: Text("Iniciar Sesión"),
            onPressed: () => updateFormType(FormType.login),
          )
        ];
    }
  }

  void updateFormType(FormType form) {
    formkey.currentState.reset();
    setState(() {
      formType = form;
    });
  }

  void validateSubmit() {
    (formType == FormType.login)?widget.auth.singIn(email.text, password.text):widget.auth.createUser(email.text, password.text);
    // if (formType == FormType.login){
    //   widget.auth.singIn(email.text, password.text);
    // } else {
    //   widget.auth.createUser(email.text, password.text);
    // }
    widget.onSignIn();
  }

  Widget styleButton(String text, VoidCallback onPressed) {
    return RaisedButton(
      onPressed: onPressed,
      color: Colors.deepPurple,
      textColor: Colors.white,
      child: Text(text),
    );
  }

  Widget padded(Widget child){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }

}