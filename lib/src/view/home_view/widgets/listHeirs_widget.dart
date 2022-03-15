import 'package:flutter/material.dart';
import 'package:inheritance_calculator/src/controller/calculate_controller.dart';

import 'herdeiro_card_widget.dart';

class ListHeirs extends StatelessWidget {
  final CalculateController controller;
  const ListHeirs({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (controller.getSelectedRegime() == "" &&
            controller.getCheckWidoner() == true)
        ? const Center(
            child: Text(
              "Selecione um Regime",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
                itemCount: controller.getHerdeirosList().length,
                itemBuilder: (context, index) {
                  return HerdeiroCard(
                      model: controller.getHerdeirosList()[index]);
                }),
          );
  }
}
