import 'package:flutter/material.dart';
import 'dart:math';

class Jogo extends StatefulWidget {
  const Jogo({Key? key}) : super(key: key);
  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = AssetImage("images/padrao.png");
  var _resultadoFinal = "Boa sorte!!!";
  int _pontosUsuario = 0;
  int _pontosApp = 0;
  String _escolhaUsuario = "";

  void _opcaoSelecionada(String escolhaUsuario) {
    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(3);
    var escolhaApp = opcoes[numero];

    setState(() {
      _imagemApp = AssetImage("images/$escolhaApp.png");
      _escolhaUsuario = escolhaUsuario;
    });

    if ((escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")) {
      setState(() {
        _resultadoFinal = "Parabéns!!! Você ganhou :)";
        _pontosUsuario++;
      });
    } else if ((escolhaApp == "pedra" && escolhaUsuario == "tesoura") ||
        (escolhaApp == "tesoura" && escolhaUsuario == "papel") ||
        (escolhaApp == "papel" && escolhaUsuario == "pedra")) {
      setState(() {
        _resultadoFinal = "Puxa!!! Você perdeu :(";
        _pontosApp++;
      });
    } else {
      setState(() {
        _resultadoFinal = "Empate!!! Tente novamente :/";
      });
    }
  }

  void _reiniciarPartida() {
    setState(() {
      _pontosUsuario = 0;
      _pontosApp = 0;
      _resultadoFinal = "Boa sorte!!!";
      _imagemApp = AssetImage("images/padrao.png");
      _escolhaUsuario = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('JokenPO'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  "Escolha do App",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 100,
                child: Image(image: _imagemApp),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  "Escolha uma opção abaixo:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _opcaoBotao("pedra", "PEDRA"),
                  _opcaoBotao("papel", "PAPEL"),
                  _opcaoBotao("tesoura", "TESOURA"),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  _resultadoFinal,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _resultadoFinal.contains("ganhou")
                        ? Colors.green
                        : _resultadoFinal.contains("perdeu")
                            ? Colors.red
                            : _resultadoFinal.contains("Empate")
                                ? Colors.orange
                                : Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Placar",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Você",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _pontosUsuario.toString(),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      Text(
                        "App",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _pontosApp.toString(),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: _reiniciarPartida,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(
                      horizontal: 25, vertical: 12), // Botão maior
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text(
                  "Nova partida",
                  style: TextStyle(color: Colors.black), // Texto preto
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _opcaoBotao(String escolha, String label) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _opcaoSelecionada(escolha),
          child: Container(
            decoration: BoxDecoration(
              color: _escolhaUsuario == escolha
                  ? Colors.grey[300]
                  : Colors.transparent, // Fundo escuro na seleção
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(5),
            child: Image(
              image: AssetImage('images/$escolha.png'),
              height: 80,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
