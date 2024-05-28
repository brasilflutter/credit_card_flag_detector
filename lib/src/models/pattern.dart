/// Represents different patterns a credit card number pattern can have.
/// Mostly encapsulates the possible prefixes that the
/// card number has for a particular brand.
class PatternModel {
  /// A lower and upper bound on a range of values the card number starts with.
  /// i.e. `['51', '55']` represents the range of cards starting
  /// with '51' to those starting with '55'
  final List<String> prefixes;

  PatternModel(this.prefixes);

  void addPrefix(String prefix) {
    prefixes.add(prefix);
  }

  @override
  bool operator ==(Object other) =>
      (other is PatternModel) && (prefixes == other.prefixes);

  @override
  int get hashCode => Object.hashAll(prefixes);
}
