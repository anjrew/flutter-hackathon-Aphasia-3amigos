import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton(
      {this.onButtonPressed, this.alignment, this.tooltip, this.icon});
  final ButtonCallback onButtonPressed;
  final Alignment alignment;
  final String tooltip;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: this.alignment,
      child: FloatingActionButton(
        onPressed: this.onButtonPressed,
        tooltip: this.tooltip,
        child: Icon(this.icon),
      ),
    );
  }
}

typedef ButtonCallback = void Function();
