import 'package:flutter/material.dart';
import 'dart:io';
import 'package:contact_buddy/db_helper/database_handler.dart';
import 'package:contact_buddy/screen/home_page.dart';
import 'package:contact_buddy/model/contact.dart';
import 'package:image_picker/image_picker.dart';

class UpdateContactScreen extends StatefulWidget {
  final Contact contact;

  const UpdateContactScreen({Key? key, required this.contact})
      : super(key: key);

  @override
  State<UpdateContactScreen> createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {
  final _formKey = GlobalKey<FormState>();
  late DatabaseHandler handler;
  late TextEditingController nameTextController;
  late TextEditingController contactnoTextController;
  late TextEditingController emailTextController;
  late TextEditingController addressTextController;
  late TextEditingController birthdateTextController;
  late String imagePath;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    nameTextController = TextEditingController(text: widget.contact.name);
    contactnoTextController =
        TextEditingController(text: widget.contact.contactno.toString());
    emailTextController = TextEditingController(text: widget.contact.email);
    birthdateTextController =
        TextEditingController(text: widget.contact.birthdate);
    imagePath = widget.contact.image;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedfile != null) {
      setState(() {
        imagePath = pickedfile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Contact',
          style: TextStyle(
            color: Color(0xFFF5F9FF),
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF000000),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFF5F9FF),
            size: 20,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 44,
                ),
                GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 58,
                    backgroundColor: const Color(0xFFF1EAFF),
                    backgroundImage: imagePath.isNotEmpty
                        ? FileImage(File(imagePath))
                        : null,
                    child: imagePath.isEmpty
                        ? const Icon(
                            Icons.add_a_photo,
                            size: 25,
                            color: Color(0xFF000000),
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                const SizedBox(
                  height: 28,
                ),
                TextFormField(
                  controller: nameTextController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9336B4)),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9336B4)),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: contactnoTextController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9336B4)),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9336B4)),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  validator: (contactNumber) {
                    if (contactNumber == null || contactNumber.isEmpty) {
                      return 'Contact number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: emailTextController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF9336B4)),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF9336B4)),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Email is required';
                      }
                      RegExp emailRegExp = RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                      if (!emailRegExp.hasMatch(email)) {
                        return ' Invalid email format';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: birthdateTextController,
                  decoration: const InputDecoration(
                    labelText: 'Birthdate',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9336B4)),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9336B4)),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  validator: (birthdate) {
                    if (birthdate == null || birthdate.isEmpty) {
                      return 'Birthdate is required';
                    }
                    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(birthdate)) {
                      return 'Invalid date format. Please use YYYY-MM-DD';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 290.0,
                  height: 63.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        handler.initializeDB().whenComplete(() async {
                          Contact updatedContact = Contact(
                            id: widget.contact.id,
                            name: nameTextController.text,
                            contactno: int.parse(contactnoTextController.text),
                            email: emailTextController.text,
                            image: imagePath,
                            birthdate: birthdateTextController.text,
                          );
                          await handler.updateContactDetail(updatedContact);
                          setState(() {});
                        });
                        Navigator.pop(context, true);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF000000),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text(
                      "Update",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
