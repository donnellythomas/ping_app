import 'package:geolocator/geolocator.dart';

class Geolocate {
  Future<Position> getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    Future<Position> coords = geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      return position;
    }).catchError((e) {
      print(e);
    });
    return coords;
  }
}
