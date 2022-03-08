import 'package:flutter/material.dart';
import 'package:inheritance_calculator/src/model/herdeiro_model.dart';

class CalculateController extends ChangeNotifier {
  int _heirsLength = 0;
  final List<HerdeiroModel> _heirs = [];
  double _inheritanceValor = 0;

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

  addHerdeiros(int amountHeirs) {
    if (_checkWidower == true && _heirs.isEmpty) {
      for (int i = 0; i < amountHeirs; i++) {
        HerdeiroModel heirs = HerdeiroModel(
            titulo: "Herdeiro ${i + 1}", porcentagem: 0, valor: 0);
        _heirs.add(heirs);
      }
    } else if (_checkWidower == true && _heirs.isNotEmpty) {
      amountHeirs = _heirsLength + 1;
      _heirs.clear();
      for (int i = 0; i < amountHeirs; i++) {
        HerdeiroModel heirs = HerdeiroModel(
            titulo: "Herdeiro ${i + 1}", porcentagem: 0, valor: 0);
        _heirs.add(heirs);
      }
    } else {
      _heirs.clear();
      for (int i = 0; i < amountHeirs; i++) {
        HerdeiroModel heirs = HerdeiroModel(
            titulo: "Herdeiro ${i + 1}", porcentagem: 0, valor: 0);
        _heirs.add(heirs);
      }
    }
    calculate();
  }

  calculate() {
    double porcentagem = 100 / _heirs.length;
    for (int i = 0; i < _heirs.length; i++) {
      _heirs[i].valor = _inheritanceValor;
      _heirs[i].porcentagem = porcentagem;
    }
    notifyListeners();
  }

  removeHerdeiros() {
    _heirs.removeAt(0);
    calculate();
  }

  bool getCheckWidoner() {
    return _checkWidower;
  }

  setCheckWidower(bool value) {
    _checkWidower = value;
    if (value == true) {
      addHerdeiros(1);
    } else {
      removeHerdeiros();
    }

    notifyListeners();
  }

  List<DropdownMenuItem<String>> getDropdownItems() {
    return _items;
  }

  setDropDownValue(dynamic object) {
    _dropDownValue = object;
    _selectedRegime = object.toString();
    notifyListeners();
  }

  String getSelectedRegime() {
    return _selectedRegime;
  }

  dynamic getDropDownValue() {
    return _dropDownValue;
  }

  setInheritanceValor(double valor) {
    _inheritanceValor = valor;
    notifyListeners();
  }

  setHeirsLength(int valor) {
    _heirsLength = valor;
    notifyListeners();
  }

  clear() {
    _heirs.clear();
    notifyListeners();
  }
}
