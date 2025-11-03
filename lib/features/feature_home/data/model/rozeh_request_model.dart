// ---------------- Root ----------------
class RozehRequestModel {
  RozehRequestModel({this.success, this.message, this.data});

  bool? success;
  String? message;
  RozehRequestsContainer? data;

  RozehRequestModel.copy(RozehRequestModel other)
    : success = other.success,
      message = other.message,
      data = other.data;

  RozehRequestModel copyWith({
    bool? success,
    String? message,
    RozehRequestsContainer? data,
  }) => RozehRequestModel(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  RozehRequestModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    data =
        json['data'] != null
            ? RozehRequestsContainer.fromJson(
              json['data'] as Map<String, dynamic>,
            )
            : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) map['data'] = data!.toJson();
    return map;
  }
}

// --------------- Container (data.rozeh_requests) ---------------
class RozehRequestsContainer {
  RozehRequestsContainer({this.rozehRequests});

  RozehRequestsPage? rozehRequests;

  RozehRequestsContainer copyWith({RozehRequestsPage? rozehRequests}) =>
      RozehRequestsContainer(
        rozehRequests: rozehRequests ?? this.rozehRequests,
      );

  RozehRequestsContainer.fromJson(Map<String, dynamic> json) {
    rozehRequests =
        json['rozeh_requests'] != null
            ? RozehRequestsPage.fromJson(
              json['rozeh_requests'] as Map<String, dynamic>,
            )
            : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (rozehRequests != null) {
      map['rozeh_requests'] = rozehRequests!.toJson();
    }
    return map;
  }
}

// --------------- Pagination Page ---------------
class RozehRequestsPage {
  RozehRequestsPage({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<RozehRequest>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<PageLink>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  RozehRequestsPage copyWith({
    int? currentPage,
    List<RozehRequest>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<PageLink>? links,
    String? nextPageUrl,
    String? path,
    int? perPage,
    String? prevPageUrl,
    int? to,
    int? total,
  }) => RozehRequestsPage(
    currentPage: currentPage ?? this.currentPage,
    data: data ?? this.data,
    firstPageUrl: firstPageUrl ?? this.firstPageUrl,
    from: from ?? this.from,
    lastPage: lastPage ?? this.lastPage,
    lastPageUrl: lastPageUrl ?? this.lastPageUrl,
    links: links ?? this.links,
    nextPageUrl: nextPageUrl ?? this.nextPageUrl,
    path: path ?? this.path,
    perPage: perPage ?? this.perPage,
    prevPageUrl: prevPageUrl ?? this.prevPageUrl,
    to: to ?? this.to,
    total: total ?? this.total,
  );

  RozehRequestsPage.fromJson(Map<String, dynamic> json) {
    currentPage = (json['current_page'] as num?)?.toInt();
    if (json['data'] != null) {
      data =
          (json['data'] as List)
              .map((v) => RozehRequest.fromJson(v as Map<String, dynamic>))
              .toList();
    }
    firstPageUrl = json['first_page_url'] as String?;
    from = (json['from'] as num?)?.toInt();
    lastPage = (json['last_page'] as num?)?.toInt();
    lastPageUrl = json['last_page_url'] as String?;
    if (json['links'] != null) {
      links =
          (json['links'] as List)
              .map((v) => PageLink.fromJson(v as Map<String, dynamic>))
              .toList();
    }
    nextPageUrl = json['next_page_url'] as String?;
    path = json['path'] as String?;
    perPage = (json['per_page'] as num?)?.toInt();
    prevPageUrl = json['prev_page_url'] as String?;
    to = (json['to'] as num?)?.toInt();
    total = (json['total'] as num?)?.toInt();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    if (links != null) {
      map['links'] = links!.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }
}

// --------------- Pagination Link ---------------
class PageLink {
  PageLink({this.url, this.label, this.page, this.active});

  String? url; // null or URL
  String? label; // e.g. « قبلی
  int? page; // null or number
  bool? active;

  PageLink copyWith({String? url, String? label, int? page, bool? active}) =>
      PageLink(
        url: url ?? this.url,
        label: label ?? this.label,
        page: page ?? this.page,
        active: active ?? this.active,
      );

  PageLink.fromJson(Map<String, dynamic> json) {
    url = json['url'] as String?;
    label = json['label'] as String?;
    page = (json['page'] as num?)?.toInt();
    active = json['active'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['label'] = label;
    map['page'] = page;
    map['active'] = active;
    return map;
  }
}

// --------------- Rozeh Request Item ---------------
class RozehRequest {
  RozehRequest({
    this.id,
    this.customerId,
    this.rozehId,
    this.ageGroupId,
    this.gender,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.users,
    this.maddahs,
    this.speakers,
    this.ageGroup,
    this.rozeh,
  });

  int? id;
  int? customerId;
  int? rozehId;
  int? ageGroupId;
  String? gender; // "family", "man", ...
  String? description;
  String? date; // "YYYY-MM-DD"
  String? startTime; // "HH:mm:ss"
  String? endTime; // "HH:mm:ss"
  String? createdAt;
  String? updatedAt;
  String? deletedAt; // null or ISO string
  List<RozehUser>? users;
  List<RozehUser>? maddahs; // NEW
  List<RozehUser>? speakers; // NEW
  AgeGroup? ageGroup;
  Rozeh? rozeh;

  RozehRequest copyWith({
    int? id,
    int? customerId,
    int? rozehId,
    int? ageGroupId,
    String? gender,
    String? description,
    String? date,
    String? startTime,
    String? endTime,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    List<RozehUser>? users,
    List<RozehUser>? maddahs,
    List<RozehUser>? speakers,
    AgeGroup? ageGroup,
    Rozeh? rozeh,
  }) => RozehRequest(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    rozehId: rozehId ?? this.rozehId,
    ageGroupId: ageGroupId ?? this.ageGroupId,
    gender: gender ?? this.gender,
    description: description ?? this.description,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt ?? this.deletedAt,
    users: users ?? this.users,
    maddahs: maddahs ?? this.maddahs,
    speakers: speakers ?? this.speakers,
    ageGroup: ageGroup ?? this.ageGroup,
    rozeh: rozeh ?? this.rozeh,
  );

  RozehRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] as num?)?.toInt();
    customerId = (json['customer_id'] as num?)?.toInt();
    rozehId = (json['rozeh_id'] as num?)?.toInt();
    ageGroupId = (json['age_group_id'] as num?)?.toInt();
    gender = json['gender'] as String?;
    description = json['description'] as String?;
    date = json['date'] as String?;
    startTime = json['start_time'] as String?;
    endTime = json['end_time'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    deletedAt = json['deleted_at'] as String?;

    if (json['users'] != null) {
      users =
          (json['users'] as List)
              .map((v) => RozehUser.fromJson(v as Map<String, dynamic>))
              .toList();
    }
    if (json['maddahs'] != null) {
      maddahs =
          (json['maddahs'] as List)
              .map((v) => RozehUser.fromJson(v as Map<String, dynamic>))
              .toList();
    }
    if (json['speakers'] != null) {
      speakers =
          (json['speakers'] as List)
              .map((v) => RozehUser.fromJson(v as Map<String, dynamic>))
              .toList();
    }

    ageGroup =
        json['age_group'] != null
            ? AgeGroup.fromJson(json['age_group'] as Map<String, dynamic>)
            : null;
    rozeh =
        json['rozeh'] != null
            ? Rozeh.fromJson(json['rozeh'] as Map<String, dynamic>)
            : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customer_id'] = customerId;
    map['rozeh_id'] = rozehId;
    map['age_group_id'] = ageGroupId;
    map['gender'] = gender;
    map['description'] = description;
    map['date'] = date;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;

    if (users != null) map['users'] = users!.map((v) => v.toJson()).toList();
    if (maddahs != null)
      map['maddahs'] = maddahs!.map((v) => v.toJson()).toList();
    if (speakers != null)
      map['speakers'] = speakers!.map((v) => v.toJson()).toList();

    if (ageGroup != null) map['age_group'] = ageGroup!.toJson();
    if (rozeh != null) map['rozeh'] = rozeh!.toJson();
    return map;
  }
}

// --------------- User on a Request ---------------
class RozehUser {
  RozehUser({
    this.id,
    this.fullName,
    this.nationalCode,
    this.email,
    this.emailVerifiedAt,
    this.mobile,
    this.mobileVerifiedAt,
    this.telephone,
    this.address,
    this.isSetProfile,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });

  int? id;
  String? fullName;
  String? nationalCode;
  String? email;
  String? emailVerifiedAt;
  String? mobile;
  String? mobileVerifiedAt;
  String? telephone;
  String? address;
  int? isSetProfile;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Pivot? pivot;

  RozehUser copyWith({
    int? id,
    String? fullName,
    String? nationalCode,
    String? email,
    String? emailVerifiedAt,
    String? mobile,
    String? mobileVerifiedAt,
    String? telephone,
    String? address,
    int? isSetProfile,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    Pivot? pivot,
  }) => RozehUser(
    id: id ?? this.id,
    fullName: fullName ?? this.fullName,
    nationalCode: nationalCode ?? this.nationalCode,
    email: email ?? this.email,
    emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
    mobile: mobile ?? this.mobile,
    mobileVerifiedAt: mobileVerifiedAt ?? this.mobileVerifiedAt,
    telephone: telephone ?? this.telephone,
    address: address ?? this.address,
    isSetProfile: isSetProfile ?? this.isSetProfile,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt ?? this.deletedAt,
    pivot: pivot ?? this.pivot,
  );

  RozehUser.fromJson(Map<String, dynamic> json) {
    id = (json['id'] as num?)?.toInt();
    fullName = json['full_name'] as String?;
    nationalCode = json['national_code'] as String?;
    email = json['email'] as String?;
    emailVerifiedAt = json['email_verified_at'] as String?;
    mobile = json['mobile'] as String?;
    mobileVerifiedAt = json['mobile_verified_at'] as String?;
    telephone = json['telephone'] as String?;
    address = json['address'] as String?;
    isSetProfile = (json['isSetProfile'] as num?)?.toInt();
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    deletedAt = json['deleted_at'] as String?;
    pivot =
        json['pivot'] != null
            ? Pivot.fromJson(json['pivot'] as Map<String, dynamic>)
            : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = fullName;
    map['national_code'] = nationalCode;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['mobile'] = mobile;
    map['mobile_verified_at'] = mobileVerifiedAt;
    map['telephone'] = telephone;
    map['address'] = address;
    map['isSetProfile'] = isSetProfile;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    if (pivot != null) map['pivot'] = pivot!.toJson();
    return map;
  }
}

// --------------- Pivot ---------------
class Pivot {
  Pivot({
    this.rozehRequestId,
    this.userId,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  int? rozehRequestId;
  int? userId;
  int? id;
  String? createdAt;
  String? updatedAt;

  Pivot copyWith({
    int? rozehRequestId,
    int? userId,
    int? id,
    String? createdAt,
    String? updatedAt,
  }) => Pivot(
    rozehRequestId: rozehRequestId ?? this.rozehRequestId,
    userId: userId ?? this.userId,
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  Pivot.fromJson(Map<String, dynamic> json) {
    rozehRequestId = (json['rozeh_request_id'] as num?)?.toInt();
    userId = (json['user_id'] as num?)?.toInt();
    id = (json['id'] as num?)?.toInt();
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rozeh_request_id'] = rozehRequestId;
    map['user_id'] = userId;
    map['id'] = id;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

// --------------- AgeGroup & Rozeh ---------------
class AgeGroup {
  AgeGroup({this.id, this.title, this.createdAt, this.updatedAt});

  int? id;
  String? title;
  String? createdAt;
  String? updatedAt;

  AgeGroup copyWith({
    int? id,
    String? title,
    String? createdAt,
    String? updatedAt,
  }) => AgeGroup(
    id: id ?? this.id,
    title: title ?? this.title,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  AgeGroup.fromJson(Map<String, dynamic> json) {
    id = (json['id'] as num?)?.toInt();
    title = json['title'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class Rozeh {
  Rozeh({this.id, this.title, this.createdAt, this.updatedAt});

  int? id;
  String? title;
  String? createdAt;
  String? updatedAt;

  Rozeh copyWith({
    int? id,
    String? title,
    String? createdAt,
    String? updatedAt,
  }) => Rozeh(
    id: id ?? this.id,
    title: title ?? this.title,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  Rozeh.fromJson(Map<String, dynamic> json) {
    id = (json['id'] as num?)?.toInt();
    title = json['title'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
