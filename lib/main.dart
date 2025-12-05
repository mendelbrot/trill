import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trill/app_state.dart';
import 'package:trill/home_stack.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Trill',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        ),
        home: HomeStack(),
      ),
    );
  }
}
