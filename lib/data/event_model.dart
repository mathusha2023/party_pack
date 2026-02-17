import 'package:alexeys_returning/data/user_model.dart';
import 'package:latlong2/latlong.dart' as latLng;

class EventModel {
  final String id;
  final String title;
  final String? description;
  final DateTime? date;
  final String? location;
  final latLng.LatLng? point;
  final List<UserModel> users;
  final String adminId;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.point,
    required this.users,
    required this.adminId,
  });
}
