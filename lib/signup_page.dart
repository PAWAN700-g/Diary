import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mydear_diary/homescreen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  Future<void> createEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreeN()),
        (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User created successfully")),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "An error occurred")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 219, 188, 224),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Text(
                      "PAPER HAS MORE\nPATIENCE THAN\nPEOPLE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 46,
                        fontStyle: FontStyle.italic,

                        color: Color(0xFF475569),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Join My Dear Diary",
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,

                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: Color(0xFF6366F1),
                        ),

                        labelText: "Name",

                        labelStyle: const TextStyle(color: Color(0xFF64748B)),

                        hintText: "Enter your name",

                        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFFCBD5E1),
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFF6366F1),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: emailcontroller,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,

                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Color(0xFF6366F1),
                        ),

                        labelText: "Email ID",

                        labelStyle: const TextStyle(color: Color(0xFF64748B)),

                        hintText: "Enter your Email ID",

                        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFFCBD5E1),
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFF6366F1),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordcontroller,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,

                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Color(0xFF6366F1),
                        ),

                        labelText: "Password",

                        labelStyle: const TextStyle(color: Color(0xFF64748B)),

                        hintText: "Enter your Password",

                        hintStyle: const TextStyle(color: Color(0xFF94A3B8)),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFFCBD5E1),
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFF6366F1),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        await createEmailAndPassword();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(185, 58, 199, 1),
                        foregroundColor: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            'already have an account login...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
