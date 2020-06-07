import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BillWidget extends StatelessWidget {
  final TextEditingController controller;

  const BillWidget({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 50,
            child: FaIcon(
              FontAwesomeIcons.moneyBill,
              color: Colors.blue,
            ),
          ),
          Flexible(
            child: TextField(
              decoration: InputDecoration(labelText: "Bill (\$)"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
