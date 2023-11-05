import 'package:flutter/material.dart';

class IconButtonContainer extends StatefulWidget {
  const IconButtonContainer({
    super.key,
    required this.childWidget,
    required this.shadowColor,
  });
  final Widget childWidget;
  final Color shadowColor;

  @override
  State<IconButtonContainer> createState() => _IconButtonContainerState();
}

class _IconButtonContainerState extends State<IconButtonContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(150),
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor,
            offset: const Offset(
              0,
              5,
            ),
            blurRadius: 10,
          ),
        ],
      ),
      child: widget.childWidget,
    );
  }
}
