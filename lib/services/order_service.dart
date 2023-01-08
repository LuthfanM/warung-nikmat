import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class OrderService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addOrder({
    required int quantity,
    required double totalPayment,
    required String status,
    required List products,
    required Map user,
  }) async {
    String id = const Uuid().v4();
    try {
      firestore.collection('orders').doc(id).set({
        'id': id,
        'quantity': quantity,
        'total_payment': totalPayment,
        'status': status,
        'products': products,
        'user': user,
        'created_at': DateTime.now().toString(),
        'updated_at': DateTime.now().toString(),
      }, SetOptions(merge: true)).then(
          (value) => print('Data berhasil disimpan'));
    } catch (e) {
      throw Exception('Data gagal disimpan, silahkan dicoba lagi');
    }
  }

  Future<void> markAsDone(String id) async {
    try {
      firestore.collection('orders').doc(id).set({
        'status': "Selesai",
        'updated_at': DateTime.now().toString(),
      }, SetOptions(merge: true)).then(
          (value) => print('Data berhasil disimpan'));
    } catch (e) {
      throw Exception('Data gagal disimpan, silahkan dicoba lagi');
    }
  }
}
