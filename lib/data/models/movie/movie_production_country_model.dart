class ProductionCountry {
  final String iso3166_1;
  final String name;

  ProductionCountry({required this.iso3166_1, required this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ProductionCountry(iso3166_1: '', name: '');
    }

    return ProductionCountry(
      iso3166_1: json['iso_3166_1'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'iso_3166_1': iso3166_1, 'name': name};
  }

  @override
  String toString() => 'ProductionCountry(iso3166_1: $iso3166_1, name: $name)';
}
