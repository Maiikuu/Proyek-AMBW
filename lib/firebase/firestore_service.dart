import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Contoh fungsi untuk menambah data
  Future<void> addUser(String userId, String name, String email) async {
    try {
      await _db.collection('users').doc(userId).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('User added successfully');
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  // Contoh fungsi untuk mengambil data
  Future<Map<String, dynamic>?> getUser(String userId) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(userId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        print('User not found');
        return null;
      }
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Contoh fungsi untuk update data
  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(userId).update(data);
      print('User updated successfully');
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  // Contoh fungsi untuk delete data
  Future<void> deleteUser(String userId) async {
    try {
      await _db.collection('users').doc(userId).delete();
      print('User deleted successfully');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}