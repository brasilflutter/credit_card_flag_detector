
import 'package:flutter/foundation.dart';

import 'pattern.dart';
import 'security_code.dart';

/// Represents the credit card type and general information
/// about a particular brand of card, including the patterns and
/// usual security code used with that brand.
class CreditCardFlag {
  final String type;
  final String name;
  final List<int> lengths;
  final List<PatternModel> _patterns;

  Set<PatternModel> get patterns => _patterns.toSet();
  SecurityCode securityCode;
  int matchStrength = 0;

  CreditCardFlag({
    required this.type,
    required this.name,
    required this.lengths,
    required List<PatternModel> patterns,
    required this.securityCode,
  }) : _patterns = patterns;

  /// Add a new pattern to a card type
  void addPattern(PatternModel pattern) {
    _patterns.add(pattern);
  }

  /// Change the security code information about
  void updateSecurityCode(SecurityCode securityCode) {
    this.securityCode = securityCode;
  }

  @override
  bool operator ==(Object other) =>
      (other is CreditCardFlag) &&
      (type == other.type &&
          name == other.name &&
          lengths == other.lengths &&
          setEquals(patterns, other.patterns) &&
          securityCode == other.securityCode);

  @override
  int get hashCode => Object.hash(type, name, lengths, patterns, securityCode);
}
