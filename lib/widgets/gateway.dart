import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sporth/preferences/preferences.dart';
import 'package:sporth/providers/providers.dart';

import 'package:sporth/utils/utils.dart';

class Gateway extends StatelessWidget {
  Gateway({super.key});
  final databaseUser = DatabaseUser();

  void home(BuildContext context) async {
    final UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    LocationPermission permission = await Geolocator.checkPermission();
    
    if (permission == LocationPermission.denied 
        || permission == LocationPermission.deniedForever 
        || !await Geolocator.isLocationServiceEnabled()) {
      
      Navigator.pushReplacementNamed(context, PERMISOS);
      return;
    }

    userProvider.currentUser = await databaseUser.getUser(FirebaseAuth.instance.currentUser!.uid);

    /*if (Preferences.isFirstTime) {
      Navigator.pushReplacementNamed(context, 'tutorial');
      return;
    }*/
    
    Navigator.pushReplacementNamed(context, HOME);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacementNamed(context, LOGIN);
      } else {
        home(context);
      }
    });

    return const Scaffold(
      backgroundColor: ColorsUtils.blue,
      body: Center(
          child: CircularProgressIndicator(
        color: ColorsUtils.white,
      )),
    );
  }
}
