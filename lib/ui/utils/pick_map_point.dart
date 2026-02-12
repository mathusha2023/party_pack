import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<List<double>?> pickMapPoint(BuildContext context) async {
  List<double>? coords = await context.push("/pick_map_point");
  return coords;
}
