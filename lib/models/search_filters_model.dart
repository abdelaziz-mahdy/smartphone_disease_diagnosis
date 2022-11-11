class FiltersModel {
  final String specialty;
  final String city;
  final int priceLow;
  final int? priceHigh;
  final int yearsOfExperience;
  final int rating;

  FiltersModel({
    this.specialty = 'all',
    this.city = 'any',
    this.priceLow = 0,
    this.priceHigh,
    this.yearsOfExperience = 0,
    this.rating = 0,
  });
}
