import 'package:flutter/material.dart';

import '../../../model/herdeiro_model.dart';

class HerdeiroCard extends StatelessWidget {
  final HerdeiroModel model;
  const HerdeiroCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: SizedBox(
        height: 45,
        width: double.maxFinite,
        child: Card(
          elevation: 10,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text(
              model.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              "${model.percentage.toStringAsFixed(2)} %",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
                child: Text(
              model.fractionedValue!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ))
          ]),
        ),
      ),
    );
  }
}
