class ListNiyabatModel {
  ListNiyabatModel({this.success, this.message, this.data});

  ListNiyabatModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];

    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  ListNiyabatModel copyWith({bool? success, String? message, Data? data}) {
    return ListNiyabatModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['success'] = success;
    map['message'] = message;

    if (data != null) {
      map['data'] = data!.toJson();
    }

    return map;
  }
}

// ============================================================
// Data
// ============================================================

class Data {
  Data({this.calendars});

  Data.fromJson(dynamic json) {
    calendars =
        json['calendars'] != null
            ? Calendars.fromJson(json['calendars'])
            : null;
  }

  Calendars? calendars;

  Data copyWith({Calendars? calendars}) {
    return Data(calendars: calendars ?? this.calendars);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (calendars != null) {
      map['calendars'] = calendars!.toJson();
    }

    return map;
  }
}

// ============================================================
// Calendars Pagination
// ============================================================

class Calendars {
  Calendars({
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

  Calendars.fromJson(dynamic json) {
    currentPage = json['current_page'];

    if (json['data'] != null) {
      data = [];

      json['data'].forEach((v) {
        data!.add(CalendarItem.fromJson(v));
      });
    }

    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];

    if (json['links'] != null) {
      links = [];

      json['links'].forEach((v) {
        links!.add(PaginationLink.fromJson(v));
      });
    }

    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  num? currentPage;
  List<CalendarItem>? data;
  String? firstPageUrl;
  num? from;
  num? lastPage;
  String? lastPageUrl;
  List<PaginationLink>? links;
  String? nextPageUrl;
  String? path;
  num? perPage;
  String? prevPageUrl;
  num? to;
  num? total;

  Calendars copyWith({
    num? currentPage,
    List<CalendarItem>? data,
    String? firstPageUrl,
    num? from,
    num? lastPage,
    String? lastPageUrl,
    List<PaginationLink>? links,
    String? nextPageUrl,
    String? path,
    num? perPage,
    String? prevPageUrl,
    num? to,
    num? total,
  }) {
    return Calendars(
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

// ============================================================
// Calendar Item
// ============================================================

class CalendarItem {
  CalendarItem({
    this.id,
    this.customerId,
    this.addressId,
    this.intentionId,
    this.tavaslatId,
    this.title,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.intention,
    this.tavaslat,
  });

  CalendarItem.fromJson(dynamic json) {
    id = json['id'];
    customerId = json['customer_id'];
    addressId = json['address_id'];
    intentionId = json['intention_id'];
    tavaslatId = json['tavaslat_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];

    intention =
        json['intention'] != null
            ? Intention.fromJson(json['intention'])
            : null;

    tavaslat =
        json['tavaslat'] != null ? Tavaslat.fromJson(json['tavaslat']) : null;
  }

  num? id;
  num? customerId;
  dynamic addressId;
  num? intentionId;
  num? tavaslatId;

  String? title;
  String? description;

  dynamic date;
  dynamic startTime;
  dynamic endTime;

  num? status;

  String? createdAt;
  String? updatedAt;

  dynamic deletedAt;

  Intention? intention;
  Tavaslat? tavaslat;

  CalendarItem copyWith({
    num? id,
    num? customerId,
    dynamic addressId,
    num? intentionId,
    num? tavaslatId,
    String? title,
    String? description,
    dynamic date,
    dynamic startTime,
    dynamic endTime,
    num? status,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    Intention? intention,
    Tavaslat? tavaslat,
  }) {
    return CalendarItem(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      addressId: addressId ?? this.addressId,
      intentionId: intentionId ?? this.intentionId,
      tavaslatId: tavaslatId ?? this.tavaslatId,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      intention: intention ?? this.intention,
      tavaslat: tavaslat ?? this.tavaslat,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['customer_id'] = customerId;
    map['address_id'] = addressId;
    map['intention_id'] = intentionId;
    map['tavaslat_id'] = tavaslatId;
    map['title'] = title;
    map['description'] = description;
    map['date'] = date;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;

    if (intention != null) {
      map['intention'] = intention!.toJson();
    }

    if (tavaslat != null) {
      map['tavaslat'] = tavaslat!.toJson();
    }

    return map;
  }
}

// ============================================================
// Pagination Link
// ============================================================

class PaginationLink {
  PaginationLink({this.url, this.label, this.page, this.active});

  PaginationLink.fromJson(dynamic json) {
    url = json['url'];
    label = json['label'];
    page = json['page'];
    active = json['active'];
  }

  String? url;
  String? label;
  num? page;
  bool? active;

  PaginationLink copyWith({
    String? url,
    String? label,
    num? page,
    bool? active,
  }) {
    return PaginationLink(
      url: url ?? this.url,
      label: label ?? this.label,
      page: page ?? this.page,
      active: active ?? this.active,
    );
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

// ============================================================
// Tavaslat
// ============================================================

class Tavaslat {
  Tavaslat({
    this.id,
    this.title,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Tavaslat.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  num? id;
  String? title;
  dynamic description;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Tavaslat copyWith({
    num? id,
    String? title,
    dynamic description,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) {
    return Tavaslat(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;

    return map;
  }
}

// ============================================================
// Intention
// ============================================================

class Intention {
  Intention({
    this.id,
    this.title,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Intention.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  num? id;
  String? title;
  dynamic description;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Intention copyWith({
    num? id,
    String? title,
    dynamic description,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) {
    return Intention(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;

    return map;
  }
}
