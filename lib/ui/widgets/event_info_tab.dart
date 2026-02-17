import 'package:alexeys_returning/data/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';

class EventInfoTab extends StatefulWidget {
  const EventInfoTab({super.key, required this.event});

  final EventModel event;

  @override
  State<EventInfoTab> createState() => _EventInfoTabState();
}

class _EventInfoTabState extends State<EventInfoTab> {
  @override
  Widget build(BuildContext context) {
    EventModel event = widget.event;
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Описание события:", style: TextStyle(fontSize: 18)),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 100),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(event.description ?? ""),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text("Время проведения:", style: TextStyle(fontSize: 18)),
            Text(getDateText(event)),
            SizedBox(height: 15),
            Text("Место проведения:", style: TextStyle(fontSize: 18)),
            Text(event.location ?? "Место проведения не назначено"),
            _mapElement(context, event),
          ],
        ),
      ),
    );
  }
}

Widget _mapElement(BuildContext context, EventModel event) {
  if (event.point != null && event.location != null) {
    return Container(
      height: 300,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: event.point!,
          initialZoom: 16,
          interactionOptions: InteractionOptions(flags: InteractiveFlag.none),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 40,
                height: 40,
                point: event.point!,
                child: Icon(Icons.location_pin, color: Colors.red, size: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }
  return Container();
}

String getDateText(EventModel event) {
  if (event.date != null) {
    DateTime date = event.date!;
    final formatter = DateFormat('EEEE, d MMMM yyyy, HH:mm', 'ru');
    String result = formatter.format(date);
    return result[0].toUpperCase() + result.substring(1);
  }
  return "Время проведения не назначено";
}
