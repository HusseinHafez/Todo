import 'package:flutter/material.dart';
import 'dart:math';

class ConditionalBuilder extends StatelessWidget {
  final bool condition;

  final WidgetBuilder builder;

  final WidgetBuilder? fallback;

  const ConditionalBuilder({super.key, 
    required this.condition,
    required this.builder,
    required this.fallback,
  });

  @override
  Widget build(BuildContext context) => condition
      ? builder(context)
      : fallback != null
          ? fallback!(context)
          : Container();

  // generate random between minimum and maximum
  int generateRandom({required int min, required int max,}) {
    return min + Random.secure().nextInt(max - min);
  }
}