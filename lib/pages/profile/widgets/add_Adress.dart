import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/utils/responsive_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAdress extends StatefulWidget {
  const AddAdress({Key? key}) : super(key: key);

  @override
  _AddAdressState createState() => _AddAdressState();
}

class _AddAdressState extends State<AddAdress> {
  Future<Position> getposition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    while (permission.index == 0) {
      await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    double height = ResponsiveMediaquery(context: context).height;
    double width = ResponsiveMediaquery(context: context).width;

    Set<Marker> _makers = {};

    return Scaffold(
        body: FutureBuilder<Position>(
      future: getposition(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        Position? _position = snapshot.data;
        return Stack(
          children: [
            Container(
              height: height,
              width: width,
              child: GoogleMap(
                // myLocationButtonEnabled: true,

                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                    zoom: 10,
                    target: _position != null
                        ? LatLng(_position.latitude, _position.longitude)
                        : LatLng(10, 10)),
                markers: _makers,
                onTap: (pos) {
                  log('tapp');
                  Marker newMaker = Marker(
                      markerId: MarkerId(
                        'newMaker',
                      ),
                      infoWindow: const InfoWindow(title: 'Origin'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen),
                      position: pos);
                  setState(() {
                    _makers.add(newMaker);
                  });
                },
              ),
            ),
            Positioned(
              top: height * 0.1,
              left: width * 0.1,
              child: LocationSearchField(),
            ),
            Positioned(
                bottom: 50,
                left: 20,
                right: 20,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Save'),
                ))
          ],
        );
      },
    ));
  }
}

class LocationSearchField extends StatelessWidget {
  const LocationSearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Enter you adress',
            suffixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.only(left: 20, right: 5, bottom: 5),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
