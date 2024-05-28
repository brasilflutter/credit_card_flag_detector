import '../credit_card_flag_detector.dart';

class CreditCardFlagDetector {
  static CardCollection _customCards =
      CardCollection.from(EnumCreditCardFlag.values);

  /// Finds non numeric characters
  static final RegExp _nonNumeric = RegExp(r'\D+');

  /// Finds whitespace in any form
  static final RegExp _whiteSpace = RegExp(r'\s+\b|\b\s');

  /// This function determines the potential CC types based on the cardPatterns.
  /// Returns a list of `CreditCardType`s
  /// with the most likely type as the first.
  static List<CreditCardFlag> detectCCType(
    String ccNumStr,
  ) {
    final cardTypes = <CreditCardFlag>[];
    final ccNumStrWithoutSpaces = ccNumStr.replaceAll(_whiteSpace, '');

    if (ccNumStrWithoutSpaces.isEmpty) {
      return cardTypes;
    }

    // Check that only numerics are in the string
    if (_nonNumeric.hasMatch(ccNumStrWithoutSpaces)) {
      return cardTypes;
    }
    for (final element in _customCards.cards.keys) {
      final card = _customCards.cards[element]!;

      for (final pattern in card.patterns) {
        // Remove any spaces
        var ccPatternStr = ccNumStrWithoutSpaces;
        final patternLen = pattern.prefixes[0].length;
        // Trim the CC number str to match the pattern prefix length
        if (patternLen < ccNumStrWithoutSpaces.length) {
          ccPatternStr = ccPatternStr.substring(0, patternLen);
        }

        if (pattern.prefixes.length > 1) {
          // Convert the prefix range into numbers then make sure the
          // CC num is in the pattern range.
          // Because Strings don't have '>=' type operators
          final ccPrefixAsInt = int.parse(ccPatternStr);
          final startPatternPrefixAsInt = int.parse(pattern.prefixes[0]);
          final endPatternPrefixAsInt = int.parse(pattern.prefixes[1]);
          if (ccPrefixAsInt >= startPatternPrefixAsInt &&
              ccPrefixAsInt <= endPatternPrefixAsInt) {
            // Found a match
            card.matchStrength = _determineMatchStrength(
              ccNumStrWithoutSpaces,
              pattern.prefixes[0],
            );
            cardTypes.add(card);
            break;
          }
        } else {
          // Just compare the single pattern prefix with the CC prefix
          if (ccPatternStr == pattern.prefixes[0]) {
            // Found a match
            card.matchStrength = _determineMatchStrength(
              ccNumStrWithoutSpaces,
              pattern.prefixes[0],
            );
            cardTypes.add(card);
            break;
          }
        }
      }
    }

    cardTypes.sort((a, b) => b.matchStrength.compareTo(a.matchStrength));
    return cardTypes;
  }

  static int _determineMatchStrength(String ccNumStr, String patternPrefix) {
    if (ccNumStr.length >= patternPrefix.length) {
      return patternPrefix.length;
    } else {
      return 0;
    }
  }

  /// Gets the `CreditCardType` object associated with the `cardName`
  static CreditCardFlag? getCardType(String cardType) {
    return _customCards.getCardType(cardType);
  }

  static void addPattern(String cardName, List<String> prefixes) =>
      getCardType(cardName)?.addPattern(PatternModel(prefixes));

  /// Resets the card collection to the default card types
  static void resetCardTypes() =>
      _customCards = CardCollection.from(EnumCreditCardFlag.values);

  static void addCardType(String cardName, CreditCardFlag type) {
    _customCards.addCardType(cardName, type);
  }

  /// Updates the card type of the `cardName` in the card collection
  static void updateCardType(String cardType, CreditCardFlag cardFlag) {
    _customCards.updateCardType(cardType, cardFlag);
  }

  /// Removes `cardName` from the card collection
  static void removeCardType(String cardName) {
    final _ = _customCards.removeCard(cardName);
  }
}
