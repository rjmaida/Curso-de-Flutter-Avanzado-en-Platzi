import 'package:flutter/material.dart';
import 'card_image_with_fab_icon.dart';

class CardImageList extends StatelessWidget {

  double width = 350;
  double height = 250;
  double left = 20;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 350.0,
      child: ListView(
        padding: EdgeInsets.all(25.0),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CardImageWithFabIcon(pathImage: "assets/img/beach_palm.jpeg", iconData: Icons.favorite_border, onPressedFabIcon: (){}, width: width, height: height, left: left,),
          CardImageWithFabIcon(pathImage: "assets/img/mountain.jpeg", iconData: Icons.favorite_border, onPressedFabIcon: (){}, width: width, height: height, left: left,),
          CardImageWithFabIcon(pathImage: "assets/img/mountain_stars.jpeg", iconData: Icons.favorite_border, onPressedFabIcon: (){}, width: width, height: height, left: left,),
          CardImageWithFabIcon(pathImage: "assets/img/river.jpeg", iconData: Icons.favorite_border, onPressedFabIcon: (){}, width: width, height: height, left: left,),
          CardImageWithFabIcon(pathImage: "assets/img/sunset.jpeg", iconData: Icons.favorite_border, onPressedFabIcon: (){}, width: width, height: height, left: left,),
        ],
      ),
    );
  }

}