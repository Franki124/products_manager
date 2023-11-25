import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final String text;
  final Function() onTap;
  final double? width;
  final Color? textColor;
  const AnimatedButton({
    Key? key,
    this.width,
    this.textColor,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  double _animatedWidth = 0.0;
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!isHover)
          Container(
            height: 52,
            width: widget.width ?? 177,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 52,
          width: _animatedWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blue),
        ),
        InkWell(
          onHover: (value) {
            setState(() {
              isHover = !isHover;
              _animatedWidth = value ? widget.width ?? 177 : 0.0;
            });
          },
          onTap: () {
            setState(() => _animatedWidth = 250);
            widget.onTap();
          },
          child: SizedBox(
            height: 52,
            width: widget.width ?? 177,
            child: Center(
              child: Text(
                widget.text.toUpperCase(),
                style: TextStyle(
                  color: isHover
                      ? Colors.blue
                      : widget.textColor ?? Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}