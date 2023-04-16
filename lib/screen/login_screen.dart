import 'package:chat_pot/constant/app_color.dart';
import 'package:chat_pot/constant/validator.dart';
import 'package:chat_pot/models/auth_response.dart';
import 'package:chat_pot/network_services/api_provider.dart';
import 'package:chat_pot/screen/home_screen.dart';
import 'package:chat_pot/screen/pages/register_screen.dart';
import 'package:chat_pot/utils/user_pref.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ApiProvider _apiProvider = ApiProvider();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late LongPressGestureRecognizer _longPressGestureRecognizer;

  @override
  void initState() {
    _longPressGestureRecognizer = LongPressGestureRecognizer()
      ..onLongPress = _handlePress;
    super.initState();
  }

  void _handlePress() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.creamColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            chatPotImage(),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 270),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 23, right: 23, top: 10),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      const Center(
                          child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Container(
                          color: const Color(0xfff5f5f5),
                          child: TextFormField(
                            validator: Validator.validateEmail,
                            controller: _email,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                                labelStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ),
                      Container(
                        color: const Color(0xfff5f5f5),
                        child: TextFormField(
                          validator: Validator.validatePassword,
                          controller: _password,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline),
                              labelStyle: TextStyle(fontSize: 15)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final response = await _apiProvider.performLogin(
                                  User(
                                          email: _email.text,
                                          password: _password.text)
                                      .toMap());
                              if (response.success == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Success")));
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const HomeScreen()),
                                    (route) => false);
                                UserPreferences.setToken(response.token);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Failed")));
                              }
                            }
                          }, //since this is only a UI app
                          child: const Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: const Color(0xffff2d55),
                          elevation: 0,
                          minWidth: 400,
                          height: 50,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Center(
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Center(
                          child: RichText(
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: "Don't have an account?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  )),
                              TextSpan(
                                  text: " sign up",
                                  recognizer: _longPressGestureRecognizer,
                                  style: const TextStyle(
                                    color: Color(0xffff2d55),
                                    fontSize: 15,
                                  ))
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  chatPotImage() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(30.0),
        height: 300,
        width: double.infinity,
        child: Image.asset(
          'assets/icons/logo.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
