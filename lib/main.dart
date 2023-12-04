import 'package:flutter/material.dart';
import 'package:flutter_harita_ornek/konum_page.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BitmapDescriptor konumIcon;

  Completer<GoogleMapController> haritaKontrol = Completer();
  var baslangicKonum =
      const CameraPosition(target: LatLng(41.0614125, 28.6682028), zoom: 4);
  List<Marker> isaretler = <Marker>[];

  iconOlustur(context) {
    ImageConfiguration configuration = createLocalImageConfiguration(context);
    BitmapDescriptor.fromAssetImage(configuration, "resimler/konum.png")
        .then((icon) {
      konumIcon = icon;
    });
  }

  Future<void> konumaGit() async {
    GoogleMapController controller = await haritaKontrol.future;
    var gidilecekYer = Marker(
        markerId: const MarkerId("Id"),
        position: const LatLng(41.0614125, 28.6682028),
        infoWindow: const InfoWindow(title: "İstanbul", snippet: "İş Yeri"),
        icon: konumIcon);

    setState(() {
      isaretler.add(gidilecekYer);
    });

    var gidilecekKonum =
        const CameraPosition(target: LatLng(41.0717102, 28.9811324));
    controller.animateCamera(CameraUpdate.newCameraPosition(gidilecekKonum));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 400,
                height: 400,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: baslangicKonum,
                  markers: Set<Marker>.of(isaretler),
                  onMapCreated: (GoogleMapController controller) {
                    haritaKontrol.complete(controller);
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    konumaGit();
                  },
                  child: const Text('Konuma Git'))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
