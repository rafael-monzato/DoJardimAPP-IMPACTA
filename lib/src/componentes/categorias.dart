import 'dart:convert';
import 'package:dojardim/src/config/config.dart';
import 'package:dojardim/src/pages/produtosPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dojardim/src/componentes/cardCategorias.dart';

class AreaCategoria extends StatefulWidget {
  var _cpf;

  AreaCategoria(cpf) {
    this._cpf = cpf;
  }

  @override
  _AreaCategoriaState createState() => _AreaCategoriaState();
}

class _AreaCategoriaState extends State<AreaCategoria> {
  var carregando = false;
  var dados;
  var conf = Configuracoes.url;

  listarDados() async {
    var url = conf + "/produtos/listar-categorias.php";
    var response = await http.get(url);
    var map = json.decode(response.body);
    var itens = map["result"];

    setState(() {
      carregando = true;
      this.dados = itens;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.listarDados();
    print('teste');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90.0,
        margin: EdgeInsets.only(top: 10.0, bottom: 16.0),
        child: !carregando
            ? new LinearProgressIndicator()
            : new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: this.dados != null ? this.dados.length : 0,
                itemBuilder: (context, i) {
                  final item = this.dados[i];
                  print(item);
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              produtosPage("", item['id'], widget._cpf)));
                    },
                    child: CardCategoria(
                      nomeCat: item['nome'],
                      totalProd: item['produtos'],
                      imgCat: item['imagem'],
                    ),
                  );
                },
              ));
  }
}
