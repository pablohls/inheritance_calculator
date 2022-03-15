import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:inheritance_calculator/src/model/herdeiro_model.dart';

enum CalculateState { calculate, idle }

class CalculateController extends ChangeNotifier {
  var state = CalculateState.idle;

  int _heirsLength = 0;
  final _heirsController = TextEditingController();
  final List<HerdeiroModel> _heirs = [];
  double _inheritanceValue = 0;
  final _inheritanceValueController = TextEditingController();

  bool _checkWidower = false;
  dynamic _dropDownValue;
  String _selectedRegime = "";
  final _items = [
    const DropdownMenuItem(
      child: Text("Comunhão de Bens"),
      value: "Comunhão de Bens",
    ),
    const DropdownMenuItem(
      child: Text("Separação de Bens"),
      value: "Separação de Bens",
    )
  ];

  List<HerdeiroModel> getHerdeirosList() {
    return _heirs;
  }

  setInheritanceValor(String value) {
    state = CalculateState.calculate;
    var v = UtilBrasilFields.converterMoedaParaDouble(value);

    _inheritanceValue = v;
    if (_heirs.isNotEmpty) {
      calculate();
    }
    notifyListeners();
  }

  setCheckWidower(bool value) {
    state = CalculateState.calculate;
    _checkWidower = value;
    if (value == true) {
      addHeirs(1);
    } else {
      _selectedRegime = '';
      _dropDownValue = null;
      removeHerdeiros();
    }

    notifyListeners();
  }

  setDropDownValue(dynamic object) {
    state = CalculateState.calculate;
    _dropDownValue = object;
    _selectedRegime = object.toString();
    calculate();
    notifyListeners();
  }

  setHeirs(String amountHeirs) {
    state = CalculateState.calculate;

    if (amountHeirs.isNotEmpty) {
      int value = int.tryParse(amountHeirs)!;
      _heirsLength = value;
      addHeirs(value);
    } else {
      _heirsLength = 0;
      addHeirs(0);
    }
    //notifyListeners();
  }

  // setHeirsLength(int valor) {
  //   _heirsLength = valor;
  //   notifyListeners();
  // }

  TextEditingController getInheritanceValueController() {
    return _inheritanceValueController;
  }

  bool getCheckWidoner() {
    return _checkWidower;
  }

  List<DropdownMenuItem<String>> getDropdownItems() {
    return _items;
  }

  String getSelectedRegime() {
    return _selectedRegime;
  }

  dynamic getDropDownValue() {
    return _dropDownValue;
  }

  TextEditingController getHeirsController() {
    return _heirsController;
  }

  addHeirs(int amountHeirs) {
    state = CalculateState.calculate;
    if (_checkWidower == true && _heirs.isEmpty) {
      for (int i = 0; i < amountHeirs; i++) {
        HerdeiroModel heirs =
            HerdeiroModel(title: "Viúva(o)", percentage: 0, value: 0);
        _heirs.add(heirs);
      }
    } else if (_checkWidower == true && _heirs.isNotEmpty) {
      amountHeirs = _heirsLength + 1;
      _heirs.clear();
      for (int i = 0; i < amountHeirs; i++) {
        HerdeiroModel heirs = HerdeiroModel(
            title: (i == 0) ? "Viúva(o)" : "Herdeiro $i",
            percentage: 0,
            value: 0);
        _heirs.add(heirs);
      }
    } else {
      _heirs.clear();
      for (int i = 0; i < amountHeirs; i++) {
        HerdeiroModel heirs =
            HerdeiroModel(title: "Herdeiro ${i + 1}", percentage: 0, value: 0);
        _heirs.add(heirs);
      }
    }
    calculate();
  }

  removeHerdeiros() {
    _heirs.removeAt(0);
    calculate();
  }

  calculate() {
    double percentage = 100 / _heirs.length;
    for (int i = 0; i < _heirs.length; i++) {
      _heirs[i].value = _inheritanceValue;
      _heirs[i].percentage = (_selectedRegime == "Comunhão de Bens")
          ? calculateWidowerPencentage(i, _heirs.length)
          : percentage;
    }
    notifyListeners();
  }

  double calculateWidowerPencentage(int index, int tamanhoLista) {
    double value = 0;
    if (index == 0 && tamanhoLista == 1) {
      return value = 100.0;
    } else if (index == 0 && tamanhoLista > 1) {
      return value = 50.0;
    }
    return value = 50 / (tamanhoLista - 1);
  }

  clear() {
    state = CalculateState.idle;
    _heirsController.clear();
    _heirs.clear();
    _inheritanceValue = 0;
    _inheritanceValueController.clear();

    _checkWidower = false;
    _dropDownValue = null;
    _selectedRegime = "";
    notifyListeners();
  }
}
