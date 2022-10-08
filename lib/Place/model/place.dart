import 'package:flutter/material.dart';
import 'package:platzi_trips_app/User/model/user_model.dart';

class Place {
  late String id;
  String name;
  String description;
  String? urlImage;
  int? likes;
  UserModel? userOwner;

  Place({
    Key? key,
    required this.name,
    required this.description,
    this.urlImage,
    this.likes,
    this.userOwner
  });
}