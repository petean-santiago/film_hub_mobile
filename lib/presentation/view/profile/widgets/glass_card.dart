import 'dart:ui';
import 'package:flutter/material.dart';

Widget glassCard({
  required double width,
  required IconData icon,
  required String title,
  VoidCallback? onTap,
  bool disabled = false,
}) {
  return Opacity(
    opacity: disabled ? 0.35 : 1,
    child: IgnorePointer(
      ignoring: disabled,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              width: width,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: disabled ? Colors.white30 : Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    title,
                    style: TextStyle(
                      color: disabled ? Colors.white38 : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right,
                    color: disabled ? Colors.white24 : Colors.white70,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
