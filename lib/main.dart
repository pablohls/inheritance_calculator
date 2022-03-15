import 'package:flutter/material.dart';
import 'package:inheritance_calculator/src/controller/calculate_controller.dart';
import 'package:inheritance_calculator/src/view/home_view/HomePage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  Intl.defaultLocale = 'pt_BR';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CalculateController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculadora Herança',
        theme: ThemeData(primaryColor: Colors.black
            //primarySwatch: Colors.blue,
            ),
        home: const HomePage(),
      ),
    );
  }
}
