import 'package:flutter/material.dart';
import 'package:platzi_trips_app/User/model/user_model.dart';
import 'package:platzi_trips_app/Widgets/gradient_back.dart';
import 'package:platzi_trips_app/Widgets/button_green.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/platzi_trips_cupertino.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late UserBloc userBloc;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PlatziTripsCupertino();
        } else {
          return signInGoogleUi();
        }
      },
    );
  }

  Widget signInGoogleUi() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GradientBack(
            height: null,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Container(
                width: screenWidth,
                child: Text(
                  "Welcome \n This is your travel App",
                  style: TextStyle(
                      fontSize: 37,
                      fontFamily: "Lato",
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
              ButtonGreen(
                text: "Login with Gmail",
                onPressed: () {
                  userBloc.signOut();
                  userBloc.singIn().then((user) {
                    userBloc.updateUserDataFirestore(UserModel(
                        uid: user!.uid,
                        name: user.displayName!,
                        email: user.email!,
                        photoURL: user.photoURL!));
                  });
                },
                width: 300.0,
                height: 50.0,
              )
            ],
          )
        ],
      ),
    );
  }
}
