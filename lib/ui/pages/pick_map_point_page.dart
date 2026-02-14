import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart' as latLng;

class PickMapPointPage extends StatefulWidget {
  const PickMapPointPage({super.key});

  @override
  State<PickMapPointPage> createState() => _PickMapPointPageState();
}

class _PickMapPointPageState extends State<PickMapPointPage> {
  double? latitude;
  double? longitude;
  final defaultLatitude = 55.751244;
  final defaultLongitude = 37.618423;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque, // Кликабельная область
          onTap: () => context.pop(), // Переход на предыдущий экран
          child: Padding(
            padding: const EdgeInsets.only(left: 8), // Отступ слева
            child: Row(
              mainAxisSize: MainAxisSize.min, // Важно!
              children: [
                Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: theme.colorScheme.secondary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        title: Text(
          "Добавить точку на карте",
          style: theme.textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.hardEdge,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: latLng.LatLng(
                    latitude ?? defaultLatitude,
                    longitude ?? defaultLongitude,
                  ),
                  initialZoom: 16,
                  onTap: (tapPosition, point) {
                    if (point.latitude != latitude &&
                        point.longitude != longitude) {
                      setState(() {
                        latitude = point.latitude;
                        longitude = point.longitude;
                      });
                    } else {
                      setState(() {
                        latitude = null;
                        longitude = null;
                      });
                    }
                  },
                ),

                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  if (latitude != null && longitude != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 40,
                          height: 40,
                          point: latLng.LatLng(latitude!, longitude!),
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  // if (latitude != null && longitude != null)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity:
                              latitude != null && longitude != null ? 1 : 0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Theme.of(
                                  context,
                                ).colorScheme.secondary.withAlpha(225),
                              ),
                            ),
                            onPressed: () {
                              if (longitude == null || latitude == null) {
                                return;
                              }
                              context.pop([
                                latitude as double,
                                longitude as double,
                              ]);
                            },
                            child: Text(
                              "Выбрать",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
