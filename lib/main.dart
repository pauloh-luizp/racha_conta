import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // VARIAVEIS
  final _vTotal = TextEditingController();
  final _qDivi = TextEditingController();
  final _pGarcom = TextEditingController();
  var _infoService = "Vamo racha a conta";
  var _infoTudo = "Total???";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RACHA CONTA"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields() {
    _vTotal.text = "";
    _qDivi.text = "";
    _pGarcom.text = "";
    setState(() {
      _infoService = "Quanto deu tudo?!";
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Total da brincadeira", _vTotal),
              _editText("Quantos amigos", _qDivi),
              _editText("% do Garçom", _pGarcom),
              _buttonCalcular(),
              _textInfo(),
              _textInfo2(),
              _textInfo3(),
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.grey,
        ),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.orange,
        child: Text(
          "Calcular",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _calculate();
          }
        },
      ),
    );
  }

  // PROCEDIMENTO PARA CALCULAR O VALOR PARA CADA
  void _calculate() {
    setState(() {
      double total = double.parse(_vTotal.text);
      double garcom = double.parse(_pGarcom.text);
      double pessoas = double.parse(_qDivi.text);
      double servico = (total * garcom / 100);
      double tudo = (total + (total * garcom / 100));
      double pagar = (total + (total * garcom / 100)) / pessoas;
      _infoService = "$servico foi para o garçom";
      _infoTudo = "Total da brincadeira + % do garçom: $tudo";
      _infoPay = "$pagar pra cada";
    });
  }

  // // Widget text
  _textInfo() {
    return Text(
      _infoService,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 25.0),
    );
  }
}

  // // Widget text
  _textInfo2() {
    return Text(
      _infoTudo,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.red, fontSize: 25.0),
    );
  }
}

  // // Widget text
  _textInfo3() {
    return Text(
      _infoPay,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.green, fontSize: 25.0),
    );
  }
}