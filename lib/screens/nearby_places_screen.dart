import 'package:aid_assist/models/nearby_search_model.dart';
import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class NearbyPlacesScreen extends StatefulWidget {
  @override
  _NearbyPlacesScreenState createState() => _NearbyPlacesScreenState();
}

class _NearbyPlacesScreenState extends State<NearbyPlacesScreen> {
  Completer<GoogleMapController> _controller = Completer();

  Future<NearbySearchModel> futureNearbySearchLocations;

  Location _location = Location();
  LocationData _locationData;

  @override
  void initState() {
    super.initState();
  }

  Future<NearbySearchModel> fetchNearbySearchLocations(String type) async {
    var queryParameters = {
      'location': _locationData.latitude.toString() +
          "," +
          _locationData.longitude.toString(),
      'radius': '1500',
      'type': type,
      'key': 'AIzaSyDRNYfAWszVQ8vD39BK1XGXQxWWARH6fvM'
    };

    final response = await http.get(Uri.https('maps.googleapis.com',
        'maps/api/place/nearbysearch/json', queryParameters));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      _typeMarkers.clear();
      var nearbySearchLocations = nearbySearchModelFromJson(response.body);
      nearbySearchLocations.results.forEach((element) {
        _typeMarkers.add(Marker(
          markerId: MarkerId(LatLng(
                  element.geometry.location.lat, element.geometry.location.lng)
              .toString()),
          position: LatLng(
              element.geometry.location.lat, element.geometry.location.lng),
          infoWindow: InfoWindow(
            title: element.name,
            snippet: element.vicinity,
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
      });

      setState(() {
        _markers.clear();
        _markers.addAll(_typeMarkers);
      });

      return nearbySearchLocations;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load nearby places');
    }
  }

  static const LatLng _center = const LatLng(39.9334, 32.8597);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    _location.onLocationChanged.listen((l) {
      if (_locationData == null ||
          l.latitude != _locationData.latitude ||
          l.longitude != _locationData.longitude) {
        _locationData = l;

        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
          ),
        );
      }
    });
  }

  var _currentMapType = MapType.normal;

  final Set<Marker> _markers = {};
  final Set<Marker> _typeMarkers = {};

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed(String type) {
    fetchNearbySearchLocations(type);
  }

  void _onCameraMove(CameraPosition position) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("En Yakın Yerler")),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            myLocationEnabled: true,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(children: <Widget>[
                FloatingActionButton(
                  onPressed: () => _onMapTypeButtonPressed(),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.map, size: 36.0),
                ),
                FloatingActionButton(
                  onPressed: () => _onAddMarkerButtonPressed("hospital"),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.local_hospital, size: 36.0),
                ),
                FloatingActionButton(
                  onPressed: () => _onAddMarkerButtonPressed("pharmacy"),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.local_pharmacy, size: 36.0),
                ),
                FloatingActionButton(
                  onPressed: () => _onAddMarkerButtonPressed("veterinary_care"),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.emoji_nature, size: 36.0),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
