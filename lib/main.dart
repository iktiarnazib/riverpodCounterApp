import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodcounter/Riverpod/increment_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    loadNumber();
    super.initState();
  }

  Future saveIncrement(int savedNum) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', savedNum);
  }

  Future loadNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? current = prefs.getInt('counter');
    if (current != null) {
      ref.read(incrementProvider.notifier).state = current;
    }
  }

  @override
  Widget build(BuildContext context) {
    int num = ref.watch(incrementProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Riverpod Counter')),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Text(
                    'The increment number is $num',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(height: 110),
              ElevatedButton(
                onPressed: () {
                  ref.read(incrementProvider.notifier).state++;
                  saveIncrement(ref.read(incrementProvider));
                },

                child: Text('Increment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
