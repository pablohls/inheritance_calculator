class HerdeiroModel {
  String titulo;
  double porcentagem;
  double valor;
  double? get valorFracionado {
    // TODO: check for null cases here
    return (valor * porcentagem) / 100;
  }

  HerdeiroModel({
    required this.titulo,
    required this.porcentagem,
    required this.valor,
  });
}
