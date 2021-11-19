class Transferencia {
  final double valor;
  final int conta;

  Transferencia(this.valor, this.conta);

  @override
  String toString() => 'Transferencia{valor: $valor, numeroConta: $conta}';
}
