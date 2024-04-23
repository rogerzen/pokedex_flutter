import 'package:flutter/material.dart';

class TextDetails extends StatefulWidget {
  final String title;
  final String secondText;
  final String? thirdText;
  const TextDetails(
      {super.key,
      required this.title,
      required this.secondText,
      this.thirdText});

  @override
  State<TextDetails> createState() => _TextDetailsState();
}

class _TextDetailsState extends State<TextDetails> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            text: widget.title,
            style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 25),
          ),
          TextSpan(
            text: widget.secondText,
            style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 25),
          ),
          TextSpan(
            text: widget.thirdText,
            style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 25),
          ),
        ],
      ),
    );
  }
}
