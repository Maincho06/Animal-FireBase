import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebase{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> singIn(String email, String password) async {
    FirebaseUser user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
  }

  Future<String> createUser(String email, String password) async {
    FirebaseUser user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    return user!= null ? user.uid : null;
  }

  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }

}