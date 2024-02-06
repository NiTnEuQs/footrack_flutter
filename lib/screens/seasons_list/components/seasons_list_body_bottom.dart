import 'package:flutter/material.dart';
import 'package:footrack_front/core/ui/spacings.dart';
import 'package:footrack_front/managers/package_manager.dart';

class SeasonsListBodyBottom extends StatelessWidget {
  const SeasonsListBodyBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final appName = PackageManager.packageInfo.appName;
    final version = PackageManager.packageInfo.version;
    final buildNumber = PackageManager.packageInfo.buildNumber;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.m,
        vertical: Spacing.xs,
      ),
      child: Text(
        "$appName $version ($buildNumber)",
        style: const TextStyle(color: Colors.black45),
        textAlign: TextAlign.center,
      ),
    );
  }
}
