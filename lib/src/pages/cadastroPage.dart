import 'package:flutter/material.dart';
import 'package:dojardim/src/componentes/botao.dart';
import 'package:dojardim/src/config/config.dart';
import 'package:dojardim/src/pages/loginPage.dart';
import 'package:dojardim/src/tabs/tabs.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class cadastroPage extends StatefulWidget {
  var _id;

  cadastroPage(id) {
    this._id = id;
  }

  @override
  _cadastroPageState createState() => _cadastroPageState();
}

class _cadastroPageState extends State<cadastroPage> {
  bool _toggleVisibility = true;

  String _email;
  String _nome;
  String _senha;
  String _cpf;
  String _telefone;

  var conf = Configuracoes.url;

  var nome, cpf, telefone, usuario, senha;
  var nometxt, emailtxt, senhatxt, cpftxt, telefonetxt;
  var dados;
  var caminhoImg = "assets/imagens/login.png";
  var nomebtn = "Cadastrar";

  GlobalKey<FormState> _formKey = GlobalKey();

  Widget _emailtxt() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Email",
        hintStyle: TextStyle(
          color: Color(0xFF999999),
          fontSize: 14.0,
        ),
      ),
      onSaved: (String email) {
        _email = email;
      },
      validator: (String email) {
        String errorMessage;
        if (!email.contains("@")) {
          errorMessage = "Email incorreto";
        }
        if (email.isEmpty) {
          errorMessage = "O campo email é obrigatório";
        }

        return errorMessage;
      },
    );
  }

  Widget _nometxt() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Nome completo",
        hintStyle: TextStyle(
          color: Color(0xFF999999),
          fontSize: 14.0,
        ),
      ),
      onSaved: (String username) {
        _nome = username.trim();
      },
      validator: (String username) {
        String errorMessage;
        if (username.isEmpty) {
          errorMessage = "O nome é requerido";
        }
        // if(username.length > 8 ){
        //   errorMessage = "Your username is too short";
        // }
        return errorMessage;
      },
    );
  }

  Widget _cpftxt() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "CPF somente números",
        hintStyle: TextStyle(
          color: Color(0xFF999999),
          fontSize: 14.0,
        ),
      ),
      onSaved: (String cpf) {
        _cpf = cpf.trim();
      },
      validator: (String cpf) {
        String errorMessage;
        if (cpf.isEmpty) {
          errorMessage = "O cpf é requerido";
        }
        // if(username.length > 8 ){
        //   errorMessage = "Your username is too short";
        // }
        return errorMessage;
      },
    );
  }

  Widget _telefonetxt() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Número de celular com DDD",
        hintStyle: TextStyle(
          color: Color(0xFF999999),
          fontSize: 14.0,
        ),
      ),
      onSaved: (String telefone) {
        _telefone = telefone.trim();
      },
      validator: (String telefone) {
        String errorMessage;
        if (telefone.isEmpty) {
          errorMessage = "O telefone é obrigatório";
        }
        return errorMessage;
      },
    );
  }

  Widget _senhatxt() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Senha",
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
      onSaved: (String password) {
        _senha = password;
      },
      validator: (String password) {
        String errorMessage;

        if (password.isEmpty) {
          errorMessage = "O campo senha é obrigatório";
        }
        return errorMessage;
      },
    );
  }

  mensagem(res) {
    var alert = new AlertDialog(
      title: new Text('Inserir Dados'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text(res),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    //showDialog(context: context, builder: );

    if (res == 'Inserido com Sucesso') {
      nometxt.text = "";
      telefonetxt.text = "";
      emailtxt.text = "";
      senhatxt.text = "";
      cpftxt.text = "";
    }
  }

  //VERIFICAR SE O USUÁRIO ESTÁ LOGADO, SE TIVER RECUPERAR SEUS DADOS PARA EDITAR
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget._id != "") {
      caminhoImg = "assets/imagens/excluir.png";
      nomebtn = "Editar";
      recuperarDados();
    }
    nometxt = new TextEditingController();
    emailtxt = new TextEditingController();
    senhatxt = new TextEditingController();
    cpftxt = new TextEditingController();
    telefonetxt = new TextEditingController();
  }

  //método para recuperar os dados do usuário logado
  recuperarDados() async {
    var response = await http.get(
        Uri.encodeFull(conf + "usuarios/recuperarDados.php?id=${widget._id}"),
        headers: {"Accept": "application/json"});
    final map = json.decode(response.body);
    final itens = map["result"];

    setState(() {
      this.dados = itens;

      nome = dados[0]["nome"];
      cpf = dados[0]["cpf"];
      telefone = dados[0]["telefone"];
      usuario = dados[0]["usuario"];
      senha = dados[0]["senha"];

      nometxt = new TextEditingController(text: nome);
      emailtxt = new TextEditingController(text: usuario);
      senhatxt = new TextEditingController(text: senha);
      cpftxt = new TextEditingController(text: cpf);
      telefonetxt = new TextEditingController(text: telefone);
    });
  }

  //método para inserir na api
  void _inserir() async {
    var url = conf + "usuarios/inserir.php";
    var response = await http.post(url, body: {
      "nome": nometxt.text,
      "email": emailtxt.text,
      "cpf": cpftxt.text,
      "telefone": telefonetxt.text,
      "senha": senhatxt.text,
      "id": widget._id,
    });

    final map = json.decode(response.body);
    final res = map["message"];
    print(res);
    mensagem(res);
  }

  mensagemExcluir() {
    var alert = new AlertDialog(
      title: new Text('Excluir Usuário'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text("Deseja Realmente Excluir o Usuário"),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Sim'),
          onPressed: () {
            excluirUsuario(widget._id);
          },
        ),
        new FlatButton(
          child: new Text('Não'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    //showDialog(context: context, child: alert);
  }

  excluirUsuario(id) {
    http.get(Uri.encodeFull(conf + "usuarios/excluir.php?id=${id}"),
        headers: {"Accept": "application/json"});
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => Tabs("", "", "", "")));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    mensagemExcluir();
                  },
                  child: Image(
                    image: AssetImage("assets/imagens/login.png"),
                    height: 100.0,
                    width: 250.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: <Widget>[
                    _nometxt(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _emailtxt(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _telefonetxt(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _cpftxt(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _senhatxt(),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    _inserir();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()));
                    Toast.show("Cadastro efetuado com sucesso", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  },
                  child: Button(btnText: "Cadastrar"),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Já possui Cadastro?",
                      style: TextStyle(
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0),
                    ),
                    SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()));
                      },
                      child: Text(
                        "Fazer Login",
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
        ),
      ),
    );
  }

  void onSubmit(Function authenticate) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print("Seu Email: $_email, sua senha: $_senha");
      authenticate(_email, _senha);
    }
  }
}
