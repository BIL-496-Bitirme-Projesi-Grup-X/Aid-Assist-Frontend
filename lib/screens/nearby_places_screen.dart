import 'package:aid_assist/models/nearby_search_model.dart';
import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;

class NearbyPlacesScreen extends StatefulWidget {
  @override
  _NearbyPlacesScreenState createState() => _NearbyPlacesScreenState();
}

class _NearbyPlacesScreenState extends State<NearbyPlacesScreen> {
  Completer<GoogleMapController> _controller = Completer();

  Future<NearbySearchModel> futureNearbySearchLocations;

  @override
  void initState() {
    futureNearbySearchLocations = fetchNearbySearchLocations();
    super.initState();
  }

  Future<NearbySearchModel> fetchNearbySearchLocations() async {
    var queryParameters = {
      'location': '39.9334,32.8597',
      'radius': '1500',
      'type': 'hospital',
      'key': 'AIzaSyDRNYfAWszVQ8vD39BK1XGXQxWWARH6fvM'
    };

    final response = await http.get(Uri.https('maps.googleapis.com',
        'maps/api/place/nearbysearch/json', queryParameters));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      _hospitals.clear();
      var nearbySearchLocations = nearbySearchModelFromJson(response.body);
      nearbySearchLocations.results.forEach((element) {
        _hospitals.add(Marker(
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
  }

  var _currentMapType = MapType.normal;

  final Set<Marker> _markers = {};
  final Set<Marker> _hospitals = {};

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.addAll(_hospitals);
    });
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
                  onPressed: _onAddMarkerButtonPressed,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add_location, size: 36.0),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
