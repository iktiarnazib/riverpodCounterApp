import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodcounter/Riverpod/increment_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future increment() async {
      ref.read(incrementProvider.notifier).state++;
    }

    int num = ref.watch(incrementProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Riverpod Counter')),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('The increment number is $num'),
              ElevatedButton(onPressed: increment, child: Text('Increment')),
            ],
          ),
        ),
      ),
    );
  }
}
