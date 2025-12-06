import 'dart:ui';
import 'package:flutter/material.dart';

Widget buildBackground() {
  return Stack(
    children: [
      Positioned.fill(
        child: Image.network(
          "https://images.unsplash.com/photo-1525182008055-f88b95ff7980",
          fit: BoxFit.cover,
        ),
      ),
      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(color: Colors.black.withOpacity(0.55)),
        ),
      ),
    ],
  );
}
