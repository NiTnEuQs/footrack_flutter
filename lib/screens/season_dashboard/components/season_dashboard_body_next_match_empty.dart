import 'package:flutter/material.dart';

class SeasonDashboardBodyNextMatchEmpty extends StatelessWidget {
  const SeasonDashboardBodyNextMatchEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 32.0, bottom: 16.0),
      child: Text(
        "Ajoutez des matchs dans le calendrier pour avoir accès à toutes les stats",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
