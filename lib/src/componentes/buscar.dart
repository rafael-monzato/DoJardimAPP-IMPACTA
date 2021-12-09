import 'package:flutter/material.dart';
import 'package:dojardim/src/componentes/cardProduto.dart';
import 'package:dojardim/src/pages/produtosPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Buscar extends StatelessWidget {
  var _cpf;

  Buscar(cpf) {
    this._cpf = cpf;
  }

  var dados;

  var txtbuscar = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      child: TextFormField(
        controller: txtbuscar,
        style: TextStyle(color: Colors.grey, fontSize: 15.0),
        cursorColor: Theme.of(context).primaryColorLight,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            hintText: "Buscar Produtos",
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Color(0xFFFF005C),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          produtosPage(txtbuscar.text, "", this._cpf)));
                })),
      ),
    );
  }
}
