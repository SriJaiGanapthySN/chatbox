import 'package:chat/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //go through each user
        final user = doc.data();

        //return user
        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendmessage(String recieverid, message) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    //create new msg
    Message newMessage = Message(
        senderid: currentUserId,
        receiverid: recieverid,
        senderemail: currentEmail,
        message: message,
        timestamp: timestamp);

    List<String> ids = [currentUserId, recieverid];
    ids.sort();
    String chatroomid = ids.join('_');

    await _firestore
        .collection("chat_room")
        .doc(chatroomid)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get message

  Stream<QuerySnapshot> getmessages(String senderis, recieverid) {
    List<String> ids = [senderis, recieverid];
    ids.sort();
    String chatroomid = ids.join('_');
    return _firestore
        .collection("chat_room")
        .doc(chatroomid)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
