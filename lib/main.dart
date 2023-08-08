
import 'package:animation_examples/screens/example_eight.dart';
import 'package:animation_examples/screens/example_nine.dart';
import 'package:animation_examples/screens/example_two.dart';
import 'package:flutter/material.dart';

import 'animation/text_wave_form.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: const TextWaveForm(text: "Hello World"),
    );
  }
}
