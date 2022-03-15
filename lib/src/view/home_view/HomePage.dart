import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inheritance_calculator/src/shared/footer_widget.dart';
import 'package:inheritance_calculator/src/view/home_view/widgets/listHeirs_widget.dart';
import 'package:inheritance_calculator/src/view/home_view/widgets/regimeDropDownButton_widget.dart';
import 'package:provider/provider.dart';

import 'package:inheritance_calculator/src/controller/calculate_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CalculateController>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Calculadora Herança",
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: controller.getInheritanceValueController(),
                cursorColor: Colors.black,
                style: const TextStyle(fontWeight: FontWeight.w600),
                autocorrect: false,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CentavosInputFormatter(moeda: true),
                ],
                decoration: const InputDecoration(
                    labelText: "Valor total da herança",
                    labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                onChanged: (text) {
                  controller.setInheritanceValor(text);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 15),
              child: Row(
                children: [
                  const Text(
                    'Deixou Viúva(o)?',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Checkbox(
                    value: controller.getCheckWidoner(),
                    onChanged: (bool? newValue) {
                      controller.setCheckWidower(newValue!);
                    },
                    activeColor: Colors.black,
                  ),
                ],
              ),
            ),
            RegimeDropDownButton(controller: controller),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: controller.getHeirsController(),
                cursorColor: Colors.black,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                    labelText: "Outros Herdeiros",
                    helperText: "Desconsiderar a Viúva(o)",
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                maxLength: 2,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (text) {
                  controller.setHeirs(text);
                },
              ),
            ),
            Expanded(
              child: ListHeirs(controller: controller),
            ),
            Footer(
              controller: controller,
            ),
          ],
        ));
  }
}
