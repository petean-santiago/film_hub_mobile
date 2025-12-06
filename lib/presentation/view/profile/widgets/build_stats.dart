import 'package:flutter/material.dart';

Widget buildStat(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.75)),
      ),
    ],
  );
}
