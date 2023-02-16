import 'package:flutter/material.dart';
import 'package:share_cost_app/routes.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  @override
  Widget build(BuildContext context) {

    void onSubmitSignup() {
      //TODO: Implement signup functionality
    }

    void navigateToLoginView() {
      Navigator.pushReplacementNamed(context, Routes.login);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Sign up to App')),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          shrinkWrap: true,
          children: [
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Email'),
            ),
            const SizedBox(height: 20.0),
            const TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
            ),
            const SizedBox(height: 20.0),
            const TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Confirm password'),
            ),
            const SizedBox(height: 100.0),
            ElevatedButton(
                onPressed: onSubmitSignup, child: const Text('Sign up')),
            const SizedBox(height: 10.0),
            TextButton(
                onPressed: navigateToLoginView,
                child: const Text('Already have an account? Log in'))
          ],
        ),
      ),
    );
  }
}
