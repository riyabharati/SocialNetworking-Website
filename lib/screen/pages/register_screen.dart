import 'dart:io';

import 'package:chat_pot/constant/app_color.dart';
import 'package:chat_pot/constant/validator.dart';
import 'package:chat_pot/network_services/api_provider.dart';
import 'package:chat_pot/screen/home_screen.dart';
import 'package:chat_pot/utils/user_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ApiProvider _apiProvider = ApiProvider();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.creamColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.all(30.0),
                height: 300,
                width: double.infinity,
                child: _image != null
                    ? Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/icons/logo.png',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 270),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      const Center(
                          child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Container(
                          color: const Color(0xfff5f5f5), // final response =

                          child: TextFormField(
                            controller: _firstName,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            validator: Validator.validateEmpty,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'First Name',
                                prefixIcon: Icon(Icons.person_outline),
                                labelStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Container(
                          color: const Color(0xfff5f5f5),
                          child: TextFormField(
                            controller: _lastName,
                            validator: Validator.validateEmpty,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Last Name',
                                prefixIcon: Icon(Icons.person_outline),
                                labelStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Container(
                          color: const Color(0xfff5f5f5),
                          child: TextFormField(
                            validator: Validator.validateEmail,
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
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
                          textInputAction: TextInputAction.next,
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
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Container(
                          color: const Color(0xfff5f5f5),
                          child: TextFormField(
                            validator: Validator.validateEmpty,
                            controller: _dob,
                            keyboardType: TextInputType.datetime,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Dob',
                                prefixIcon: Icon(Icons.cake),
                                labelStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Container(
                          color: const Color(0xfff5f5f5),
                          child: TextFormField(
                            validator: Validator.validateEmpty,
                            controller: _gender,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Gender',
                                prefixIcon: Icon(CupertinoIcons.person_2),
                                labelStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xfff5f5f5),
                                  elevation: 0),
                              onPressed: _openImagePicker,
                              child: const Text(
                                "Choose Image",
                                style: TextStyle(color: Colors.black54),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final response =
                                  await _apiProvider.performRegister(
                                      firstName: _firstName.text,
                                      lastName: _lastName.text,
                                      email: _email.text,
                                      password: _password.text,
                                      dob: _dob.text,
                                      gender: _gender.text,
                                      image: _image!.path);
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
                            'SIGN UP',
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
                      customRichText()
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

  Padding customRichText() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Center(
        child: RichText(
          text: const TextSpan(children: [
            TextSpan(
                text: "Already have an account?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                )),
            TextSpan(
                text: " sign in",
                style: TextStyle(
                  color: Color(0xffff2d55),
                  fontSize: 15,
                ))
          ]),
        ),
      ),
    );
  }
}
