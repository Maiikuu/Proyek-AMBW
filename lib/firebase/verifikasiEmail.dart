import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/data_buku.dart';
import 'login.dart';

class VerifikasiEmailPage extends StatefulWidget {
  const VerifikasiEmailPage({super.key});

  @override
  State<VerifikasiEmailPage> createState() => _VerifikasiEmailPageState();
}

class _VerifikasiEmailPageState extends State<VerifikasiEmailPage> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.emailVerified) {
      timer.cancel();

      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('pending_username_${user.email}') ?? '';
      final gender = prefs.getString('pending_gender_${user.email}') ?? '';

      await user.updateDisplayName(username);

      // upsert user data into Supabase `user_account` table
      try {
        final supabase = Supabase.instance.client;
        await supabase.from('user_account').upsert({
          'id': user.uid,
          'username': username,
          'gender': gender,
          'email': user.email,
        }, onConflict: 'id');
      } catch (e) {
        // swallow errors but you may want to handle them in production
      }

      await prefs.remove('pending_username_${user.email}');
      await prefs.remove('pending_gender_${user.email}');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verifikasi Berhasil!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(URL_backgroundLogin),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "MUSA",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Silakan cek email Anda dan klik link verifikasi.\nJika tidak ada, periksa folder spam/junk.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.currentUser?.sendEmailVerification();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Email verifikasi dikirim ulang')),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Gagal kirim ulang: ${e.toString()}')),
                          );
                        }
                      }
                    },
                    child: const Text('Kirim Ulang Email Verifikasi'),
                  ),
                  const SizedBox(height: 24),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
