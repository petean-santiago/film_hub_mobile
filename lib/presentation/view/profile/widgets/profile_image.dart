import 'dart:ui';
import 'package:flutter/material.dart';

Widget profileImage(String url) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(80),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.12),
            width: 2,
          ),
        ),
        child: CircleAvatar(radius: 60, backgroundImage: NetworkImage(url)),
      ),
    ),
  );
}
