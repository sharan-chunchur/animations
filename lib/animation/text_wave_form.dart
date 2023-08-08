import 'dart:async';

import 'package:animation_examples/widget/char_widget.dart';
import 'package:flutter/material.dart';

class TextWaveForm extends StatefulWidget {
  final String text;

  const TextWaveForm({super.key, required this.text});

  @override
  State<TextWaveForm> createState() => _TextWaveFormState();
}

class _TextWaveFormState extends State<TextWaveForm> with SingleTickerProviderStateMixin{
  var loading = true;
  final char = CharNotifier();

  late AnimationController _animationControllerFontSize;
  late Animation<double> _animationFontSize;

  late String text;
  int i = 0;
  bool allCharDone = false;

  Future<void> textToChar(int textLength) async {
    while (i < textLength) {
      await Future.delayed(const Duration(milliseconds: 50));
      char.updateChar(text[i]);
      i++;
    }
    await restart();
  }

  Future<void> restart() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      allCharDone = true;
    });
    _animationControllerFontSize.forward();
    await Future.delayed(const Duration(milliseconds: 1200));
    _animationControllerFontSize.reverse();
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      allCharDone = false;
    });

    char.removerChars();
    i = 0;
    textToChar(widget.text.length);
  }

  @override
  void initState() {
    loadingTime();

    _animationControllerFontSize =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animationFontSize = Tween<double>(
      begin: 200,
      end: 150,
    ).animate(CurvedAnimation(parent: _animationControllerFontSize, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });
    // _animationControllerFontSize.forward();
    text = widget.text;
    textToChar(widget.text.length);
    super.initState();
  }

  Future<void> loadingTime() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      loading = false;
    });
  }
  @override
  void dispose() {
    _animationControllerFontSize.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
      // backgroundColor: Colors.white,
            body: Center(
              child: ValueListenableBuilder(
                valueListenable: char,
                builder:
                    (BuildContext context, List<String> value, Widget? child) {
                  return Container(
                    height: 100,
                    width: _animationFontSize.value,
                    color: Colors.white,
                    child: allCharDone ?
                       Align(
                         alignment: Alignment.centerLeft,
                         child:  FittedBox(
                           fit: BoxFit.scaleDown,
                           child: Text(
                             widget.text,
                             style: const TextStyle(
                                 fontSize: 50,
                                 color: Colors.red,
                                 fontWeight: FontWeight.bold),
                           ),
                         ),
                       )
                    : ListView.builder(
                        itemCount: char.value.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Center(
                              child:  CharWidget(
                            char: char.value[index],
                            isCharDone: allCharDone,
                              ));
                        }),
                  );
                },
              ),
            ),
          );
  }
}

class CharNotifier extends ValueNotifier<List<String>> {
  CharNotifier() : super([]);

  updateChar(String char) {
    final List<String> newChar = value;
    newChar.add(char);
    notifyListeners();
  }

  removerChars() {
    final List<String> newList = value;
    newList.clear();
    notifyListeners();
  }
}
