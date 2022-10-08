import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips_app/User/repository/firebase_auth_api.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuthApi();
  
  Future<User?> signInFirebase() => _firebaseAuth.signIn();

  signOutFirebase() => _firebaseAuth.signOut();
}