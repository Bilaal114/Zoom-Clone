import 'package:flutter/material.dart';
import 'package:zoom_clone1/resources/auth_methods.dart';
import 'package:zoom_clone1/utils/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethos _authMethos = AuthMethos();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Start or Join a meetings",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 38),
            child: Image(image: AssetImage("Assets/onboarding.jpg")),
          ),
          CustomButton(
              text: "Google SignIn",
              onpressed: () async {
                bool res = await _authMethos.signInWithGoogle(context);
                if (res) {
                  Navigator.pushReplacementNamed(context, "/Home");
                }
              }),
        ],
      ),
    );
  }
}
