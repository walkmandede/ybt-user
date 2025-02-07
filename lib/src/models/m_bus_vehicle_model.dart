import 'package:equatable/equatable.dart';
import 'package:ybt_user/config/constants/app_functions.dart';

class BusVehicleModel extends Equatable {
  final BusLineDetail busLineDetail;
  final String busLineId;
  final DriverDetail driverDetail;
  final String driverId;
  final String id;
  final String lastLocationUpdatedAt;
  final String location;
  final String regNo;
  final String serviceStatus;

  const BusVehicleModel({
    required this.busLineDetail,
    required this.busLineId,
    required this.driverDetail,
    required this.driverId,
    required this.id,
    required this.lastLocationUpdatedAt,
    required this.location,
    required this.regNo,
    required this.serviceStatus,
  });

  factory BusVehicleModel.fromJson({required Map<String, dynamic> json}) {
    superPrint(json);
    return BusVehicleModel(
      busLineDetail: BusLineDetail.fromJson(json['busLineDetail']),
      busLineId: json['busLineId'],
      driverDetail: DriverDetail.fromJson(json['driverDetail']),
      driverId: json['driverId'],
      id: json['id'],
      lastLocationUpdatedAt: json['lastLocationUpdatedAt'].toString(),
      location: json['location'],
      regNo: json['regNo'],
      serviceStatus: json['serviceStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'busLineDetail': busLineDetail.toJson(),
      'busLineId': busLineId,
      'driverDetail': driverDetail.toJson(),
      'driverId': driverId,
      'id': id,
      'lastLocationUpdatedAt': lastLocationUpdatedAt,
      'location': location,
      'regNo': regNo,
      'serviceStatus': serviceStatus,
    };
  }

  @override
  List<Object?> get props => [
        busLineDetail,
        busLineId,
        driverDetail,
        driverId,
        id,
        lastLocationUpdatedAt,
        location,
        regNo,
        serviceStatus,
      ];
}

class BusLineDetail extends Equatable {
  final List<String> busStopIds;
  final String id;
  final String name;

  const BusLineDetail({
    required this.busStopIds,
    required this.id,
    required this.name,
  });

  factory BusLineDetail.fromJson(Map<String, dynamic> json) {
    return BusLineDetail(
      busStopIds: List<String>.from(json['busStopIds']),
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'busStopIds': busStopIds,
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [busStopIds, id, name];
}

class DriverDetail extends Equatable {
  final String id;
  final String name;
  final String phone;

  const DriverDetail({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory DriverDetail.fromJson(Map<String, dynamic> json) {
    return DriverDetail(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }

  @override
  List<Object?> get props => [id, name, phone];
}
