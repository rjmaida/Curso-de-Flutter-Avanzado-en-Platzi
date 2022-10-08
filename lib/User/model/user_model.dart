import 'package:flutter/material.dart';
import '../../Place/model/place.dart';

class UserModel {
  late final String uid;
  late final String name;
  late final String email;
  late final String photoURL;
  late final List<Place>? myPlaces;
  late final List<Place>? myFavoritePlaces;

  UserModel({
    Key? key,
    required this.uid,
    required this.name,
    required this.email,
    required this.photoURL,
    this.myPlaces,
    this.myFavoritePlaces
  });
}