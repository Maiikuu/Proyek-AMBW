import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/data/data_buku.dart';
import '../firebase/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share_plus/share_plus.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({super.key});

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  int userScore = -1;

  @override
  void initState() {
    super.initState();
    getScore();
  }

  Future<void> getScore() async{
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final supabase = Supabase.instance.client;
    final dynamic raw = await supabase
        .from('quiz')
        .select('score')
        .eq('userId', user.uid)
        .eq('app', 'MUSA');

    List<dynamic> rows = [];
    if (raw is List) {
      rows = raw;
    } else if (raw is Map && raw['data'] != null) {
      rows = List<dynamic>.from(raw['data'] as List);
    }

    if (rows.isNotEmpty) {
      num total = 0;
      for (final row in rows) {
        total += ((row as Map)['score'] ?? 0) as num;
      }
      setState(() {
        userScore = total.toInt();
      });
    }
  }

  void handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Keluar"),
        content: const Text("Apakah Anda yakin ingin keluar?"),
        actions: [
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Keluar"),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  void handleShare(BuildContext context) {
    Share.share(
      'Yuk cek aplikasi ini! 📖\nhttps://contoh-link-aplikasi.com',
      subject: 'Bagikan Aplikasi Digital Book',
    );
  }

  Future<void> deleteAccount(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Beneran?'),
        content: const Text('Yakin hapus?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Hapus', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm != true) return;

    final providerId = user.providerData.first.providerId;

    if (providerId == 'password') {
      final passwordController = TextEditingController();
      final password = await showDialog<String>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Verifikasi Password'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Masukkan password'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
            TextButton(onPressed: () => Navigator.pop(context, passwordController.text), child: const Text('Lanjut')),
          ],
        ),
      );

      if (password == null || password.isEmpty) return;

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

    } else if (providerId == 'google.com') {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await user.reauthenticateWithCredential(credential);
    }

    final supabase = Supabase.instance.client;
    await supabase.from('user_account').delete().eq('id', user.uid);
    await user.delete();

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Akun berhasil dihapus")));
    }
  }



  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? "Terjadi kesalahan";
    final email = user?.email ?? "";
    final photoUrl = user?.photoURL;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Pengaturan Akun'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Logout',
            onPressed: () => handleLogout(context),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(URL_backgroundPengaturan),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blueAccent, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
                  backgroundColor: Colors.brown,
                  child: photoUrl == null ? Text(displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
                    style: const TextStyle(fontSize: 36, color: Colors.white),
                  ) : null,
                ),
                const SizedBox(height: 10),
                Text(
                  displayName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  email,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        userScore == -1
                            ? const SizedBox(
                          height: 28,
                          width: 28,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        )
                            : Text(
                          userScore.toString(),
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text('Score'),
                      ],
                    ),
                    Column(
                      children: const [
                        Icon(Icons.star, color: Colors.amber, size: 30),
                        Text('Gold'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => handleShare(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.share),
                      SizedBox(width: 5),
                      Text("Bagikan"),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text('Hapus Akun',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  onPressed: () => deleteAccount(context),
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }
}