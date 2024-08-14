import 'package:cloud_firestore/cloud_firestore.dart';

class LocationService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addLocation({required String country, required String state,required String district,required String city,})async{
    await _db.collection("locations").add(
      {
        'country' : country,
        'state' : state,
        'district' : district,
        'city' : city
      }
    );
  }
}