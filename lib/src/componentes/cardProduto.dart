import 'dart:convert';
import 'package:dojardim/src/config/config.dart';
import 'package:dojardim/src/pages/TelaInicial.dart';
import 'package:dojardim/src/pages/loginPage.dart';
import 'package:dojardim/src/tabs/tabs.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CardProduto extends StatefulWidget {
  var _altura, _largura, _nomebusca, _idcat, _cpf;

  CardProduto(altura, largura, nomebusca, idcat, cpf) {
    this._altura = altura;
    this._largura = largura;
    this._nomebusca = nomebusca;
    this._idcat = idcat;
    this._cpf = cpf;
  }

  @override
  _CardProdutoState createState() => _CardProdutoState();
}

class _CardProdutoState extends State<CardProduto> {
  var cardText = TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  var carregando = false;
  var dados;
  var nome, imagem, valor;
  var buscar;
  var conf = Configuracoes.url;
  var conf_site = Configuracoes.url_site;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _listarDados();
  }

  _listarDados() async {
    buscar = widget._nomebusca;

    var response = await http.get(
        Uri.encodeFull(
            conf + "produtos/listar.php?nome=${buscar}&idcat=${widget._idcat}"),
        headers: {"Accept": "application/json"});
    final map = json.decode(response.body);
    final itens = map["result"];
    if (map["result"] == 'Dados não encontrados!') {
      mensagem();
    } else {
      setState(() {
        carregando = true;
        this.dados = itens;
      });
    }
  }

  mensagem() {
    var alert = new AlertDialog(
      title: new Text('Listar Dados'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text("Produto não encontrado"),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Ok'),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Tabs("", "", "", "")));
          },
        ),
      ],
    );
    //showDialog(context: context, child: alert);
  }


  //método para inserir na api
  void InserirCarrinho(cpf, id) async {
    var url = conf + "carrinho/inserir.php";
    var response = await http.post(url, body: {
      "cpf": cpf,
      "id": id,
    });

    Toast.show("Item Adicionado", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: widget._altura,
            width: widget._largura,
            child: !carregando
                ? new LinearProgressIndicator()
                : new ListView.builder(
                    itemCount: this.dados != null ? this.dados.length : 0,
                    itemBuilder: (context, i) {
                      final item = this.dados[i];

                      return new Container(
                        margin:
                            EdgeInsets.only(left: 0.0, right: 0.0, bottom: 8.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                                child: Image.network(item['imagem'])),
                            Positioned(
                              left: 0.0,
                              bottom: 0.0,
                              width: 800.0,
                              height: 60.0,
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                      Colors.black,
                                      Colors.black12
                                    ])),
                              ),
                            ),
                            Positioned(
                              left: 10.0,
                              bottom: 10.0,
                              right: 10.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        item['nome'],
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "R\u{0024}" + item['valor'],
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            if (widget._cpf == '' ||
                                                widget._cpf == null) {
                                              Toast.show("Necessário fazer login para adicionar", context,
                                                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                            } else {
                                              InserirCarrinho(
                                                  widget._cpf, item['id']);
                                            }
                                          },
                                          child: Text("Adicionar ao Carrinho",
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFFFF4D8D)))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
          )
        ],
      ),
    );
  }
}
