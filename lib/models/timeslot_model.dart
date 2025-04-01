class TimeslotModel {
  String? sId;
  String? office;
  String? type;
  String? date;
  String? time;
  int? booked;
  int? total;

  TimeslotModel(
      {this.sId,
      this.office,
      this.type,
      this.date,
      this.time,
      this.booked,
      this.total});

  TimeslotModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    office = json['office'];
    type = json['type'];
    date = json['date'];
    time = json['time'];
    booked = json['booked'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['office'] = office;
    data['type'] = type;
    data['date'] = date;
    data['time'] = time;
    data['booked'] = booked;
    data['total'] = total;
    return data;
  }
}
