import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mydoc/screens/auth/login_screen.dart';
import 'package:mydoc/providers/validators.dart';
import 'package:mydoc/providers/dio_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passToggle = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();
    super.dispose();
  }

  void showLogin() {
    Navigator.pushNamed(context, '/login');
  }

  Future<void> registerHandler() async {
    final res = await DioProvider().registerUser(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _password2Controller.text);

    if (res.error == 'false') {
      showLogin();
    }

    // TODO: check TODO in login_screen.dart
    /*if (res['error'].isNotEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.of(context).pop(true);
        });
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.red),
          child: AlertDialog(
            title: Text(res['error']),
          ),
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.of(context).pop(true);
        });
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.green),
          child: AlertDialog(
            title: Text(res['message']),  
          ),
        );
      },
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset("images/doctors.png"),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) => validateFullName(value),
                      decoration: const InputDecoration(
                        labelText: "Full Name",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) => validateEmail(value),
                      decoration: const InputDecoration(
                        labelText: "Email Address",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: TextFormField(
                      controller: _phoneController,
                      validator: (value) => validatePhoneNumber(value),
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) => validatePassword(value),
                      obscureText: _passToggle ? true : false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text("Password"),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            if (_passToggle == true) {
                              _passToggle = false;
                            } else {
                              _passToggle = true;
                            }
                            setState(() {});
                          },
                          child: _passToggle
                              ? const Icon(CupertinoIcons.eye_slash_fill)
                              : const Icon(CupertinoIcons.eye_fill),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      controller: _password2Controller,
                      validator: (value) => validatePassword(value),
                      obscureText: _passToggle ? true : false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text("Password"),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            if (_passToggle == true) {
                              _passToggle = false;
                            } else {
                              _passToggle = true;
                            }
                            setState(() {});
                          },
                          child: _passToggle
                              ? const Icon(CupertinoIcons.eye_slash_fill)
                              : const Icon(CupertinoIcons.eye_fill),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Material(
                        color: const Color(0xFF7165D6),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              registerHandler();
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 40),
                            child: Center(
                              child: Text(
                                "Create Account",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an Account?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7165D6),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
