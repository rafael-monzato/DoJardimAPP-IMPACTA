import 'package:dojardim/src/pages/produtosPage.dart';
import 'package:flutter/material.dart';
import 'package:dojardim/src/componentes/buscar.dart';
import 'package:dojardim/src/componentes/cabecalho.dart';
import 'package:dojardim/src/componentes/cardProduto.dart';
import 'package:dojardim/src/componentes/categorias.dart';

class TelaInicial extends StatefulWidget {
  var _cpf;

  TelaInicial(cpf) {
    this._cpf = cpf;
  }

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  AreaCategoria area = new AreaCategoria("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0),
        children: <Widget>[
          //Cabecalho(),
          AreaCategoria(widget._cpf),
          Buscar(widget._cpf),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Produtos Mais Vendidos",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (BuildContext context) => produtosPage("","",widget._cpf)));
              //   },
              //   child: Text(
              //     "Ver Todos",
              //     style: TextStyle(
              //       color: Color(0xFFFF005C),
              //       fontWeight: FontWeight.bold,
              //       fontSize: 12.0,
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Column(
            children: <Widget>[CardProduto(460.0, 340.0, "", "", widget._cpf)],
          )
        ],
      ),
    );
  }
}
