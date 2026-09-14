class CustomerAddressModelForSend {
  final String? title;
  final String? address;
  final String? postalCode;
  final int? provinceId;
  final int? cityId;
  final double? latitude;
  final double? longitude;
  final bool? isDefault;

  CustomerAddressModelForSend({
    this.title,
    this.address,
    this.postalCode,
    this.provinceId,
    this.cityId,
    this.latitude,
    this.longitude,
    this.isDefault,
  });

  Map<String, dynamic> toJson() {
    return {
      if (title != null && title!.trim().isNotEmpty)
        'title': title,

      if (address != null && address!.trim().isNotEmpty)
        'address': address,

      if (postalCode != null && postalCode!.trim().isNotEmpty)
        'postal_code': postalCode,

      if (provinceId != null)
        'province_id': provinceId,

      if (cityId != null)
        'city_id': cityId,

      if (latitude != null)
        'latitude': latitude,

      if (longitude != null)
        'longitude': longitude,

      if (isDefault != null)
        'is_default': isDefault,
    };
  }
}