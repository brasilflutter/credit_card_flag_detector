class SecurityCode {
  final String name;
  final int length;

  SecurityCode(this.name, this.length);

  @override
  bool operator ==(Object other) =>
      (other is SecurityCode) && (name == other.name && length == other.length);

  @override
  int get hashCode => Object.hash(name, length);
}
