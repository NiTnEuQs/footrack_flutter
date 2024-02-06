import 'package:flutter/material.dart';
import 'package:footrack_front/extensions/matchs_extensions.dart';
import 'package:footrack_front/models/match.dart';

class SeasonDashboardBodySituation extends StatelessWidget {
  const SeasonDashboardBodySituation({
    super.key,
    required this.matchs,
    this.onClick,
  });

  final List<Match> matchs;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    var playedMatchsRatio = matchs.playedMatchsRatio();
    var nbPlayedMatchs = matchs.nbPlayedMatchs();
    var nbNotPlayedMatchs = matchs.nbNotPlayedMatchs();

    return InkWell(
      onTap: () {
        onClick?.call();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0, bottom: 32.0),
        child: Column(
          children: [
            Text(
              "Situation",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: LinearProgressIndicator(
                    value: playedMatchsRatio,
                    minHeight: 24,
                    color: Colors.lightGreen,
                    backgroundColor: Colors.lightGreen.withAlpha(100),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$nbPlayedMatchs joués",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "$nbNotPlayedMatchs restants",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
