import 'package:alexeys_returning/ui/utils/pick_map_point.dart';
import 'package:alexeys_returning/ui/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart' as latLng;

class MakeEventPage extends StatefulWidget {
  const MakeEventPage({super.key});

  @override
  State<MakeEventPage> createState() => _MakeEventPageState();
}

class _MakeEventPageState extends State<MakeEventPage> {
  double? latitude;
  double? longitude;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Создать событие", route: "/main"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Станьте организатором\nсобытия!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                Text(
                  "Заполните необходимые данные\nи нажмите кнопку \"Создать!\"",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    wordSpacing: 1.5,
                    letterSpacing: 1,
                    height: 1.0,
                  ),
                ),
                SizedBox(height: 20),
                Text("Название события", style: TextStyle(fontSize: 18)),
                TextField(
                  controller: _nameController,
                  autocorrect: false,
                  decoration: InputDecoration(hintText: "Название"),
                ),
                SizedBox(height: 20),
                Text("Описание события", style: TextStyle(fontSize: 18)),
                TextField(
                  controller: _descriptionController,
                  autocorrect: false,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(hintText: "Описание"),
                ),
                SizedBox(height: 20),
                Text("Место проведения", style: TextStyle(fontSize: 18)),
                TextField(
                  controller: _addressController,
                  autocorrect: false,
                  decoration: InputDecoration(hintText: "Место проведения"),
                ),
                SizedBox(height: 10),
                (latitude != null && longitude != null)
                    ? InkWell(
                      onTap: () {
                        setState(() {
                          latitude = null;
                          longitude = null;
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Row(
                        children: [
                          Icon(Icons.clear),
                          Text("Удалить точку", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    )
                    : InkWell(
                      onTap: () {
                        pickMapPoint(context).then((value) {
                          if (value != null) {
                            setState(() {
                              latitude = value[0];
                              longitude = value[1];
                            });
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text(
                            "Добавить точку на карте",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                SizedBox(height: 10),
                if (latitude != null && longitude != null)
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: latLng.LatLng(latitude!, longitude!),
                        initialZoom: 16,
                        interactionOptions: InteractionOptions(
                          flags:
                              InteractiveFlag.doubleTapZoom |
                              InteractiveFlag.pinchZoom |
                              InteractiveFlag.scrollWheelZoom,
                        ),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName:
                              'dev.fleaflet.flutter_map.example',
                        ),
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
                      ],
                    ),
                  ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_nameController.text.isNotEmpty) {
                          String? name = await showNameBottomSheet(context);
                          if (name != null && context.mounted) {
                            context.go("/main");
                          }
                        }
                      },
                      child: Text("Создать!", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future showNameBottomSheet(context) async {
  final TextEditingController controller = TextEditingController();
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 30,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Под каким именем другие участники будут видеть вас?",
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: controller,
              autocorrect: false,
              autofocus: true,
              decoration: InputDecoration(hintText: "Ваше имя"),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    return context.pop(controller.text);
                  }
                },
                child: Text("Создать событие!", style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      );
    },
  );
}
