
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mydear_diary/homescreen.dart';
import 'package:mydear_diary/signup_page.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  Future<void> loginUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreeN()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User login successfully")),
      );
      print(UserCredential);
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 89, 70, 113), // Purple
              Color.fromARGB(255, 161, 190, 233), // Blue
              Color.fromARGB(255, 208, 132, 225), // Black
            ],
          ),
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
                    padding: const EdgeInsets.all(14.0),
                    child: Text('PAPERS HAS MORE PATIENCE THAN PEOPLE',
                    style: TextStyle(
                      fontSize: 46,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 36, 217, 0.848)
                    ),),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Welcome dear!!",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        'Login Here',
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 255, 0, 149),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: TextField(
                      controller: emailcontroller,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        icon: Icon(Icons.mail, color: Colors.white),
                        labelText: 'Email ID',
                        hintText: 'name@gmail.com',
                        hintStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 72, 14, 222),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 118, 150, 210),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: TextField(
                      controller: passwordcontroller,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        icon: Icon(Icons.password, color: Colors.white),
                        labelText: 'Password',
                        hintText: '!@#name',
                        hintStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 72, 14, 222),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 118, 150, 210),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                 
                  SizedBox(
                    width: 255,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [const Color.fromARGB(255, 162, 72, 178), const Color.fromARGB(255, 130, 171, 204), const Color.fromARGB(255, 108, 118, 178)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            onTap: () async {
                              await loginUserWithEmailAndPassword();
                              
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage(),));
                        },
                        child: Center(
                          child: Text(
                            'Do not have any account -> Sign-up',
                            style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 16),
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