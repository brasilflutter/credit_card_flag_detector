import '../models/security_code.dart';

const String secCodeCvv = 'CVV';
const String secCodeCvc = 'CVC';
const String secCodeCid = 'CID';
const String secCodeCvn = 'CVN';
const String secCodeCve = 'CVE';
const String secCodeCvp2 = 'CVP2';

/// The default length of the CVV or security code (most cards do this)
const int defaultSecurityCodeLength = 3;

/// The alternate length of the security code
const int altSecurityCodeLength = 4;

enum EnumSecurityCode {
  cvv(
    name: secCodeCvv,
    length: defaultSecurityCodeLength,
  ),

  cvc(
    name: secCodeCvc,
    length: defaultSecurityCodeLength,
  ),

  cid3(
    name: secCodeCid,
    length: defaultSecurityCodeLength,
  ),

  cid4(
    name: secCodeCid,
    length: altSecurityCodeLength,
  ),

  cvn(
    name: secCodeCvn,
    length: defaultSecurityCodeLength,
  ),

  cve(
    name: secCodeCve,
    length: defaultSecurityCodeLength,
  ),

  cvp2(
    name: secCodeCvp2,
    length: defaultSecurityCodeLength,
  );

  const EnumSecurityCode({required this.name, required this.length});

  final String name;
  final int length;

  SecurityCode get securityCode => SecurityCode(name, length);
}
