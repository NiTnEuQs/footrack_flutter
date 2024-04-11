import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/database/ft_providers.dart";

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Connexion avec Google"),
          onPressed: () async {
            var signInWithGoogle = await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
            ref.read(userProvider.notifier).state = signInWithGoogle.user;
          },
        ),
      ),
    );
  }
}
