class ProfileModelForSend {
  final String fullName;
  final String? nationalCode;
  final String address;
  final int provinceId;
  final int cityId;

  ProfileModelForSend({
    required this.fullName,
    this.nationalCode,
    required this.address,
    required this.provinceId,
    required this.cityId,
  });
}
