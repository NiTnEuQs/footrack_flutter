import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/generics/generic_error.dart";
import "package:footrack_front/components/generics/generic_loading.dart";
import "package:footrack_front/database/ft_config.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/pages/login/ui/login_screen.dart";
import "package:footrack_front/pages/seasons/ui/seasons_screen.dart";
import "package:package_info_plus/package_info_plus.dart";
// import 'package:flutter_appcenter_bundle/flutter_appcenter_bundle.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(_setupProvider);

    return setup.when(
      data: (d) {
        final isUserConnected = ref.watch(isUserConnectedProvider);

        if (isUserConnected) {
          return const SeasonsScreen();
        } else {
          return const LoginScreen();
        }
      },
      error: (e, s) => Scaffold(body: GenericError(error: e)),
      loading: () => const Scaffold(body: GenericLoading()),
    );
  }
}

final _setupProvider = FutureProvider((ref) async {
  ref.watch(localeFutureProvider.future);
  ref.watch(orientationFutureProvider.future);

  final packageInfo = await PackageInfo.fromPlatform();
  ref.read(packageInfoProvider.notifier).state = packageInfo;

  final config = await ref.watch(remoteConfigFutureProvider.future);
  ref.read(remoteConfigProvider.notifier).state = config;

  final user = ref.watch(userStreamProvider).value;
  ref.read(userProvider.notifier).state = user;

  final account = ref.watch(accountStreamProvider).value;
  ref.read(accountProvider.notifier).state = account;

  // Will be implemented later
  // await AppCenter.startAsync(
  //   appSecretAndroid: '59ae1a3e-1468-4615-acba-13d3ae46e096',
  //   appSecretIOS: '25aac2ec-e29f-46ea-a734-589576fa6417',
  //   enableAnalytics: true,
  //   enableCrashes: true,
  //   enableDistribute: true,
  //   usePrivateDistributeTrack: false,
  //   disableAutomaticCheckForUpdate: false,
  // );
  // var res = await AppCenter.checkForUpdateAsync();
});
