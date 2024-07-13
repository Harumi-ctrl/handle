import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hand_one/Maps/models/address_model.dart';

class AddressRepository {
  final FirebaseFirestore firestore;

  AddressRepository({required this.firestore});

  Future<List<AddressModel>> fetchAddresses() async {
    CollectionReference categories = firestore.collection('categories');
    QuerySnapshot snapshot = await categories.get();
    List<AddressModel> addresses = [];

    for (var document in snapshot.docs) {
      String address = document['address'];
      String name = document['name'];
      LatLng? location = await _getLatLngFromAddress(address);
      addresses.add(AddressModel(
        id: document.id,
        name: name,
        address: address,
        location: location,
      ));
    }
    return addresses;
  }

  Future<LatLng?> _getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      print('Error occurred while converting address to LatLng: $e');
    }
    return null;
  }
}
