import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/database/ft_providers.dart";

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final version = ref.watch(packageInfoProvider)?.version;

    return Scaffold(
      body: Column(
        children: [
          if (version != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs2),
              child: Text(
                "Version $version",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
            ),
          if (user != null)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs2),
                  child: Text(
                    "Connecté en tant que ${user.email}",
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
                  child: ElevatedButton(
                    child: const Text("Déconnexion"),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      ref.read(userProvider.notifier).state = null;
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
