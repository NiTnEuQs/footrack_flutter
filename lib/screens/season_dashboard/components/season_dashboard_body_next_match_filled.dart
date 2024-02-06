import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/models/opponent.dart';

class SeasonDashboardBodyNextMatchFilled extends StatelessWidget {
  const SeasonDashboardBodyNextMatchFilled({
    super.key,
    required this.ref,
    required this.nextMatch,
    required this.nextMatchOpponent,
    this.onClick,
  });

  final WidgetRef ref;
  final Match nextMatch;
  final Opponent nextMatchOpponent;
  final Function(Match)? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick?.call(nextMatch);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 32.0, bottom: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: "Prochain match contre"),
                        TextSpan(
                            text: " ${nextMatchOpponent.name}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "le ${nextMatch.date.toDateTime().formatWithTimeAndDay()}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
