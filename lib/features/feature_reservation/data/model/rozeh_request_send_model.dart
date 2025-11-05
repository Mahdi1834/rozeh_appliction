class RozehRequestSendModel {
  final int rozehId;
  final int ageGroupId;
  final String gender;
  final String date;
  final List<int> userIds;
  final String? description;
  final String? address;
  final String startTime;
  final String? endTime;

  RozehRequestSendModel({
    required this.rozehId,
    required this.ageGroupId,
    required this.gender,
    required this.date,
    required this.userIds,
    required this.startTime,
    this.description,
    this.address,
    this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'rozeh_id': rozehId,
      'age_group_id': ageGroupId,
      'gender': gender,
      'date': date,
      'user_ids': userIds,
      'description': description,
      'address': address,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
