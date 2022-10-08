import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platzi_trips_app/Place/repository/firebase_storage_api.dart';

class FirebaseStorageRepository {
  final _firebaseStorageApi = FirebaseStorageApi();

  Future<UploadTask> uploadFile(String path, XFile image) => _firebaseStorageApi.uploadFile(path, image);
}