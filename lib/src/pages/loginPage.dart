import 'package:flutter/material.dart';
import 'package:dojardim/src/componentes/botao.dart';
import 'package:dojardim/src/config/config.dart';
import 'package:dojardim/src/pages/cadastroPage.dart';
import 'package:dojardim/src/pages/produtosPage.dart';
import 'package:dojardim/src/tabs/tabs.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _toggleVisibility = true;

  var emailtxt = new TextEditingController();
  var senhatxt = new TextEditingController();

  var dados;
  var seguro = true;
  var conf = Configuracoes.url;

  Widget _emailtxt() {
    return TextFormField(
      controller: emailtxt,
      decoration: InputDecoration(
        hintText: "Digite seu Email",
        hintStyle: TextStyle(
          color: Color(0xFF999999),
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget _senhatxt() {
    return TextFormField(
      controller: senhatxt,
      decoration: InputDecoration(
        hintText: "Digite Sua Senha",
        hintStyle: TextStyle(
          color: Color(0xFF999999),
          fontSize: 14.0,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toggleVisibility = !_toggleVisibility;
            });
          },
          icon: _toggleVisibility
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
      ),
      obscureText: _toggleVisibility,
    );
  }

  @override
  Widget build(BuildContext context) {
    //MENSAGEM DADOS INCORRETOS
    void MensagemDadosIncorretos() {
      var alert = new AlertDialog(
        title: new Text("Dados Incorretos"),
        content: new Text("Usuário ou Senha incorretos"),
      );
      //showDialog(context: context, child: alert);
    }

    //FUNCAO DO LOGIN
    Future<String> Login(String usuario, String senha) async {
      var response = await http.get(
          Uri.encodeFull(
              conf + "usuarios/login.php?usuario=${usuario}&senha=${senha}"),
          headers: {"Accept": "application/json"});

      //print(response.body);

      var obj = json.decode(response.body);
      var msg = obj["message"];
      if (msg == "Dados incorretos!") {
        MensagemDadosIncorretos();
      } else {
        dados = obj['result'];
      }
    }

    //VERIFICAR DADOS
    VerificarDados(String usuario, String senha) {
      if (dados[0]['usuario'] == usuario && dados[0]['senha'] == senha) {
        var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
              new Tabs(dados[0]['cpf'], dados[0]['nome'], dados[0]['id'], ""),
        );
        Navigator.of(context).push(route);
      } else {
        MensagemDadosIncorretos();
      }
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/imagens/login.png"),
              height: 200.0,
              width: 250.0,
            ),
            Column(
                  children: <Widget>[
                    _emailtxt(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _senhatxt(),
                  ],
            ),
            Container(alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 14),
                ),
                onPressed: () {},
                child: Text('Esqueceu sua senha?', style: TextStyle(color: Color(0xFFFF005C)),),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            GestureDetector(
              onTap: () {
                Login(emailtxt.text, senhatxt.text);
                VerificarDados(emailtxt.text, senhatxt.text);
              },
              child: Button(
                btnText: "Logar",
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Não possui Cadastro?",
                  style: TextStyle(
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0),
                ),
                SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => cadastroPage("")));
                  },
                  child: Text(
                    "Cadastre-se",
                    style: TextStyle(
                        color: Color(0xFFFF005C),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
