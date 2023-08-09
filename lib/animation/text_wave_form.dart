import 'dart:async';

import 'package:animation_examples/widget/char_widget.dart';
import 'package:flutter/material.dart';

class TextWaveForm extends StatefulWidget {
  final String text;

  const TextWaveForm({super.key, required this.text});

  @override
  State<TextWaveForm> createState() => _TextWaveFormState();
}

class _TextWaveFormState extends State<TextWaveForm>
    with SingleTickerProviderStateMixin {
  var loading = true;
  final char = CharNotifier();
  int initialComntainerWidth = 201;

  late AnimationController _animationControllerContainerWidth;
  late Animation<double> _animationContainerWidth;

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
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      allCharDone = true;
    });
    _animationControllerContainerWidth.forward();
    await Future.delayed(const Duration(milliseconds: 1200));
    _animationControllerContainerWidth.reverse();
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

    _animationControllerContainerWidth = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animationContainerWidth = Tween<double>(
      begin: initialComntainerWidth+widget.text.length/2,
      end: initialComntainerWidth * 0.7,
    ).animate(CurvedAnimation(parent: _animationControllerContainerWidth, curve: Curves.easeOut))
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
    _animationControllerContainerWidth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: ValueListenableBuilder(
                valueListenable: char,
                builder:
                    (BuildContext context, List<String> value, Widget? child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    height: 100,
                    width: _animationContainerWidth.value,
                    color: Colors.white,
                    child: allCharDone ?
                    Align(
                      alignment: Alignment.center,
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
                      padding: EdgeInsets.zero,
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
//


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


// Container(
// color: Colors.blue,
// child:  Text(
// "Hello World!",
// style: TextStyle(
// fontSize:  50,
// fontWeight: FontWeight.bold),
// ),
// )


// Hello World! - 274
// Creative. - 201