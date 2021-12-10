import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dojardim/src/config/config.dart';
import 'package:dojardim/src/pages/carrinhoPage.dart';
import 'package:dojardim/src/pages/loginPage.dart';
import 'package:dojardim/src/tabs/tabs.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class pedidosPage extends StatefulWidget {
  var _cpf;

  pedidosPage(cpf) {
    this._cpf = cpf;
  }

  @override
  _pedidosPageState createState() => _pedidosPageState();
}

class _pedidosPageState extends State<pedidosPage> {
  // var conf = Configuracoes.url;
  //
  // var carregando = false;
  // var dados;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   _listarDados();
  // }
  //
  // _listarDados() async {
  //   var response = await http.get(
  //       Uri.encodeFull(conf + "pedidos/listar.php?cpf=${widget._cpf}"),
  //       headers: {"Accept": "application/json"});
  //   final map = json.decode(response.body);
  //   final itens = map["result"];
  //   print(map["result"]);
  //   if (map["result"] == 'Dados não encontrados!') {
  //     Toast.show("Você nao Possui Pedidos", context,
  //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //   } else {
  //     setState(() {
  //       carregando = true;
  //       this.dados = itens;
  //       print(dados);
  //     });
  //   }
  // }
  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBar(),
        body: Padding(
          padding: EdgeInsets.only(top: 36.0, left: 24.0, right:24.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image(
                image:AssetImage("assets/imagens/booked.png"),
                height:200.0,
                width:250.0,
              ),
              SizedBox(height: 36.0),
              Text(
                "Reserva efetuada com sucesso!",
                style: TextStyle(
                    color: Color(0xFF242C33),
                    fontWeight: FontWeight.w800,
                    fontSize: 24.0),
              ),
              SizedBox(height: 24.0),
              Text(
                "Lembre-se, os produtos são perecíveis e você precisa buscá-los o quanto antes, no prazo máximo de dois dias corridos. Funcionamos de segunda a sexta, das 8h às 20h.\n è necessário comparecer com o documento de identificação CPF",
                 style: TextStyle(
                     color: Color(0xFF999999),
                     fontWeight: FontWeight.w400,
                     fontSize: 16.0),
              ),
              SizedBox(height: 36.0),
              Text(
                "CEAGESP: Av. Dr. Gastão Vidigal, 1946 - Vila Leopoldina, São Paulo - SP, 05316-900 \n \nPara dúvidas e/ou reclamações ligar para o número (11)xxxx-xxxx \n\n doJardim agradece a preferência!",
                style: TextStyle(
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  appBar() {
    return AppBar(
      backgroundColor: Color(0xFF242C33),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      leading: IconButton(
          icon: Icon(
            Icons.home,
            // size: 30.0,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                    Tabs(widget._cpf, "", "", "")));
          }),
      title: Text(
        "Reserva efetuada",
        style: TextStyle(
            color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => pedidosPage(widget._cpf)));
          },
        )
      ],
    );
  }
}
