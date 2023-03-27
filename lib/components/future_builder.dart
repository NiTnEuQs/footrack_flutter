import 'package:flutter/material.dart';

class FTFutureBuilder<T> extends StatelessWidget {
  const FTFutureBuilder({
    Key? key,
    required this.future,
    required this.onDataLoaded,
  }) : super(key: key);

  final Future<T>? future;

  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot) onDataLoaded;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return const Center(child: Text('Erreur'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return onDataLoaded(context, snapshot);
      },
    );
  }
}
