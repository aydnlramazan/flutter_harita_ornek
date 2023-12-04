import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(KonumPage());
}

class KonumPage extends StatefulWidget {
  const KonumPage({Key? key}) : super(key: key);

  @override
  _KonumPageState createState() => _KonumPageState();
}

class _KonumPageState extends State<KonumPage> {
  double enlem = 0.0;
  double boylam = 0.0;

  Future<void> konumBilgisiAl() async {
    var konum = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      enlem = konum.latitude;
      boylam = konum.altitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Konum Alma"),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Text(
              "Enlem: $enlem ",
              style: const TextStyle(fontSize: 30),
            ),
            Text(
              "Boylam: $boylam ",
              style: const TextStyle(fontSize: 30),
            ),
            ElevatedButton(
              onPressed: () {
                konumBilgisiAl();
              },
              child: const Text("Konum Bilgis Al"),
            )
          ],
        )),
      ),
    );
  }
}
