import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hand_one/Maps/generate/address_repository.dart';
import 'package:hand_one/Maps/models/address_model.dart';
import 'package:maps_launcher/maps_launcher.dart';

final addressRepositoryProvider = Provider<AddressRepository>((ref) {
  return AddressRepository(firestore: FirebaseFirestore.instance);
});

class GoogleMapPage extends ConsumerStatefulWidget {
  const GoogleMapPage({super.key});

  @override
  GoogleMapPageState createState() => GoogleMapPageState();
}

class GoogleMapPageState extends ConsumerState<GoogleMapPage> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  LatLng? initialPosition;
  String? currentAddress;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _fetchAddressesAndConvertToLatLng();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _setDefaultLocation();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _setDefaultLocation();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _setDefaultLocation();
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      initialPosition = LatLng(position.latitude, position.longitude);
    });

    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placeMarks.isNotEmpty) {
      Placemark placeMark = placeMarks.first;
      currentAddress =
          "${placeMark.locality}, ${placeMark.administrativeArea}, ${placeMark.country}";
    }
  }

  void _setDefaultLocation() {
    setState(() {
      initialPosition = const LatLng(35.681236, 139.767125);
    });
  }

  Future<void> _fetchAddressesAndConvertToLatLng() async {
    final addressRepository = ref.read(addressRepositoryProvider);
    List<AddressModel> addresses = await addressRepository.fetchAddresses();

    for (var address in addresses) {
      if (address.location != null) {
        final marker = Marker(
          markerId: MarkerId(address.id),
          position: address.location!,
          infoWindow: InfoWindow(
            title: address.name,
            snippet: "クリックして地図Mapを開く",
            onTap: () {
              MapsLauncher.launchQuery(address.address);
            },
          ),
        );

        setState(() {
          markers.add(marker);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initialPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: initialPosition!,
                zoom: 10,
              ),
              markers: markers,
              myLocationEnabled: true,
              compassEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
    );
  }
}

//これをしたい
//https://qiita.com/YusukeIwaki/items/a9d62459cbbc8df1dfa5