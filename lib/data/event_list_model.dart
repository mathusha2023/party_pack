class EventListModel {
  final String id;
  final String title;
  final String? date;
  final String? time;

  EventListModel({required this.title, this.date, this.time, required this.id});
}
