// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
// create maps conroller

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(13.783548, 100.54655),
          zoom: 20,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        mapType: MapType.hybrid,

      ),
    );
  }
}
