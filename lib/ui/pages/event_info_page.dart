import 'package:alexeys_returning/data/event_model.dart';
import 'package:alexeys_returning/data/user_model.dart';
import 'package:alexeys_returning/ui/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class EventInfoPage extends StatefulWidget {
  const EventInfoPage({super.key, required this.id});
  final String id;

  @override
  State<EventInfoPage> createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfoPage> {
  late Future _future;

  void fetch() {
    _future = Future.delayed(Duration(seconds: 1)).then((_) {
      var users = List.generate(
        10,
        (index) => UserModel(name: "Alexey", id: "$index"),
      );
      return EventModel(
        id: widget.id,
        title: "ALLAHBABAH",
        description: "SKJJKSHDJBksf",
        date: DateTime.now(),
        location: null,
        point: null,
        users: users,
        adminId: "2",
      );
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          EventModel data = snapshot.data;
          return Scaffold(
            appBar: MyAppBar(route: "/events_list", title: data.title),
            body: Center(child: Text(widget.id)),
          );
        }
        return Scaffold(
          appBar: MyAppBar(route: "/events_list"),
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
