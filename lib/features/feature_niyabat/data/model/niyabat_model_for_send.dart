class NiyabatModelForSend {
  final int intentionId;
  final int tavaslatId;
  final String title;
  final String? description;

  NiyabatModelForSend({
    required this.intentionId,
    required this.tavaslatId,
    required this.title,
    this.description,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'intention_id': intentionId,
      'tavaslat_id': tavaslatId,
      'title': title,
    };

    if (description != null && description!.trim().isNotEmpty) {
      data['description'] = description!.trim();
    }

    return data;
  }
}