import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image; // Variabel untuk menyimpan gambar profil
  String _name = 'Nama Pengguna'; // Nama pengguna
  String _email = 'email@example.com'; // Email pengguna

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Menyimpan gambar yang dipilih
      });
    }
  }

  void _editProfile() {
    // Menampilkan dialog untuk mengedit profil
    final TextEditingController nameController =
        TextEditingController(text: _name);
    final TextEditingController emailController =
        TextEditingController(text: _email);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Pengguna'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _name = nameController.text; // Simpan nama baru
                  _email = emailController.text; // Simpan email baru
                });
                Navigator.of(context).pop(); // Tutup dialog
                _showProfileUpdatedDialog(
                    context); // Tampilkan dialog konfirmasi
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Menempatkan profil di bagian atas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Nama dan Email di sebelah kiri
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _name, // Menampilkan nama pengguna
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      _email, // Menampilkan email pengguna
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                // Foto Profil di sebelah kanan
                GestureDetector(
                  onTap: _pickImage, // Memanggil fungsi untuk memilih gambar
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(Icons.camera_alt,
                            size: 50, color: Colors.white)
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Garis pembatas
            const Divider(thickness: 2),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _editProfile, // Tambahkan tombol untuk mengedit profil
              child: const Text('Edit Profil'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      // Aksi untuk Settings
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.group),
                    title: const Text('Group'),
                    onTap: () {
                      // Aksi untuk Group
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Friend'),
                    onTap: () {
                      // Aksi untuk Friend
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('About'),
                    onTap: () {
                      // Aksi untuk About
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Exit'),
                    onTap: () {
                      // Aksi untuk Exit
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileUpdatedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profil Diperbarui'),
          content: const Text('Perubahan profil Anda telah disimpan.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
