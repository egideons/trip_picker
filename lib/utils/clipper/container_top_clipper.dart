import 'package:flutter/material.dart';

// Custom Clipper for circular cutout at the top of the container
class TripContainerAvatarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Draw the rectangle for the container
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    // Add circular cutout
    path.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, 0), // Center of the cutout
      radius: 60, // Radius to match the avatar
    ));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
