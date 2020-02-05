import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ping_app/models/user.dart';
import 'package:ping_app/services/database.dart';
import 'package:ping_app/services/geolocate.dart';
import 'package:ping_app/shared/constants.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserData userData = Provider.of<UserData>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // Text('Ping!',
        //     style: TextStyle(
        //         fontSize: 120,
        //         fontFamily: 'Lobster',
        //         color: Colors.deepPurple[800])),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ShadowText(' Ping! ',
              style: TextStyle(
                  height: 2,
                  fontSize: 120,
                  fontFamily: 'Lobster',
                  color: Colors.deepPurple[800])),
        ),

        // SizedBox(
        //   height: 50,
        // ),

        // RaisedButton(
        //     child: Text('Print Location'),
        //     onPressed: () async {
        //       Position coords = await Geolocate().getCurrentLocation();
        //       print("LAT: ${coords.latitude}, LNG: ${coords.longitude}");
        //     }),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: RawMaterialButton(
            onPressed: () async {
              Position coords = await Geolocate().getCurrentLocation();
              String location = '${coords.latitude},${coords.longitude}';
              await DatabaseService()
                  .createChats(userData, location, DateTime.now());
            },
            child: Text(
              'SOS!',
              style: TextStyle(
                fontFamily: 'bebas',
                fontSize: 100,
                color: Colors.white,
              ),
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.red[500],
            padding: const EdgeInsets.all(50.0),
          ),
        ),
      ],
    );
  }
}
