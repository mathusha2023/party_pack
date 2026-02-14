import 'package:alexeys_returning/ui/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class EventInfoPage extends StatefulWidget {
  const EventInfoPage({super.key, required this.id});
  final String id;

  @override
  State<EventInfoPage> createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(route: "/events_list"),
      body: Center(child: Text(widget.id)),
    );
  }
}
