import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import "package:flutter/services.dart";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{

  State<StatefulWidget> createState() => MyAppState();


 }



 class MyAppState extends State<MyApp> {

  Map<String, double> currentLocation = new Map();
  StreamSubscription<Map<String, double>> locationSubscription;

  Location location = new Location();
  String error;


  @override
  void initState() {
    super.initState();


    currentLocation['latitude'] = 0.0;
    currentLocation['longitute'] = 0.0;
    
    initPlatformState();
    locationSubscription = location.onLocationChanged().listen((Map<String,double> result) {
      setState(() {
        currentLocation = result;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(title: Text('Location'),), body:
          Center(child:
          Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text('Lat/Lng:${currentLocation['latitude']}/${currentLocation['longitude']}', style:
            TextStyle(fontSize: 20.0, color: Colors.blueAccent),)
          ],))
      )
    );
  }


  void initPlatformState() async {
    Map<String,double> my_location;
    try{
      my_location = await location.getLocation();
      error="";
    }on PlatformException catch(e) {
      if(e.code == 'PERMISSION_DENIED')
        error = 'Permission denied';
      else if (e.code == 'PERMISSION_DENIED_NEVER_ASK')
        error = 'Permission denied - please ask user to enable it from the app settings';
      my_location = null;

    }
    setState(() {
      currentLocation = my_location;
    });



  }

 }