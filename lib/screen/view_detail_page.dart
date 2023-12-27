import 'package:flutter/material.dart';
import 'package:contact_buddy/screen/home_page.dart';
import 'package:contact_buddy/model/contact.dart';
import 'dart:io';

class ViewContactScreen extends StatefulWidget {
  final Contact contact;

  const ViewContactScreen({Key? key, required this.contact}) : super(key: key);

  @override
  State<ViewContactScreen> createState() => _ViewContactScreenState();
}

class _ViewContactScreenState extends State<ViewContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Contacts',
          style: TextStyle(
            color: Color(0xFFF5F9FF),
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF000000),
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Color(0xFFF5F9FF), size: 20),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 60,
                child: ClipOval(
                  child: SizedBox(
                    width: 120.0,
                    height: 120.0,
                    child: widget.contact.image.isNotEmpty
                        ? Image.file(File(widget.contact.image),
                            fit: BoxFit.cover)
                        : Image.asset('assets/images/profilelogo.png',
                            fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Card(
                color: const Color(0xFF708090),
                margin: const EdgeInsets.only(bottom: 25.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'Name:  ${widget.contact.name}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Card(
                color: const Color(0xFF708090),
                margin: const EdgeInsets.only(bottom: 25.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'Contact Number:  ${widget.contact.contactno}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Card(
                color: const Color(0xFF708090),
                margin: const EdgeInsets.only(bottom: 25.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'Email:  ${widget.contact.email}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Card(
                color: const Color(0xFF708090),
                margin: const EdgeInsets.only(bottom: 25.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'Birthdate:  ${widget.contact.birthdate}',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
