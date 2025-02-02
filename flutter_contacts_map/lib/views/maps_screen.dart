import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contact.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() async {
    FirebaseFirestore.instance.collection('contatos').get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Contact contato = Contact.fromMap(doc.data(), doc.id);
        _addMarkerFromAddress(contato);
      }
    });
  }

  void _addMarkerFromAddress(Contact contato) async {
    try {
      List<Location> locations = await locationFromAddress(contato.endereco);
      if (locations.isNotEmpty) {
        Location loc = locations.first;
        Marker marker = Marker(
          markerId: MarkerId(contato.id),
          position: LatLng(loc.latitude, loc.longitude),
          infoWindow: InfoWindow(
            title: contato.nome,
            snippet: contato.telefone,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );

        setState(() {
          markers.add(marker);
        });
      }
    } catch (e) {
      print("Erro ao buscar endereço: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapa de Contatos")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-10.9472, -37.0731), // Posição inicial (exemplo)
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            mapController = controller;
          });
        },
        markers: markers,
      ),
    );
  }
}
