import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'package:platzi_trips_app/User/model/user_model.dart';
import '../widgets/button_bar.dart';
import 'package:platzi_trips_app/User/ui/widgets/user_info_widget.dart';

class ProfileHeader extends StatelessWidget {
  late UserBloc userBloc;
  late UserModel userModel;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);

    return StreamBuilder(
      stream: userBloc.streamFirebase,
      builder: ((context, AsyncSnapshot<User?> snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return CircularProgressIndicator();
          case ConnectionState.active:
          case ConnectionState.done:
            return showProfileData(snapshot);
        }
      }),
     );
  }

  Widget showProfileData(AsyncSnapshot<User?> snapshot) {
    if(snapshot.hasData) {
      print("Loggeado");
      userModel = UserModel(
        uid: snapshot.data!.uid,
        name: snapshot.data!.displayName!, 
        email: snapshot.data!.email!, 
        photoURL: snapshot.data!.photoURL!
        );
      final title = Text(
      'Profile',
      style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0
      ),
    );

    return Container(
      margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 50.0
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              title
            ],
          ),
          UserInfoWidget(userModel),
          ButtonsBar()
        ],
      ),
    ); 
    
    } else {
      print("No loggeado");
      return Container(
      margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 50.0
      ),
      child: Column(
        children: <Widget>[
          CircularProgressIndicator(),
          Text("No se pudo cargar la informacion. Haz login")
        ],
      ),
    ); 
    }

  }

}