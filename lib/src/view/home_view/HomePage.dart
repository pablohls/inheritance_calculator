import 'package:brasil_fields/brasil_fields.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inheritance_calculator/src/controller/calculate_controller.dart';
import 'package:inheritance_calculator/src/model/herdeiro_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CalculateController>();
    return Scaffold(
        // floatingActionButton: ElevatedButton(
        //     onPressed: () {
        //       setState(() {
        //         _dropDownValue = null;
        //         _selectedRegime = "";
        //       });
        //     },
        //     child: const Icon(Icons.clear)),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Calculadora Herança"),
        ),
        body: Container(
          color: Colors.amber,
          child: Column(
            children: [
              TextField(
                autocorrect: false,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CentavosInputFormatter(moeda: true),
                ],
                decoration: const InputDecoration(
                  labelText: "Valor total Herança",
                ),
                onChanged: (text) {
                  double valor =
                      UtilBrasilFields.converterMoedaParaDouble(text);
                  controller.setInheritanceValor(valor);
                  if (controller.getHerdeirosList().isNotEmpty) {
                    controller.calculate();
                  }
                },
              ),
              Row(
                children: [
                  const Text('Deixou Viuvo?'),
                  Checkbox(
                      value: controller.getCheckWidoner(),
                      onChanged: (bool? newValue) {
                        controller.setCheckWidower(newValue!);
                      }),
                ],
              ),
              controller.getCheckWidoner()
                  ? DropdownButton(
                      isExpanded: true,
                      items: controller.getDropdownItems(),
                      value: controller.getDropDownValue(),
                      onChanged: (newValue) {
                        controller.setDropDownValue(newValue);
                      },
                    )
                  : Container(),
              TextField(
                decoration: const InputDecoration(
                    labelText: "Total Herdeiros",
                    helperText: "Desconsiderar o Viuvo(a)"),
                maxLength: 2,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    int valor = int.tryParse(text)!;
                    controller.setHeirsLength(valor);
                    controller.addHerdeiros(valor);
                  } else {
                    //controller.clear();
                    controller.setHeirsLength(0);
                    controller.addHerdeiros(0);
                  }
                },
              ),
              Expanded(
                child: (controller.getSelectedRegime() == "" &&
                        controller.getCheckWidoner() == true)
                    ? const Center(
                        child: Text("Selecione um Regime"),
                      )
                    : ListView.builder(
                        itemCount: controller.getHerdeirosList().length,
                        itemBuilder: (context, index) {
                          return HerdeiroCard(
                              model: controller.getHerdeirosList()[index]);
                        }),
              )
            ],
          ),
        ));
  }
}

class HerdeiroCard extends StatelessWidget {
  final HerdeiroModel model;
  const HerdeiroCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Text(model.titulo),
        Text("${model.porcentagem.toStringAsFixed(2)} %"),
        Text("R\$ ${model.valorFracionado!.toStringAsFixed(2)}"),
      ]),
    );
  }
}
