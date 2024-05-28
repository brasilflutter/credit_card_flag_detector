import 'package:credit_card_flag_detector/credit_card_flag_detector.dart';
import 'package:test/test.dart';

void main() {
  // Variables used in tests
  final rupayType = CreditCardFlag(
    type: 'rupay',
    name: 'RuPay',
    lengths: [16],
    patterns: [
      PatternModel(['60']),
      PatternModel(['6526']),
      PatternModel(['81']),
      PatternModel(['82']),
      PatternModel(['508']),
    ],
    securityCode: EnumSecurityCode.cvv.securityCode,
  );
  final modifiedRupay = CreditCardFlag(
    type: 'rupay',
    name: 'RuPay',
    lengths: [16],
    patterns: [
      PatternModel(['60']),
      PatternModel(['82']),
    ],
    securityCode: EnumSecurityCode.cvv.securityCode,
  );

  final someMadeUpCardType = CreditCardFlag(
    type: 'mycard',
    name: 'MyCard',
    lengths: [16, 17, 18],
    patterns: [
      PatternModel(['1']),
      PatternModel(['2']),
      PatternModel(['999']),
    ],
    securityCode: EnumSecurityCode.cid4.securityCode,
  );

  final modifiedVisa = CreditCardFlag(
    type: EnumCreditCardFlag.visa.type,
    name: EnumCreditCardFlag.visa.name,
    lengths: [16], // only length 16
    patterns: [
      PatternModel(['3']),
    ],
    securityCode: EnumSecurityCode.cvv.securityCode,
  );

  setUp(() {
    CreditCardFlagDetector.resetCardTypes();
  });

  group('CreditCardTypeDetector.detectCCType: Correct default CC numbers', () {
    final ccNumbersFull = {
      EnumCreditCardFlag.visa: '4647 7200 6779 1032',
      EnumCreditCardFlag.amex: '3799 9661 4347 278',
      EnumCreditCardFlag.discover: '6011 9340 9644 0452',
      EnumCreditCardFlag.mastercard: '5587 1921 6771 2970',
      EnumCreditCardFlag.jcb: '3538 2430 3999 1295',
      EnumCreditCardFlag.unionPay: '6208 2430 3999 1295',
      EnumCreditCardFlag.hipercard: '6062 8288 8866 6688',
      EnumCreditCardFlag.maestro: '4936 9830 3999 1295',
      EnumCreditCardFlag.elo: '6550 2121 9875 8900',
    };

    final ccNumbersPartial = {
      EnumCreditCardFlag.visa: '4647 7200',
      EnumCreditCardFlag.mastercard: '3499',
      EnumCreditCardFlag.discover: '6011 2876 89',
      EnumCreditCardFlag.elo: '6550 2121',
    };

    test('full card numbers', () {
      for (final element in ccNumbersFull.keys) {
        final card = ccNumbersFull[element]!;

        expect(
          CreditCardFlagDetector.detectCCType(card),
          allOf([
            contains(element.creditCardFlag),
          ]),
        );
      }
    });

    test('partial card numbers', () {
      for (final element in ccNumbersPartial.keys) {
        final card = ccNumbersFull[element]!;

        expect(
          CreditCardFlagDetector.detectCCType(card),
          allOf([
            contains(element.creditCardFlag),
          ]),
        );
      }

      expect(
        CreditCardFlagDetector.detectCCType('5287 19'),
        allOf([
          contains(EnumCreditCardFlag.mastercard.creditCardFlag),
        ]),
      );
    });
  });

// Test CC numbers that are not supported
  group('CreditCardTypeDetector.detectCCType: Incorrect default CC numbers',
      () {
    const badCCNumFull1 = '8647 7200 6779 1032';
    const badCCNumFull2 = '3399 9661 4347 2781';
    const badCCNumFull3 = '6111 9340 9644 0452';
    const badCCNumPartial1 = '8647 7200';
    const badCCNumPartial2 = '3399';
    const badCCNumPartial3 = '6111 2878 9';

    test('full card numbers', () {
      expect(CreditCardFlagDetector.detectCCType(badCCNumFull1), isEmpty);
      expect(CreditCardFlagDetector.detectCCType(badCCNumFull2), isEmpty);
      expect(CreditCardFlagDetector.detectCCType(badCCNumFull3), isEmpty);
    });

    test('partial card numbers', () {
      expect(CreditCardFlagDetector.detectCCType(badCCNumPartial1), isEmpty);
      expect(CreditCardFlagDetector.detectCCType(badCCNumPartial2), isEmpty);
      expect(CreditCardFlagDetector.detectCCType(badCCNumPartial3), isEmpty);
    });
  });

  group('CreditCardTypeDetector.detectCCType: Custom CC numbers', () {
    // Rupay type should match as both Rupay and Discover
    const rupayCCNumFull = '6526 1553 1595 4098';
    const rupayCCNumPartial = '6526';
    const myCardCCNumFull = '1234 5678 9123 1';
    const myCardCCNumPartial = '2345 67';

    test('full card numbers', () {
      CreditCardFlagDetector.addCardType('rupay', rupayType);
      CreditCardFlagDetector.addCardType('mycard', someMadeUpCardType);

      expect(
        CreditCardFlagDetector.detectCCType(rupayCCNumFull),
        allOf([
          contains(rupayType),
          containsAllInOrder(
            [rupayType, EnumCreditCardFlag.discover.creditCardFlag],
          ),
        ]),
      );
      expect(
        CreditCardFlagDetector.detectCCType(myCardCCNumFull),
        allOf([
          contains(someMadeUpCardType),
          containsAllInOrder([someMadeUpCardType]),
        ]),
      );
    });

    test('partial card numbers', () {
      CreditCardFlagDetector.addCardType('rupay', rupayType);
      CreditCardFlagDetector.addCardType('mycard', someMadeUpCardType);
      expect(
        CreditCardFlagDetector.detectCCType(rupayCCNumPartial),
        allOf([
          contains(rupayType),
          containsAllInOrder(
            [rupayType, EnumCreditCardFlag.discover.creditCardFlag],
          ),
        ]),
      );
      expect(
        CreditCardFlagDetector.detectCCType(myCardCCNumPartial),
        allOf([
          contains(someMadeUpCardType),
          containsAllInOrder([someMadeUpCardType]),
        ]),
      );
    });
  });

// Test custom CC types
  group('Customizing card types', () {
    group('Custom cards', () {
      test('Add custom card type', () {
        CreditCardFlagDetector.addCardType('rupay', rupayType);
        expect(
          CreditCardFlagDetector.getCardType('rupay'),
          allOf([isNotNull, equals(rupayType)]),
        );
      });

      test('Edit custom card type', () {
        CreditCardFlagDetector.addCardType('rupay', rupayType);
        CreditCardFlagDetector.updateCardType('rupay', modifiedRupay);
        expect(
          CreditCardFlagDetector.getCardType('rupay'),
          allOf([isNotNull, equals(modifiedRupay)]),
        );
      });

      test('Remove custom card type', () {
        CreditCardFlagDetector.addCardType('rupay', rupayType);
        CreditCardFlagDetector.removeCardType('rupay');
        expect(CreditCardFlagDetector.getCardType('rupay'), isNull);
      });
    });
    group('Default cards', () {
      const goodDefaultVisaNumber = '4023 5678 1234 9076';
      const goodModifiedVisaNumber = '3023 5678 1234 9076';
      test('Edit default card type', () {
        CreditCardFlagDetector.updateCardType(
          EnumCreditCardFlag.visa.type,
          modifiedVisa,
        );

        expect(
          CreditCardFlagDetector.getCardType(
            EnumCreditCardFlag.visa.type,
          ),
          allOf([isNotNull, equals(modifiedVisa)]),
        );
      });

      test('Add new card patterns to default card type', () {
        final visaCard = CreditCardFlagDetector.getCardType(
          EnumCreditCardFlag.visa.type,
        )!;
        visaCard.addPattern(PatternModel(['3']));
        expect(
          CreditCardFlagDetector.detectCCType(goodDefaultVisaNumber),
          contains(
            CreditCardFlagDetector.getCardType(
              EnumCreditCardFlag.visa.type,
            ),
          ),
        );
        expect(
          CreditCardFlagDetector.detectCCType(goodModifiedVisaNumber),
          contains(
            CreditCardFlagDetector.getCardType(
              EnumCreditCardFlag.visa.type,
            ),
          ),
        );
      });

      test('Remove default card type', () {
        CreditCardFlagDetector.removeCardType(
          EnumCreditCardFlag.visa.type,
        );
        expect(
          CreditCardFlagDetector.getCardType(
            EnumCreditCardFlag.visa.type,
          ),
          isNull,
        );
      });
    });
  });

// Test empty string and other edge cases
  group('Edge cases', () {
    const emptyStr = '';
    const badStr = '4000 abc';

    test('empty string', () {
      expect(
        CreditCardFlagDetector.detectCCType(emptyStr),
        isEmpty,
      );
    });

    test('string with non-numerical chars', () {
      expect(CreditCardFlagDetector.detectCCType(badStr), isEmpty);
    });

    test('Add existing custom card type throws exception', () {
      CreditCardFlagDetector.addCardType('rupay', rupayType);
      expect(
        () => CreditCardFlagDetector.addCardType('rupay', rupayType),
        throwsException,
      );
      expect(
        CreditCardFlagDetector.getCardType('rupay'),
        allOf([isNotNull, equals(rupayType)]),
      );
    });
  });
}
