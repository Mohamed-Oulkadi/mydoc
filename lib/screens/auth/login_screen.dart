import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydoc/providers/validators.dart';
import 'package:mydoc/providers/utils.dart';
import 'package:mydoc/providers/dio_provider.dart';

import '../../utils/flash_message_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passToggle = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginHandler(context) async {
    if (_formKey.currentState!.validate()) {
      var res = await DioProvider()
          .login(_emailController.text, _passwordController.text);

      if (res['error'] == false) {
        if (res['user']['role'] == 'patient') {
          Navigator.pushNamed(context, '/home',
              arguments: {"patient_id": res['user']['id']});
        } else if (res['user']['role'] == 'doctor') {
          Navigator.pushNamed(context, '/drhome',
              arguments: {"doctor_id": res['user']['id']});
        } else if (res['user']['role'] == 'admin') {
          showScreen(context, '/Admhome');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: CustomSnackBar(
                errorText: "Your Email or password is incorrect"),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildImage(),
                const SizedBox(height: 10),
                _buildEmailField(),
                const SizedBox(height: 10),
                _buildPasswordField(),
                const SizedBox(height: 20),
                _buildLoginButton(),
                const SizedBox(height: 20),
                _buildCreateAccountButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Image.asset("images/doctors.png"),
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        validator: (value) => validateEmail(value),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
          prefixIcon: Icon(Icons.person),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        controller: _passwordController,
        validator: (value) => validatePassword(value),
        obscureText: _passToggle,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Password',
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
            child: Icon(
              _passToggle
                  ? CupertinoIcons.eye_slash_fill
                  : CupertinoIcons.eye_fill,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          color: const Color(0xFF7165D6),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () => loginHandler(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
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
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return Row(
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
          onPressed: () => Navigator.pushNamed(context, "/register"),
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
    );
  }
}
