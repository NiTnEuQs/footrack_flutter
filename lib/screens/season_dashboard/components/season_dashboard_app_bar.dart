import 'package:flutter/material.dart';
import 'package:footrack_front/models/season.dart';

class SeasonDashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SeasonDashboardAppBar({
    super.key,
    required this.season,
  });

  final Season season;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(season.name ?? "Saison ${season.id}"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
