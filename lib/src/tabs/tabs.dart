import 'package:flutter/material.dart';
import 'package:dojardim/src/pages/TelaInicial.dart';
import 'package:dojardim/src/pages/cadastroPage.dart';
import 'package:dojardim/src/pages/carrinhoPage.dart';
import 'package:dojardim/src/pages/categoriasPage.dart';
import 'package:dojardim/src/pages/loginPage.dart';
import 'package:dojardim/src/pages/pedidosPage.dart';
import 'package:dojardim/src/pages/produtosPage.dart';

class Tabs extends StatefulWidget {
  var _cpf, _nome, _id, _page;

  Tabs(cpf, nome, id, page) {
    this._cpf = cpf;
    this._nome = nome;
    this._id = id;
    this._page = page;
  }

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  var cpfuser, nomeuser, iduser;

  int abaAtual = 0;
  TelaInicial telaInicial;
  categoriasPage categorias;
  produtosPage produtos;
  carrinhoPage carrinho;

  List<Widget> pages;
  Widget pagAtual;

  @override
  void initState() {
    telaInicial = TelaInicial(widget._cpf);
    categorias = categoriasPage(widget._cpf);
    produtos = produtosPage("", "", widget._cpf);
    carrinho = carrinhoPage(widget._cpf);

    pages = [telaInicial, categorias, produtos, carrinho];
    if (widget._page != "") {
      pagAtual = carrinho;
      abaAtual = 1;
    } else {
      pagAtual = telaInicial;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cpfuser = widget._cpf;
    nomeuser = widget._nome;
    iduser = widget._id;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF242C33),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          abaAtual == 0
              ? "Página Inicial"
              : abaAtual == 1
                  ? "Categorias"
                  : abaAtual == 2
                      ? "Produtos"
                      : "Carrinho",
          style: TextStyle(
              color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.account_box,
                // size: 30.0,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
              }),
          // IconButton(
          //   icon: Icon(
          //     Icons.shopping_cart,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Tabs(widget._cpf, "", "", "Carrinho")
          //     ));
          //   },
          // )
        ],
      ),

      //COLOCAR DRAWER
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => cadastroPage(iduser)));
              },
              leading: Icon(Icons.people),
              title: Text(
                "Cadastro/ Login",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        pedidosPage(widget._cpf)));
              },
              leading: Icon(Icons.access_time),
              title: Text(
                "Meus Pedidos",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),

      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: abaAtual,
        onTap: (index) {
          setState(() {
            abaAtual = index;
            pagAtual = pages[index];
          });
        },
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.gite_outlined),
            title: Text("Início"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            title: Text("Categorias"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_vintage_outlined),
            title: Text("Produtos"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            title: Text("Carrinho"),
          ),
        ],
        fixedColor: Color(0xFFFF005C),
      ),

      //TRAZER O CONTEÚDO DA PÁGINA INICIAL HOME
      body: pagAtual,
    ));
  }
}
