import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dojardim/src/config/config.dart';

class CardCategoria extends StatelessWidget {
  final String nomeCat;
  final String imgCat;
  final String totalProd;

  CardCategoria({
    this.nomeCat,
    this.imgCat,
    this.totalProd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 16),
        //child: Card(
        child: Padding(
            padding: EdgeInsets.only(left:8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                child: Image.network(imgCat),
                height: 67.0,
                width: 67.0,
              ),
              SizedBox(height: 8.0),
              Text(nomeCat,
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0)),
              //Text("$totalProd Produtos", style:TextStyle(fontSize:13.0)),
            ])
            //]
            )
        //)
        //)
        );
  }
}
