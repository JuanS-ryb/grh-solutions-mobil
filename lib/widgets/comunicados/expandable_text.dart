import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int chunkSize; // cantidad de palabras por bloque

  const ExpandableText({
    Key? key,
    required this.text,
    this.chunkSize = 50,
  }) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late List<String> _words;
  int _visibleWords = 0;

  @override
  void initState() {
    super.initState();
    _words = widget.text.split(" ");
    _visibleWords = widget.chunkSize;
  }

  void _showMore() {
    setState(() {
      _visibleWords += widget.chunkSize;
      if (_visibleWords > _words.length) {
        _visibleWords = _words.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFinished = _visibleWords >= _words.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _words.take(_visibleWords).join(" "),
          style: const TextStyle(fontSize: 14),
        ),
        if (!isFinished) // mostrar botón solo si hay más
          TextButton(
            onPressed: _showMore,
            child: const Text("Ver más"),
          ),
      ],
    );
  }
}
