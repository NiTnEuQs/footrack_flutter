import 'package:flutter/material.dart';
import 'package:footrack_front/core/ui/spacings.dart';

class SeasonDashboardBodyNextMatchNoMatch extends StatelessWidget {
  const SeasonDashboardBodyNextMatchNoMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Spacing.xl2, right: Spacing.xl2, top: Spacing.xl2, bottom: Spacing.m),
      child: Text(
        "Il n'y a pas de match prochainement",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
