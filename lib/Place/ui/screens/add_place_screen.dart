import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/Place/ui/widgets/card_image_with_fab_icon.dart';
import 'package:platzi_trips_app/Place/ui/widgets/text_input_location.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'package:platzi_trips_app/Widgets/button_purple.dart';
import 'package:platzi_trips_app/Widgets/gradient_back.dart';

import '../../../Widgets/text_input.dart';
import '../../../Widgets/title_header.dart';

class AddPlaceScreen extends StatefulWidget {
  XFile? image;

  AddPlaceScreen({super.key, this.image});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _controllerTitlePlace = TextEditingController();
  final _controllerDescriptionPlace = TextEditingController();
  final _controllerLocationionPlace = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of(context);
    double screenWidth = MediaQuery.of(context).size.width;

    

    return Scaffold(
      body: Stack(
        children: [
          GradientBack(
            height: 300.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 25.0, left: 5.0),
                child: SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 45,
                      )),
                ),
              ),
              Flexible(
                child: Container(
                  width: screenWidth,
                  padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
                  child: TitleHeader(
                    title: "Add a new Place",
                  ),
              )),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 120.0, bottom: 20),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CardImageWithFabIcon(
                    pathImage: widget.image!.path, 
                    width: 350.0, 
                    height: 250.0,
                    left: 0, 
                    onPressedFabIcon: (){}, 
                    iconData: Icons.camera_alt
                    ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
                  child: TextInput(
                    hintText: "Title",
                    inputType: TextInputType.text,
                    controller: _controllerTitlePlace,
                  ) ,
                ),
                TextInput(
                  hintText: "Description", 
                  inputType: TextInputType.multiline, 
                  controller: _controllerDescriptionPlace,
                  maxLines: 4,
                  ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextInputLocation(
                    hintText: "Add Location", 
                    controller: _controllerLocationionPlace, 
                    iconData: Icons.location_on) ,
                ),
                Container(
                  width: 70.0,
                  child: ButtonPurple(
                    buttonText: "Add Place", 
                    onPressed: () {
                      if(_controllerTitlePlace.text.isNotEmpty && _controllerDescriptionPlace.text.isNotEmpty) {
                        User? user = userBloc.currentUser;
                        if(user != null && widget.image != null) {
                          String uid = user.uid;
                          String path = "$uid/${DateTime.now().toString()}.jpg";
                          userBloc.uploadFile(path, widget.image!).then((uploadTask) => {
                            uploadTask.snapshot.ref.getDownloadURL().then((urlImage) {
                              print(urlImage);
                              userBloc.updatePlaceData(Place(
                                name: _controllerTitlePlace.text, 
                                description: _controllerDescriptionPlace.text, 
                                urlImage: urlImage,
                                likes: 0
                              )).whenComplete(() => Navigator.pop(context));
                            })
                          });
                        }
                        
                      } else {
                        print("FAIL ${_controllerTitlePlace.text}");
                      }
                    }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
