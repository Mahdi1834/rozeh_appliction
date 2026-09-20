import 'package:rozeh_project/features/feature_niyabat/data/model/list_niyabat_model.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/rozeh_request_model.dart';

class LatestRequestsCustomerModel {
  bool? success;
  String? message;
  Data? data;

  LatestRequestsCustomerModel({this.success, this.message, this.data});

  LatestRequestsCustomerModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];

    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  LatestRequestsCustomerModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) {
    return LatestRequestsCustomerModel(
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

class Data {
  List<RozehRequest>? rozehRequests;
  List<CalendarItem>? niyabatCalendars;

  Data({this.rozehRequests, this.niyabatCalendars});

  Data.fromJson(dynamic json) {
    if (json['rozeh_requests'] != null) {
      rozehRequests = [];

      json['rozeh_requests'].forEach((v) {
        rozehRequests!.add(RozehRequest.fromJson(v));
      });
    }

    if (json['niyabat_calendars'] != null) {
      niyabatCalendars = [];

      json['niyabat_calendars'].forEach((v) {
        niyabatCalendars!.add(CalendarItem.fromJson(v));
      });
    }
  }

  Data copyWith({
    List<RozehRequest>? rozehRequests,
    List<CalendarItem>? niyabatCalendars,
  }) {
    return Data(
      rozehRequests: rozehRequests ?? this.rozehRequests,
      niyabatCalendars: niyabatCalendars ?? this.niyabatCalendars,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (rozehRequests != null) {
      map['rozeh_requests'] = rozehRequests!.map((v) => v.toJson()).toList();
    }

    if (niyabatCalendars != null) {
      map['niyabat_calendars'] =
          niyabatCalendars!.map((v) => v.toJson()).toList();
    }

    return map;
  }
}
