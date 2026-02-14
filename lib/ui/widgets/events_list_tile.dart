import 'dart:math';

import 'package:alexeys_returning/data/event_list_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventsListTile extends StatelessWidget {
  const EventsListTile({super.key, required this.event});
  final EventListModel event;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go("/events_list/${event.id}");
      },
      borderRadius: BorderRadius.circular(15),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 30,
              child: Image.asset(getRandomIcon(), width: 30, height: 30),
            ),
            title: Text(
              event.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            subtitle: Text(getDateText(event)),
          ),
        ),
      ),
    );
  }
}

String getRandomIcon() {
  final icons = [
    "assets/images/party1.png",
    "assets/images/party2.png",
    "assets/images/party3.png",
    "assets/images/party4.png",
  ];
  return icons[Random().nextInt(icons.length)];
}

String getDateText(EventListModel event) {
  if (event.date != null && event.time != null) {
    return "${event.date} ${event.time}";
  } else if (event.date != null) {
    return event.date!;
  } else if (event.time != null) {
    return event.time!;
  }
  return "Н/Д";
}
