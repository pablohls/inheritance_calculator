import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool checkValue = false;
  dynamic _dropDownValue;
  int _myItems = 0;
  String _selectedRegime = "";
  final items = [
    const DropdownMenuItem(
      child: Text("Comunhão de Bens"),
      value: "Comunhão de Bens",
    ),
    const DropdownMenuItem(
      child: Text("Separação de Bens"),
      value: "Separação de Bens",
    )
  ];

  @override
  Widget build(BuildContext context) {
    var screenDevice = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: ElevatedButton(
            onPressed: () {
              setState(() {
                _dropDownValue = null;
                _selectedRegime = "";
              });
            },
            child: Icon(Icons.clear)),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Calculadora Herança"),
        ),
        body: Container(
          height: screenDevice.height * 1,
          width: screenDevice.width * 1,
          color: Colors.amber,
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(labelText: "Valor total Herança"),
              ),
              Row(
                children: [
                  const Text('Deixou Viuvo?'),
                  Checkbox(
                      value: checkValue,
                      onChanged: (bool? newValue) {
                        setState(() {
                          if (newValue == true) {
                            _myItems++;
                          } else {
                            _myItems--;
                          }
                          checkValue = newValue!;
                        });
                      }),
                ],
              ),
              checkValue
                  ? DropdownButton(
                      isExpanded: true,
                      items: items,
                      value: _dropDownValue,
                      onChanged: (newValue) {
                        setState(() {
                          _dropDownValue = newValue;
                          _selectedRegime = newValue.toString();
                        });
                      },
                    )
                  : Container(),
              TextField(
                decoration: const InputDecoration(
                    labelText: "Total Herdeiros",
                    helperText: "Desconsiderar o Viuvo(a)"),
                onChanged: (text) {
                  setState(() {
                    if (text.isNotEmpty) {
                      _myItems = _myItems + int.tryParse(text)!;
                    }
                    if (text.isEmpty && checkValue == false) {
                      _myItems = 0;
                    }
                    if (text.isEmpty && checkValue == true) {
                      _myItems = 1;
                    }
                  });
                },
              ),
              Expanded(
                child: (_selectedRegime == "" && checkValue == true)
                    ? const Center(
                        child: Text("Selecione um Regime"),
                      )
                    : ListView.builder(
                        itemCount: _myItems,
                        itemBuilder: (context, index) {
                          return Text("Herdeiro ${index + 1}");
                        }),
              )
            ],
          ),
        ));
  }
}
