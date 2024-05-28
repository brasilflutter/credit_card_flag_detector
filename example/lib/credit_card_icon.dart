import 'package:credit_card_flag_detector/credit_card_flag_detector.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreditCardIcon extends StatelessWidget {
  final EnumCreditCardFlag? flag;

  const CreditCardIcon({super.key, required this.flag});

  @override
  Widget build(BuildContext context) {
    if (flag == null) {
      return Container(
        color: const Color(0x00000000),
      );
    }

    double ccIconSize = 50.0;
    late Widget icon;
    switch (flag) {
      case EnumCreditCardFlag.visa:
        icon = Icon(
          FontAwesomeIcons.ccVisa,
          size: ccIconSize,
          color: const Color(0xffffffff),
        );
        break;

      case EnumCreditCardFlag.amex:
        icon = Icon(
          FontAwesomeIcons.ccAmex,
          size: ccIconSize,
          color: const Color(0xffffffff),
        );
        break;

      case EnumCreditCardFlag.maestro:
      case EnumCreditCardFlag.mastercard:
        icon = Icon(
          FontAwesomeIcons.ccMastercard,
          size: ccIconSize,
          color: const Color(0xffffffff),
        );
        break;

      case EnumCreditCardFlag.discover:
        icon = Icon(
          FontAwesomeIcons.ccDiscover,
          size: ccIconSize,
          color: const Color(0xffffffff),
        );
        break;

      case EnumCreditCardFlag.dinersClub:
        icon = Icon(
          FontAwesomeIcons.ccDinersClub,
          size: ccIconSize,
          color: const Color(0xffffffff),
        );
        break;

      case EnumCreditCardFlag.jcb:
        icon = Icon(
          FontAwesomeIcons.ccJcb,
          size: ccIconSize,
          color: const Color(0xffffffff),
        );
        break;

      // Don't have icons for the rest
      default:
        icon = Container(
          color: const Color(0x00000000),
          child: Text(flag!.name,
              style: const TextStyle(
                color: Color(0xffffffff),
                fontSize: 20.0,
              )),
        );
    }

    return icon;
  }
}
