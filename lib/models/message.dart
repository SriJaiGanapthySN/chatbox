import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderemail;
  final String senderid;
  final String receiverid;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderid,
    required this.receiverid,
    required this.senderemail,
    required this.message,
    required this.timestamp,
  });

  //convert to map
  Map<String, dynamic> toMap() {
    return {
      'senderid': senderid,
      'receiverid': receiverid,
      'senderemail': senderemail,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
