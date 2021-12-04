class Contact {
  final String name;
  final int? accountNummber;

  // Esse é o contrutor
  Contact(
    this.name,
    this.accountNummber,
  );

  @override
  String toString() {
    return 'Contact{name: $name, accountNumber: $accountNummber';
  }
}
