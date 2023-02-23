import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var address;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                var status = await Permission.location.status;
                if (status.isDenied) {
                  await [Permission.camera, Permission.location].request();

                  // Permission.location.request(); // only one permission
                }
              },
              child: Text("permission"),
            ),
            ElevatedButton(
              onPressed: () async {
                Position posi = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);

                print("${posi.latitude}");
                print("${posi.longitude}");

                List<Placemark> place = await placemarkFromCoordinates(
                    posi.latitude, posi.longitude);
                setState(() {
                  address = place[0];
                });
                print(address);
              },
              child: Text("location"),
            ),
            address == null ? Container() : Text("${address}"),
          ],
        )),
      ),
    );
  }
}
