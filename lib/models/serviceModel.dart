class ServiceModel {
  List<ServicesIds> services;

  ServiceModel({this.services});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = new List<ServicesIds>();
      json['services'].forEach((v) {
        services.add(new ServicesIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicesIds {
  int serviceId;

  ServicesIds({this.serviceId});

  ServicesIds.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    return data;
  }
}