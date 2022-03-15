import 'package:flutter/material.dart';

import 'package:inheritance_calculator/src/controller/calculate_controller.dart';

class ClearButton extends StatelessWidget {
  final CalculateController controller;
  const ClearButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (controller.state == CalculateState.calculate)
        ? Expanded(
            flex: 1,
            child: IconButton(
                onPressed: () {
                  controller.clear();
                },
                icon: const Icon(
                  Icons.clear_sharp,
                  color: Colors.white,
                )),
          )
        : Container();
  }
}
