import 'dart:io';

import 'package:data_kontak/model/kontak.dart';
import 'package:data_kontak/controller/KontakController.dart';
import 'package:data_kontak/screen/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormKontak extends StatefulWidget {
  const FormKontak({super.key});

  @override
  State<FormKontak> createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  File? _image;
  final _imagePicker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _emailController = TextEditingController();
  final _noTeleponController = TextEditingController();

  Future<void> getImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text('Input Data Kontak'))),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Nama", hintText: "Masukkan nama"),
                    controller: _namaController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Email", hintText: "Masukkan email"),
                    controller: _emailController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Alamat", hintText: "Masukkan alamat"),
                    controller: _alamatController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "No Telepon",
                        hintText: "Masukkan No Telepon"),
                    controller: _noTeleponController,
                  ),
                ),
                _image == null
                    ? Text('Tidak ada gambar yang dipilih.')
                    : Image.file(_image!),
                ElevatedButton(
                    onPressed: getImage, child: const Text('Pilih Gambar')),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Kontak _person = Kontak(
                          nama: _namaController.text,
                          email: _emailController.text,
                          alamat: _alamatController.text,
                          noTelepon: _noTeleponController.text,
                          foto: _image!.path,
                        );
                        var result = await KontakController().addPerson(
                          _person,
                          _image,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result['message'])),
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeView()),
                          (route) => false,
                        );
                      }
                    },
                    child: const Text("Simpan"),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
