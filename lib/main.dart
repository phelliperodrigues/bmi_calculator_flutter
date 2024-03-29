import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _info = "Informe seus dados!";


  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _info = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });

  }
  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 17){
        _info = "Muito abaixo do peso (${imc.toStringAsPrecision(2)})";
      }else if(imc >= 17 && imc < 18.5){
        _info = "Abaixo do peso (${imc.toStringAsPrecision(2)})";
      }else if(imc >= 18.5 && imc < 24.9){
        _info = "Peso Ideal (${imc.toStringAsPrecision(2)})";
      }else if(imc >= 24.9 && imc < 29.9){
        _info = "Levemente acima do peso (${imc.toStringAsPrecision(2)})";
      }else if(imc >= 29.9 && imc < 34.9){
        _info = "Obesidade I (${imc.toStringAsPrecision(2)})";
      }else if(imc >= 34.9 && imc < 39.9){
        _info = "Obesidade II (severa) (${imc.toStringAsPrecision(2)})";
      }else if(imc >= 40){
        _info = "Obesidade III (mórbida) (${imc.toStringAsPrecision(2)})";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields ,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Icon(Icons.person_pin, size: 120.0, color: Colors.green),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso(kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu Peso!";
                  }
                },
              ),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura(cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua Altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                child: Container(
                  height: 60.0,
                  child: RaisedButton(

                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text("Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 30.0),
              )
            ],
          ),
        )
      )
    );
  }
}
