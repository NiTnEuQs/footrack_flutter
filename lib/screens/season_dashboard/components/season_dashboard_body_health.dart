import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/core/ui/spacings.dart';
import 'package:footrack_front/extensions/matchs_extensions.dart';
import 'package:footrack_front/models/match.dart';

class SeasonDashboardBodyHealth extends ConsumerWidget {
  const SeasonDashboardBodyHealth({
    super.key,
    required this.matchs,
    required this.take,
    this.onClick,
  });

  final List<Match> matchs;
  final int take;
  final Function()? onClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var lastPlayedMatchs = matchs.lastPlayed(take);

    return InkWell(
      onTap: () {
        onClick?.call();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: Spacing.xl2, right: Spacing.xl2, top: Spacing.m, bottom: Spacing.m),
        child: Center(
          child: Column(
            children: [
              Text(
                "Forme",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: Spacing.xs),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: lastPlayedMatchs
                    .map(
                      (e) => Icon(
                        Icons.circle,
                        color: e.resultColor(ref),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: Spacing.xs),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.sports_soccer,
                    color: Colors.lightGreen,
                  ),
                  const SizedBox(width: Spacing.xs),
                  Text(
                    "${lastPlayedMatchs.nbGoals(ref)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen,
                    ),
                  ),
                  const SizedBox(width: Spacing.m),
                  const Icon(
                    Icons.sports_soccer,
                    color: Colors.red,
                  ),
                  const SizedBox(width: Spacing.xs),
                  Text(
                    "${lastPlayedMatchs.nbGoalsOpponents(ref)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: Spacing.m),
                  Text(
                    "+${lastPlayedMatchs.nbPoints(ref)} / ${take * 3}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
