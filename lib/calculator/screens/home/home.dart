import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tipcalculator/calculator/components/appbar.dart';
import 'package:tipcalculator/calculator/components/result_dialog.dart';
import 'package:tipcalculator/calculator/screens/home/components/tip_widget.dart';
import 'package:tipcalculator/calculator/utils/sharedpreferences.dart';

import 'components/bill_widget.dart';
import 'components/split_widget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HashMap<String, double> result;
  String sharedMessage = '';
  String errorMessage = "";
  final billController = TextEditingController(text: '');
  TextEditingController tipController;
  final splitController = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    loadSavedTip();
  }

  void loadSavedTip() async {
    //load default tip
    SharedPrefs.loadTip().then((value) {
      setState(() {
        tipController = TextEditingController(text: value.toString());
      });
    });
  }

  void _calculate() {
    //validate & show result
    if (billController.text.isEmpty ||
        tipController.text.isEmpty ||
        splitController.text.isEmpty) {
      result = null;
      sharedMessage = '';

      setState(() {
        errorMessage = 'Please input value to all fields!';
      });
    } else {
      setState(() {
        errorMessage = '';
      });
      //save tip
      SharedPrefs.saveTip(int.parse(tipController.text));
      //show result
      _showResult();
    }
  }

  void _showResult() {
    //hide keyboard
    FocusScope.of(context).requestFocus(new FocusNode());

    double bill = double.parse(billController.text);
    double tip = int.parse(tipController.text) / 100;
    int split = int.parse(splitController.text);
    result = HashMap.from({
      'tip': bill * tip,
      'amount': bill + bill * tip,
      'split': (bill + bill * tip) / split,
    });
    sharedMessage =
        'Bill: ${billController.text}\nTip: ${result['tip']}\nTotal: ${result['amount']}\nEach person pays: ${result['split']}';
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => ResultDialog(
              result: result,
              sharedMessage: sharedMessage,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          title: Text(
        widget.title,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            BillWidget(
              controller: billController,
            ),
            TipWidget(
              controller: tipController,
            ),
            SplitWidget(
              controller: splitController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: _calculate,
                      color: Colors.blue,
                      child: Row(
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.calculator,
                              color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "Calculate",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ), //RaisedButton
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    billController.dispose();
    tipController.dispose();
    splitController.dispose();
    super.dispose();
  }
}
