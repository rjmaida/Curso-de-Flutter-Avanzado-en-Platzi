import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platzi_trips_app/Place/repository/firebase_storage_repository.dart';
import 'package:platzi_trips_app/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_repository.dart';

import '../../Place/model/place.dart';
import '../model/user_model.dart';

class UserBloc implements Bloc {

  Stream<User?> streamFirebase = FirebaseAuth.instance.authStateChanges();
  final authRepository = AuthRepository();

  final _cloudFirestoreRepository = CloudFirestorRepository();
  final _firestoreStorageRepository = FirebaseStorageRepository();

  Stream<User?> get authStatus => streamFirebase;
  Future<User?> singIn() => authRepository.signInFirebase();
  signOut() => authRepository.signOutFirebase();

  updateUserDataFirestore(UserModel user) => _cloudFirestoreRepository.updateUserData(user);
  Future<void> updatePlaceData(Place place) => _cloudFirestoreRepository.updatePlaceData(place);
  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<UploadTask> uploadFile(String path, XFile image) => _firestoreStorageRepository.uploadFile(path, image);

  @override
  void dispose() {

  }
}