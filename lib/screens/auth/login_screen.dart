import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydoc/models/login_model.dart';
import 'package:mydoc/widgets/navbar_roots.dart';
import 'package:mydoc/providers/validators.dart';
import 'package:mydoc/providers/dio_provider.dart';
import 'package:mydoc/screens/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passToggle = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void showHome() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
  }

  Future<void> loginHandler(context) async {
    if (_formKey.currentState!.validate()) {
      LoginModel res = await DioProvider()
          .login(_emailController.text, _passwordController.text);

      if (res.error == 'false') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavBarRoots(),
            ));
      } else {
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 5), () {
              Navigator.of(context).pop(true);
            });
            return Theme(
              data:
                  Theme.of(context).copyWith(dialogBackgroundColor: Colors.red),
              child: AlertDialog(
                title: Text(res.message),
              ),
            );
          },
        );
      }
    }
    // TODO: make the alertbox more modern
    /* if (res.error == 'true') {
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
          });
          return Theme(
            data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.red),
            child: AlertDialog(
              title: Text(res.message),
            ),
          );
        },
      );
    }
*/
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) => validateEmail(value),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) => validatePassword(value),
                      obscureText: passToggle ? true : false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            if (passToggle == true) {
                              passToggle = false;
                            } else {
                              passToggle = true;
                            }
                            setState(() {});
                          },
                          child: passToggle
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
                          onTap: () => loginHandler(context),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 40),
                            child: Center(
                              child: Text(
                                "Login",
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have any account?",
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
                                builder: (context) => const SignUpScreen(),
                              ));
                        },
                        child: const Text(
                          "Create Account",
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
              )),
        ),
      ),
    );
  }
}
