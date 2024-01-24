// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

  //onde a execução do programa começa - principal

  void main() {
    runApp(const Aplicativo());   //roda aplicativo

  }
  //classe aplicativo (contén caracteristicas, variaveis e funções)
  //extens - extende - Herda caracteristicas do widget stateless
  //stateless - toda interface é imutavel após a criação 
  class Aplicativo extends StatelessWidget {
  const Aplicativo({super.key});// classe pai

    //build - método que recostroi tela
      @override
  Widget build(BuildContext context) {
    //widget responsável pelo design da aplicação, fornece temas e recursos

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home - tela principal - scaffold fornece layout basico
      home : Scaffold(
        appBar: AppBar(                                         //barra superior
          backgroundColor: Color.fromARGB(255, 0, 42, 255),   //cor do fundo da barra
          title: const Text(                                    //coloca titulo/texto na barra
            'UADAHEL',
          style: TextStyle(color: Colors.white),              //alterar a cor do texto

          ),
        ),
        
        //corpo do app
        body: const Center(
          child: SizedBox(
            child: Text(
              'Hello World',
               style: TextStyle(
                fontSize: 30,
                fontFamily: 'roboto',
                ),
              ),
            height: 200,
            width: 200,
          ),
        ),
        
        //botão flutuante no canto direito abaixo
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 0, 42, 255), //altera a cor do botão
          child: Icon(Icons.add),                                   //icone do botão
          onPressed: () {},                                         //ação ao clicar
        ),

      //barra de navegação inferior
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Principal'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Negócios'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'escola'),
        ]),

        //barra lateral do aplictivo
        drawer: Drawer(
          backgroundColor: Colors.white,
          //lista dos itens do menu
          child: ListView(
            children: const <Widget> [

              DrawerHeader(decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'Menu App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                )
              ),
             ),

             ListTile(
              leading: Icon(Icons.home),
              title: Text('Página Inicial'),
              //onTap: () {}
             ),

             ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              //onTap: (){}
             ),

             ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Perfil'),
              //onTap: (){}
             ),
            ],
          ),
        ),

      ),
    );
  }
}

