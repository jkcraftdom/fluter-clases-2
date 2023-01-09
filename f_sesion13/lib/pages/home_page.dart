import 'package:f_sesion13/providers/geo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final geoProvider = Provider.of<GeoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geo Location'),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            geoProvider.activeMenu();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition: geoProvider.initialLocation,
            zoomGesturesEnabled: true,
            markers:
                Set.of(geoProvider.marker != null ? [geoProvider.marker!] : []),
            circles:
                Set.of(geoProvider.circle != null ? [geoProvider.circle!] : []),
            onMapCreated: (controller) {
              geoProvider.googleMapController = controller;
            },
          ),
        ),
        Visibility(
            visible: geoProvider.isVisible,
            child: Container(
              margin: const EdgeInsets.only(top: 80, right: 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green,
              ),
              height: 200,
              width: 80,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        geoProvider.getLocationUser();
                      },
                      backgroundColor: Colors.green.shade800,
                      child: const Icon(Icons.location_searching),
                    ),
                  )
                ],
              ),
            ))
      ]),
    );
  }
}
