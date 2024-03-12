// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Método que roda a aplicação.
void main() {
  runApp(Principal());
}

class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação com API',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: home(),
    );
  }
}

class home extends StatefulWidget {
  @override
  home_state createState() => home_state();
}

class home_state extends State<home> {
  // Permite manipular o texto dentro do campo de input.
  TextEditingController controleTexto = TextEditingController();
  String conteudo = '';
  String imagem = '';

  // Future retorna valor no futuro - async é método assíncrono.
  Future<void> buscar() async {
    String entrada = controleTexto.text;
    // ignore: unused_local_variable
    String url = 'https://pt.wikipedia.org/api/rest_v1/page/summary/$entrada';

    final resposta = await http.get(Uri.parse(url));

    // Se a busca estiver certa.
    if (resposta.statusCode == 200) {
      Map<String, dynamic> dado = json.decode(resposta.body);
      setState(() {
        conteudo = dado['extract'];
        imagem = dado['originalimage']['source'];
      });
    } else {
      // Se houver um erro.
      conteudo = 'Nada foi encontrado!';
      imagem = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplicativo com API',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Stack(
        children: [
          // Representa a imagem de fundo.
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://t3.ftcdn.net/jpg/01/05/54/98/360_F_105549841_qGAF80yXJ0pfwV1RsxMCLXaJ8ae2rlRY.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2- Construção do Card
          Padding(
            padding: const EdgeInsets.all(70.0),
            child: Center(
              child: Card(
                color: Color.fromARGB(169, 255, 255, 255),
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: controleTexto,
                              decoration: const InputDecoration(
                                labelText: 'Digite o texto',
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: buscar,
                            child: Icon(Icons.search, color: Colors.white),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.indigo),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        'Resultado:',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Text(conteudo, style: TextStyle(fontSize: 16.0)),
                      const SizedBox(height: 20),
                      if (imagem.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ImagemTelaInteira(imagemParametro: imagem),
                              ),
                            );
                          },
                        
                      child:Center(
                        child:Hero(
                          tag: imagem,
                          child: Image.network(
                        imagem,
                        height: 150,
                      )),
                      ),
                       ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImagemTelaInteira extends StatelessWidget {
  final String imagemParametro;

  ImagemTelaInteira({required this.imagemParametro});

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: imagemParametro,
          child: Image.network(imagemParametro),
        ),
      ),
    );
  }
}
