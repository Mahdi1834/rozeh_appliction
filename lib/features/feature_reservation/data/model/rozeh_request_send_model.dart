class RozehRequestSendModel {
  final int rozehId;
  final int ageGroupId;
  final String gender;
  final int addressId;
  final String date;
  final List<int> userIds;
  final String startTime;
  final String endTime;
  final String? description;

  RozehRequestSendModel({
    required this.rozehId,
    required this.ageGroupId,
    required this.gender,
    required this.addressId,
    required this.date,
    required this.userIds,
    required this.startTime,
    required this.endTime,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'rozeh_id': rozehId,
      'age_group_id': ageGroupId,
      'gender': gender,
      'address_id': addressId,
      'date': date,
      'user_ids': userIds,
      'start_time': startTime,
      'end_time': endTime,
      'description': description,
    };
  }
}