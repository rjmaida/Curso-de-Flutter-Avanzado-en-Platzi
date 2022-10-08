import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_trips_app/User/model/user_model.dart';

import '../../Place/model/place.dart';
import 'cloud_firestore_api.dart';

class CloudFirestorRepository {

  final _cloudFirestoreApi = CloudFirestoreApi();

  updateUserData(UserModel user) => _cloudFirestoreApi.updateUserData(user);
  Future<void> updatePlaceData(Place place) => _cloudFirestoreApi.updatePlaceData(place);
}