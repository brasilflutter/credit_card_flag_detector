import 'package:credit_card_flag_detector/credit_card_flag_detector.dart';
import 'package:flutter/material.dart';

import 'credit_card_icon.dart';

class AddCreditCardScreen extends StatefulWidget {
  const AddCreditCardScreen({super.key});

  @override
  State<AddCreditCardScreen> createState() => _AddCreditCardScreenState();
}

class _AddCreditCardScreenState extends State<AddCreditCardScreen> {
  CreditCardFlag? flag;
  String numCard = '';

  Widget _creditCardWidget() {
    Size deviceSize = MediaQuery.of(context).size;
    double ccDrawingHeight = deviceSize.height * 0.3;
    double ccDrawingWidth = deviceSize.width * 0.8;

    return Container(
      height: ccDrawingHeight,
      color: const Color(0xffe0e0e0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Center(
          child: Container(
            width: ccDrawingWidth,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xff535252),
                  Color(0xff211e1e),
                ],
              ),
            ),

            // Overlay with credit card info
            child: Stack(
              children: <Widget>[
                // Credit Card number
                Positioned(
                  left: 20.0,
                  top: 30.0,
                  child: Text(
                    numCard.isEmpty ? "XXXX XXXX XXXX XXXX" : numCard,
                    style: const TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 20.0,
                    ),
                  ),
                ),

                // // Credit Card Type Icon
                Positioned(
                  right: 20.0,
                  top: 15.0,
                  child: CreditCardIcon(
                    flag: EnumCreditCardFlag.values
                        .where((element) => element.name == flag?.name)
                        .firstOrNull,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputSection() {
    Size deviceSize = MediaQuery.of(context).size;

    return SizedBox(
      height: deviceSize.height * 0.1,
      width: deviceSize.width,
      child: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                width: 250.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  maxLength: 19,
                  style: const TextStyle(
                    //fontFamily: UIData.ralewayFont,
                    color: Color(0xff000000),
                  ),
                  onChanged: (newCCNum) {
                    final newFlag =
                        CreditCardFlagDetector.detectCCType(newCCNum);

                    setState(() {
                      flag = newFlag.firstOrNull;
                      numCard = newCCNum;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Credit Card Number",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: const Color(0xffffffff),
        title: const Text(
          "Credit Card Validator",
          style: TextStyle(
            color: Color(0xff000000),
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _creditCardWidget(),
          _inputSection(),
        ],
      ),
    );
  }
}
