import 'package:flutter/material.dart';
import 'package:project/firebase/firestore_service.dart';

class TestFirestorePage extends StatefulWidget {
  const TestFirestorePage({super.key});

  @override
  State<TestFirestorePage> createState() => _TestFirestorePageState();
}

class _TestFirestorePageState extends State<TestFirestorePage> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  Future<void> _addUser() async {
    final userId = _userIdController.text.trim();
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (userId.isEmpty || name.isEmpty || email.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Semua field harus diisi')),
        );
      }
      return;
    }

    try {
      await _firestoreService.addUser(userId, name, email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil ditambahkan')),
        );
      }
      // Clear fields
      _userIdController.clear();
      _nameController.clear();
      _emailController.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Firestore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(labelText: 'User ID'),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addUser,
              child: const Text('Add User to Firestore'),
            ),
          ],
        ),
      ),
    );
  }
}