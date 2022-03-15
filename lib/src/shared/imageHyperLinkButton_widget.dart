import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageHyperLinkButton extends StatelessWidget {
  final String url;
  final String errorMessage;
  final String pathImage;
  final double altura;
  final double largura;
  const ImageHyperLinkButton({
    Key? key,
    required this.url,
    required this.errorMessage,
    required this.pathImage,
    required this.altura,
    required this.largura,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw errorMessage;
          }
        },
        child: Ink.image(
          height: altura,
          width: largura,
          fit: BoxFit.cover,
          image: AssetImage(pathImage),
        ),
      ),
    );
  }
}
