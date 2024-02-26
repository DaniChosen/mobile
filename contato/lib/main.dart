import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main(){
  runApp(const Contato());
}

class Contato extends StatelessWidget{
  const Contato({super.key});

  @override
  Widget build(BuildContext contex){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      home: const Principal(title: 'Contato pessoal'),
       
    );
  }

}

class Principal extends StatefulWidget {
  const Principal({super.key, required this.title});

  final String title;

  @override
  State<Principal> createState()=> _PrincipalEstado();
  
}

class _PrincipalEstado extends State<Principal> {

final foto = const CircleAvatar(
  backgroundImage: NetworkImage("https://images.tcdn.com.br/img/img_prod/926345/adesivo_de_parede_stitch_aloha_2635_1_06318606186aa90eb7c2871a501970c5.jpg"),
  radius: 150,
);

final nome = const Text(
  'Daniela',
  style: TextStyle(fontSize: 30),
  textAlign: TextAlign.center,
);

final obs = const Text(
  'Programador Full Stack Senac',
  style: TextStyle(fontSize: 20, color: Colors.blue),
  textAlign: TextAlign.center,
);

final email = IconButton(
    icon: const Icon(Icons.mail),
    color: Colors.blue,
    onPressed: () {
      launchUrl(Uri(
        scheme: 'mailto',
        path: 'romeiro.7910@aluno.pr.senac.br',
        queryParameters: {
          'subject': 'Assunto do email',
          'body': 'Corpo do email'
        },
      ));
    },
  );

  final telefone = IconButton(
    icon: const Icon(Icons.phone),
    color: Colors.blue,
    onPressed: (){
      launchUrl(Uri(scheme: 'tel', path: '+5544991422219'));
    },

    );

    final sms = IconButton(
    icon: const Icon(Icons.sms),
    color: Colors.blue,
    onPressed: (){
      launchUrl(Uri(scheme: 'sms', path: '+5544991422219'));
    },
  );

  final site = IconButton(
    color: Colors.blue,
    icon: const Icon(Icons.open_in_browser),
    onPressed: () {
      launchUrl(Uri.parse(
          'https://www.linkedin.com/in/dani-feitoza-0a1366281/ ' ));
    },
  );

   final whatsapp = IconButton(
    color: Colors.blue,
    icon: const Icon(Icons.wechat),
    onPressed: () {
      launchUrl(Uri.parse(
          'https://api.whatsapp/+5540028922' ));
    },
  );

   final mapa = IconButton(
    color: Colors.blue,
    icon: const Icon(Icons.map),
    onPressed: () {
      launchUrl(Uri.parse(
          'https://maps.app.goo.gl/QXnhB7MyJj88VEuj9 ' ));
    },
  );




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Aplicativo de Contato', style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {},   
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          foto,nome,obs,

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            email, telefone,sms,site,whatsapp,mapa,
          ],
        )
        ],
      ),
    );
  }
}
