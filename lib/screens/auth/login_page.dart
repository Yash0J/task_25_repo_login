// ignore_for_file: avoid_print

import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:task_25_repo_login/data/repositories/user_repository.dart';
import '../../models/login_model.dart';
import '../../utils/constants/colors.dart';
import '../../utils/shared/custom_widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final UserRepository _userRepository = UserRepository();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _usernameError;
  String? _emailError;
  String? _passwordError;

  //[Validator for username.]
  String? validateUsername(username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    return null; // Username is valid
  }

  //[Validator for email.]
  String? validateEmail(email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    // Check if the email contains '@' and '.'
    else if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(email)) {
      return 'Invalid email format';
    }
    return null; // Email is valid
    // eve.holt@reqres.in
  }

  //[Validator for password.]
  String? validatePassword(password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    } else if (password != 'pistol' && // for api's special password is pistol
        // Check if the password contains at least six characters and max sixteen characters including one uppercase letter, one lowercase letter, and one number or special character
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,16}$')
            .hasMatch(password)) {
      return 'Invalid email format';
    }
    return null; // Password is valid
  }

  void login() {
    if (_formKey.currentState?.validate() == true) {
      _userRepository.loginUser(LoginModel(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery.of(context).size.width;
    var mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 18),
                loginImage(mediaHeight),
                const SizedBox(height: 36),
                Custom.text(
                  text: "Login",
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 12),
                Custom.text(
                  text: "Please sign in to continue",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: 38),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      userNameTextField(),
                      emailTextField(),
                      passwordTextField(),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                loginButton(mediaWidth),
                forgotPasswordButton(mediaWidth),
                newAccountSignup(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center loginImage(double mediaHeight) {
    return Center(
      child: SvgPicture.asset(
        'assets/icons/undraw_login.svg',
        height: mediaHeight * 0.18,
      ),
    );
  }

  SizedBox userNameTextField() {
    return SizedBox(
      height: 88,
      child: Column(
        children: [
          Custom.textField(
            validator: (value) {
              setState(() {
                _usernameError = validateUsername(value);
              });
              return null;
            },
            controller: _usernameController,
            cursorColor: AppColors.white,
            prefixIcon: const Icon(Icons.person), // Set the prefix icon
            hintText: 'Enter user name', // Placeholder text
            label: Custom.text(
              text: "User Name",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (_usernameError != null)
            Text(
              _usernameError!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  SizedBox emailTextField() {
    return SizedBox(
      height: 88,
      child: Column(
        children: [
          Custom.textField(
            validator: (value) {
              setState(() {
                _emailError = validateEmail(value);
              });
              return null;
            },
            controller: _emailController,
            cursorColor: AppColors.white,
            prefixIcon: const Icon(Icons.email_outlined), // Set the prefix icon
            hintText: 'Enter your email', // Placeholder text
            label: Custom.text(
              text: "EMAIL",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (_emailError != null)
            Text(
              _emailError!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  SizedBox passwordTextField() {
    return SizedBox(
      height: 88,
      child: Column(
        children: [
          Custom.textField(
            validator: (value) {
              setState(() {
                _passwordError = validatePassword(value);
              });
              return null;
            },
            controller: _passwordController,
            obscureText: true,
            hintText: 'Enter your password', // Placeholder text
            label: Custom.text(
              text: "PASSWORD",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            cursorColor: AppColors.white,
            prefixIcon: const Icon(
              Icons.lock_outlined,
            ), // Set the prefix icon
          ),
          if (_passwordError != null)
            Text(
              _passwordError!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  TextButton loginButton(double mediaWidth) {
    return TextButton(
      onPressed: () => login(),
      style: TextButton.styleFrom(
        backgroundColor: AppColors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(600)),
        minimumSize: Size(mediaWidth / 1.7, 70),
      ),
      child: Custom.text(
        text: "LOGIN",
        textAlign: TextAlign.center,
        fontSize: 20,
        colors: AppColors.darkBlue,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  TextButton forgotPasswordButton(double mediaWidth) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(600)),
        minimumSize: Size(mediaWidth / 9, 0),
        surfaceTintColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: Custom.text(
        text: "Forgot Password?",
        textAlign: TextAlign.center,
        fontSize: 16,
        colors: AppColors.green,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget newAccountSignup() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: "Don't have an account? ",
          style: Custom.style(
            colors: AppColors.white.withOpacity(0.64),
          ),
          children: [
            WidgetSpan(
              child: Custom.text(
                text: "Sign up",
                colors: AppColors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
