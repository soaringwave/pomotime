import 'package:flutter/material.dart';

class BtnBoxDecoration extends StatelessWidget {
  const BtnBoxDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return BoxDecoration(
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
  }
}