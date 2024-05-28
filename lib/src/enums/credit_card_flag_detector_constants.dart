import '../models/credit_card_flag_model.dart';
import '../models/models.dart';
import 'security_code_enum.dart';

enum EnumCreditCardFlag {
  visa(
    type: 'visa',
    name: 'Visa',
    ccNumLength: [16, 18, 19],
    cardNumPattern: [
      ['4'],
    ],
    securityCode: EnumSecurityCode.cvv,
  ),
  mastercard(
    type: 'mastercard',
    name: 'Mastercard',
    ccNumLength: [16],
    cardNumPattern: [
      ['51', '55'],
      ['2221', '2229'],
      ['223', '229'],
      ['23', '26'],
      ['270', '271'],
      ['2720'],
    ],
    securityCode: EnumSecurityCode.cvc,
  ),
  amex(
    type: 'american_express',
    name: 'American Express',
    ccNumLength: [15],
    cardNumPattern: [
      ['34'],
      ['37'],
    ],
    securityCode: EnumSecurityCode.cid4,
  ),
  discover(
    type: 'discover',
    name: 'Discover',
    ccNumLength: [16, 19],
    cardNumPattern: [
      ['6011'],
      ['644', '649'],
      ['65'],
    ],
    securityCode: EnumSecurityCode.cid3,
  ),
  dinersClub(
    type: 'diners_club',
    name: "Diner's Club",
    ccNumLength: [14, 16, 19],
    cardNumPattern: [
      ['300', '305'],
      ['36'],
      ['38'],
      ['39'],
    ],
    securityCode: EnumSecurityCode.cvv,
  ),
  jcb(
    type: 'jcb',
    name: 'JCB',
    ccNumLength: [16, 17, 18, 19],
    cardNumPattern: [
      ['3528', '3589'],
      ['2131'],
      ['1800'],
    ],
    securityCode: EnumSecurityCode.cvv,
  ),
  unionPay(
    type: 'unionpay',
    name: 'UnionPay',
    ccNumLength: [14, 15, 16, 17, 18, 19],
    cardNumPattern: [
      ['620'],
      ['624', '626'],
      ['62100', '62182'],
      ['62184', '62187'],
      ['62185', '62197'],
      ['62200', '62205'],
      ['622010', '622999'],
      ['622018'],
      ['622019', '622999'],
      ['62207', '62209'],
      ['622126', '622925'],
      ['623', '626'],
      ['6270'],
      ['6272'],
      ['6276'],
      ['627700', '627779'],
      ['627781', '627799'],
      ['6282', '6289'],
      ['6291'],
      ['6292'],
      ['810'],
      ['8110', '8131'],
      ['8132', '8151'],
      ['8152', '8163'],
      ['8164', '8171'],
    ],
    securityCode: EnumSecurityCode.cvn,
  ),
  maestro(
    type: 'maestro',
    name: 'Maestro',
    ccNumLength: [12, 13, 14, 15, 16, 17, 18, 19],
    cardNumPattern: [
      ['493698'],
      ['500000', '506698'],
      ['506779', '508999'],
      ['56', '59'],
      ['63'],
      ['67'],
    ],
    securityCode: EnumSecurityCode.cvc,
  ),
  elo(
    type: 'elo',
    name: 'Elo',
    ccNumLength: [16],
    cardNumPattern: [
      ['401178'],
      ['401179'],
      ['438935'],
      ['457631'],
      ['457632'],
      ['431274'],
      ['451416'],
      ['457393'],
      ['504175'],
      ['506699', '506778'],
      ['509000', '509999'],
      ['627780'],
      ['636297'],
      ['636368'],
      ['650031', '650033'],
      ['650035', '650051'],
      ['650405', '650439'],
      ['650485', '650538'],
      ['650541', '650598'],
      ['650700', '650718'],
      ['650720', '650727'],
      ['650901', '650978'],
      ['651652', '651679'],
      ['655000', '655019'],
      ['655021', '655058'],
    ],
    securityCode: EnumSecurityCode.cve,
  ),
  mir(
    type: 'mir',
    name: 'Mir',
    ccNumLength: [16, 17, 18, 19],
    cardNumPattern: [
      ['2200', '2204'],
    ],
    securityCode: EnumSecurityCode.cvp2,
  ),
  hiper(
    type: 'hiper',
    name: 'Hiper',
    ccNumLength: [16],
    cardNumPattern: [
      ['637095'],
      ['637568'],
      ['637599'],
      ['637609'],
      ['637612'],
      ['63743358'],
      ['63737423'],
    ],
    securityCode: EnumSecurityCode.cvc,
  ),
  hipercard(
    type: 'hipercard',
    name: 'Hipercard',
    ccNumLength: [16],
    cardNumPattern: [
      ['606282'],
    ],
    securityCode: EnumSecurityCode.cvc,
  );

  /// Predefined card brands
  final String type;

  /// Predefined pretty printed card brands
  final String name;

  /// A mapping of possible credit card types to their respective possible
  /// card number length defaults
  final List<int> ccNumLength;

  /// A mapping of possible credit card types to their respective security
  /// code defaults
  final List<List<String>> cardNumPattern;
  final EnumSecurityCode securityCode;

  /// A [List<String>] represents a range.
  /// i.e. ['51', '55'] represents the range of cards starting with '51'
  /// to those starting with '55'
  List<PatternModel> get cardNumPatternDefaults =>
      cardNumPattern.map((e) => PatternModel(e)).toList();
  CreditCardFlag get creditCardFlag => CreditCardFlag(
        type: type,
        name: name,
        lengths: ccNumLength,
        patterns: cardNumPatternDefaults,
        securityCode: securityCode.securityCode,
      );
  const EnumCreditCardFlag({
    required this.type,
    required this.name,
    required this.ccNumLength,
    required this.cardNumPattern,
    required this.securityCode,
  });
}
