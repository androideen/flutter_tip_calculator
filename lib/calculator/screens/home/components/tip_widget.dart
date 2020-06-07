import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TipWidget extends StatelessWidget {
  final TextEditingController controller;

  const TipWidget({Key key, this.controller}) : super(key: key);

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
              FontAwesomeIcons.percent,
              color: Colors.blue,
            ),
          ),
          Flexible(
            child: TextField(

              decoration: InputDecoration(
                labelText: "Tip (%)",

              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              controller: controller,

            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 50,
            child: FlatButton(
              onPressed: () {
                if (int.parse(controller.text) > 0) {
                  controller.text = (int.parse(controller.text) - 1).toString();
                } else {
                  controller.text = '0';
                }
              },
              child: FaIcon(FontAwesomeIcons.minus,
                  size: 16, color: Colors.blue,),
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 50,
            child: FlatButton(
              onPressed: () {
                controller.text = (int.parse(controller.text) + 1).toString();
              },
              child: FaIcon(
                FontAwesomeIcons.plus,
                size: 16,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
