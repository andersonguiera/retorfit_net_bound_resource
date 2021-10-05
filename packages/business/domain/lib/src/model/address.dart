class _Geo {

  const _Geo(this.lat, this.lng);

  final String lat;
  final String lng;
}

class Address {

  const Address(this.street, this.suite, this.city, this.zipCode, this.geo);

  final String street;
  final String suite;
  final String city;
  final String zipCode;
  final _Geo geo;
}