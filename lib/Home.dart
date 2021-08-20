import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado = "0";

  void _buscarBitcoin() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> _retorno = jsonDecode(response.body);

    setState(() {
      _resultado = _retorno["BRL"]["buy"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsetsDirectional.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("images/bitcoin.png"),
            Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                "R\$ "+ _resultado,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _buscarBitcoin();
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Atualizar",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
