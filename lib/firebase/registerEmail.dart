import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/data/data_buku.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login.dart';
import 'verifikasiEmail.dart';

class RegisterEmailPage extends StatefulWidget {
  const RegisterEmailPage({super.key});
  @override
  State<RegisterEmailPage> createState() => _RegisterEmailPageState();
}


class _RegisterEmailPageState extends State<RegisterEmailPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  String selectedGender = 'Laki-laki';



  Future<void> registerWithEmailPassword() async {

    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final gender = selectedGender;

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username tidak boleh kosong')),
      );
      return;
    }

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email tidak boleh kosong')),
      );
      return;
    }

    // Validasi format email
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Format email tidak valid')),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password tidak boleh kosong')),
      );
      return;
    }

    if (password.length<8 || password.length>16) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password harus antara 8-16 karakter')),
      );
      return;
    }

    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    try {
      await userCredential.user?.sendEmailVerification();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengirim email verifikasi: ${e.toString()}')),
        );
      }
      // Hapus user jika gagal kirim email
      await userCredential.user?.delete();
      return;
    }

    // store pending data locally for the verification step
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pending_username_${userCredential.user?.email}', username);
    await prefs.setString('pending_gender_${userCredential.user?.email}', gender);

    // insert initial user row into Supabase (can be updated after email verification)
    try {
      final supabase = Supabase.instance.client;
      final uid = userCredential.user?.uid;
      if (uid != null) {
        await supabase.from('user_account').insert({
          'id': uid,
          'username': username,
          'email': email,
          'gender': gender,
          'created_at': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      // ignore Supabase errors here; verification step will still try to write
    }

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => VerifikasiEmailPage(),
        ),
      );
    }
  }

  Future<void> login() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar:  AppBar(
        leading: BackButton(
          style: ButtonStyle(
            iconSize: WidgetStateProperty.all(35),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(URL_backgroundLogin),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "MUSA",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButton<String>(
                  value: selectedGender,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: <String>['Laki-laki', 'Perempuan']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: registerWithEmailPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text("Register"),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(50),
                ),
                label: const Text("Sudah punya akun? Login!"),
                onPressed: login,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Dengan mendaftar, Anda sudah menyetujui',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse('https://www.alkitab.or.id/tentang-kami/syarat-ketentuan'));
                  },
                  child: const Text(
                    'Syarat dan Ketentuan',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Text(' serta ', style: TextStyle(fontSize: 12)),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse('https://www.alkitab.or.id/tentang-kami/kebijakan-privasi'));
                  },
                  child: const Text(
                    'Kebijakan Privasi',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}