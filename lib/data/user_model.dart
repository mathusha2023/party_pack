class UserModel {
  final String name;
  final String id;
  final DateTime? suggestedDate;
  final bool isAdmin;
  final bool? willTakePart;

  UserModel({
    required this.name,
    required this.id,
    required this.isAdmin,
    this.suggestedDate,
    this.willTakePart,
  });
}
