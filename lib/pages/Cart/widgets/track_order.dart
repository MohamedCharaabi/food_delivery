import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:im_stepper/stepper.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  int activeStep = 5;

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );

  // late GoogleMapController _googleMapController;

  // late Directions _info;

  @override
  void dispose() {
    // _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Track your order',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15),
                  Container(
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Estimated Delivery Time',
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            '05:30 PM',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      )),
                  SizedBox(height: 15),
                  Container(height: 2, color: Colors.grey[300]),
                  SizedBox(height: 15),
                  RiderRow(),
                  SizedBox(height: 15),
                  SizedBox(
                      height: height * 0.6,
                      width: width,
                      child: GoogleMap(
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                        initialCameraPosition: _initialCameraPosition,

                        // onLongPress: _addMarker,
                      )),

                  // Expanded(
                  //     child: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       StepCol(
                  //           width: width, text: 'Order confirmed', active: false),
                  //       StepCol(
                  //           width: width,
                  //           text: 'Preparing your order',
                  //           active: true),
                  //       StepCol(
                  //           width: width,
                  //           text: 'Rider picking your order',
                  //           active: false),
                  //       StepCol(
                  //           width: width, text: 'Order confirmed', active: false),
                  //     ],
                  //   ),
                  // )
                  //     // child: Stepper(
                  //     //   type: stepperType,
                  //     //   physics: ScrollPhysics(),
                  //     //   currentStep: _currentStep,
                  //     //   // onStepTapped: (step) => tapped(step),
                  //     //   // onStepContinue: continued,
                  //     //   // onStepCancel: cancel,
                  //     //   steps: <Step>[
                  //     //     Step(
                  //     //       title: new Text('Order Confirmed'),
                  //     //       content: SizedBox(),
                  //     //       isActive: _currentStep >= 0,
                  //     //       state: _currentStep >= 0
                  //     //           ? StepState.complete
                  //     //           : StepState.disabled,
                  //     //     ),
                  //     //     Step(
                  //     //       title: new Text('Preparing your order'),
                  //     //       content: Text('Address'),
                  //     //       isActive: _currentStep >= 0,
                  //     //       state: _currentStep >= 1
                  //     //           ? StepState.complete
                  //     //           : StepState.disabled,
                  //     //     ),
                  //     //     Step(
                  //     //       title: new Text('Rider picking your order'),
                  //     //       content: Text('Mobile Number'),
                  //     //       isActive: _currentStep >= 0,
                  //     //       state: _currentStep >= 2
                  //     //           ? StepState.complete
                  //     //           : StepState.disabled,
                  //     //     ),
                  //     //   ],
                  //     // ),

                  //     ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}

class StepCol extends StatelessWidget {
  const StepCol(
      {Key? key, required this.width, required this.text, required this.active})
      : super(key: key);
  final String text;
  final double width;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 6.0),
          height: 50,
          width: 3,
          color: Colors.grey[300],
        ),
        SizedBox(
          width: width,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 15.0),
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: active ? Colors.red : Colors.grey[300],
                ),
              ),
              Text('$text')
            ],
          ),
        ),
      ],
    );
  }
}

class RiderRow extends StatelessWidget {
  const RiderRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
                placeholder: (context, url) => Image.asset(
                  'assets/images/icon-food.jpg',
                  width: 70,
                  height: 70,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Your Rider',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Jason Stroll',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ],
        ));
  }
}
