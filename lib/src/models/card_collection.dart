import '../../credit_card_flag_detector.dart';

class CardCollection {
  final Map<String, CreditCardFlag> cards;

  CardCollection(this.cards);
  CardCollection.empty() : cards = {};

  factory CardCollection.from(List<EnumCreditCardFlag> other) {
    final c = CardCollection.empty();

    c.cards.addAll(
      other
          .map(
        (e) => {e.type: e.creditCardFlag},
      )
          .fold<Map<String, CreditCardFlag>>(
        {},
        (previousValue, element) => previousValue..addAll(element),
      ),
    );
    return c;
  }
  void addCardType(String key, CreditCardFlag cardType) {
    if (cards.containsKey(key)) {
      throw Exception(
        'The card "$key" already exists in this collection. '
        'Use `updateCardType()` instead',
      );
    } else {
      cards[key] = cardType;
    }
  }

  CreditCardFlag? getCardType(String cardType) {
    return cards[cardType];
  }

  void updateCardType(String cardType, CreditCardFlag cardFlag) {
    cards[cardType] = cardFlag;
  }

  CreditCardFlag? removeCard(String key) {
    return cards.remove(key);
  }
}
