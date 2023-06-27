class NotificationModel {
  int? id;
  String? careId;
  String? memoName;
  String? dateTime;
  int? seen;

  NotificationModel({
    this.id,
    this.careId,
    this.memoName,
    this.dateTime,
    this.seen,
  });
  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    careId = json['careId'].toString();
    memoName = json['memoName'].toString();
    dateTime = json['dateTime'];
    seen = json['seen'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['careId'] = careId;
    data['memoName'] = memoName;
    data['dateTime'] = dateTime;
    data['seen'] = seen;
    return data;
  }
}
