import 'package:flutter/material.dart';

import 'package:inheritance_calculator/src/controller/calculate_controller.dart';

class RegimeDropDownButton extends StatelessWidget {
  final CalculateController controller;
  const RegimeDropDownButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.getCheckWidoner()
        ? Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: DropdownButton(
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.black),
              hint: const Text("Tipo de Regime"),
              isExpanded: true,
              items: controller.getDropdownItems(),
              value: controller.getDropDownValue(),
              onChanged: (newValue) {
                controller.setDropDownValue(newValue);
              },
            ),
          )
        : Container();
  }
}
