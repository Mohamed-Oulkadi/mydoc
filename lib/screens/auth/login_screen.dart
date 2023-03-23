import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydoc/providers/validators.dart';
import 'package:mydoc/providers/dio_provider.dart';

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

  void showHome(context) {
    Navigator.pushNamed(context, '/home');
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passToggle = !_passToggle;
    });
  }

  Future<void> loginHandler(context) async {
    if (_formKey.currentState!.validate()) {
      var res = await DioProvider()
          .login(_emailController.text, _passwordController.text);

      if (res['error'] == false) {
        showHome(context);
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
        obscureText: !_passToggle,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Password',
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: InkWell(
            onTap: _togglePasswordVisibility,
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
