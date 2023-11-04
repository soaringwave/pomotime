import 'package:flutter/material.dart';

class IconButtonContainer extends StatefulWidget {
  const IconButtonContainer({
    super.key,
    required this.childWidget,
  });
  final Widget childWidget;

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
            color: Colors.black.withOpacity(0.3),
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
