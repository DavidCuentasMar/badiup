import 'package:badiup/models/address_model.dart';
import 'package:badiup/models/user_setting_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class Customer extends User {
  final Address shippingAddress;

  Customer({
    String name,
    RoleType role,
    DocumentReference setting,
    DateTime created,
    this.shippingAddress
  }) : super(name: name, role: role, setting: setting, created: created);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> userMap = super.toMap();
    userMap.addAll({
      'shippingAddress': shippingAddress
    });
    return userMap;
  }

  Customer.fromMap(Map<String, dynamic> map)
    : shippingAddress = map['shippingAddress'],
    super.fromMap(map);
  
  Customer.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data);
}