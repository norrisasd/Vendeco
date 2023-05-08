import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../auth.dart';
import '../../../../../shared/constants.dart';
import '../../../../../shared/responsive.dart';

class HardwareInformation {
  String? componentID;
  String? location;
  HardwareInformation({this.componentID, this.location});
  setComponentID(String newComponentID) {
    componentID = newComponentID;
  }

  setLocation(String newLocation) {
    location = newLocation;
  }
}

class HardwareInfo extends StatelessWidget {
  const HardwareInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isMobile(context) ? 20 : 35,
        ),
        child: FutureBuilder<HardwareInformation>(
            future: _getHardwareInformation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                HardwareInformation hwi = snapshot.data!;
                return AutoSizeText(
                  "${hwi.componentID!}\n${hwi.location!}",
                  style: GoogleFonts.akshar(
                      fontSize: Responsive.isMobile(context) ? 14 : 45,
                      fontWeight: fwLight,
                      color: secondaryColor,
                      letterSpacing: Responsive.isMobile(context) ? 1.4 : 4.5),
                );
              } else if (snapshot.hasError) {
                return const Text("Error");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Future<HardwareInformation> _getHardwareInformation() async {
    final User? user = Auth().currentUser;
    HardwareInformation hwi = HardwareInformation();
    DatabaseReference usersRef = FirebaseDatabase.instance
        .ref()
        .child("UsersData")
        .child(user!.uid)
        .child("readings");

    final DatabaseEvent event = await usersRef.limitToLast(1).once();
    final DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> readings = snapshot.value as Map;
      readings.forEach((key, value) {
        hwi = HardwareInformation(
            componentID: value['componentid'].toString(),
            location: value['location'].toString());
      });
    }

    return hwi;
  }
}
