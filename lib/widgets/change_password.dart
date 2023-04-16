import 'package:chat_pot/constant/validator.dart';
import 'package:chat_pot/models/auth_response.dart';
import 'package:chat_pot/network_services/api_provider.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final ApiProvider _apiProvider = ApiProvider();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    controller: _newPassword,
                    validator: Validator.validatePassword,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "New password")),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    validator: (value) {
                      if (_newPassword.text != value) {
                        return "did't matched";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Confirm password")),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final response = await _apiProvider.changePassword(
                                User(password: _newPassword.text)
                                    .passwordMap());
                            if (response.success == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Success")));
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("failed")));
                            }
                          }
                        },
                        child: const Text("Update")))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
