class Company {
  late int id;
  late String name;
  late bool isActive;

  Company({required this.id, required this.name, required this.isActive});

  late List<Company> _companies;
}
