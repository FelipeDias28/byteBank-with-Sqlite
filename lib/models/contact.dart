class Contact {
  final id;
  final String name;
  final int? accountNummber;

  // Esse é o contrutor
  Contact(
    this.id,
    this.name,
    this.accountNummber,
  );

  @override
  String toString() {
    return 'Contact{name: $name, accountNumber: $accountNummber';
  }
}
