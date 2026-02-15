class UserModel {
  final String name;
  final String id;
  final DateTime? suggestedDate;
  final bool? willTakePart;

  UserModel({
    required this.name,
    required this.id,
    this.suggestedDate,
    this.willTakePart,
  });
}
