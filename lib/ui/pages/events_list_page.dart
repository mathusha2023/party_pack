import 'package:alexeys_returning/data/event_list_model.dart';
import 'package:alexeys_returning/ui/widgets/events_list_tile.dart';
import 'package:alexeys_returning/ui/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class EventsListPage extends StatefulWidget {
  const EventsListPage({super.key});

  @override
  State<EventsListPage> createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  late final Future? _future;

  void fetch() async {
    _future = Future.delayed(Duration(seconds: 1)).then(
      (_) => List.generate(
        20,
        (index) => EventListModel(id: "$index", title: "Eventd $index"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Мои события", route: "/main"),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<EventListModel>;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return EventsListTile(event: data[index]);
                    },
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
