import 'package:flutter/material.dart';

import 'package:inheritance_calculator/src/controller/calculate_controller.dart';
import 'package:inheritance_calculator/src/shared/clearButton_widget.dart';

import 'imageHyperLinkButton_widget.dart';

class Footer extends StatelessWidget {
  final CalculateController controller;
  const Footer({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        color: Colors.black,
      ),
      padding: const EdgeInsets.only(left: 10),
      height: MediaQuery.of(context).size.height * 0.09,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: 'Powered by Pablo',
                      style: TextStyle(color: Colors.white, fontSize: 9),
                    ),
                  ]),
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Using Flutter',
                      style: TextStyle(color: Colors.white, fontSize: 9),
                    ),
                    WidgetSpan(
                      child: Image.asset(
                        'assets/images/flutter_icon.png',
                        height: 16,
                        width: 16,
                      ),
                    ),
                  ]),
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Hosting in Firebase',
                      style: TextStyle(color: Colors.white, fontSize: 9),
                    ),
                    WidgetSpan(
                      child: Image.asset(
                        'assets/images/firebase_icon.png',
                        height: 16,
                        width: 16,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          ClearButton(controller: controller),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    ImageHyperLinkButton(
                      url:
                          "https://www.linkedin.com/in/pablo-henrique-47022b57/",
                      errorMessage: 'Não foi possivel carregar o link',
                      pathImage: 'assets/images/linkedin_icon.png',
                      altura: 32,
                      largura: 32,
                    ),
                    ImageHyperLinkButton(
                      url: "https://github.com/pablohls",
                      errorMessage: "Não foi possivel carregar o link",
                      pathImage: 'assets/images/github_icon.png',
                      altura: 50,
                      largura: 50,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
