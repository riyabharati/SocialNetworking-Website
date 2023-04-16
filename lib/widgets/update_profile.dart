import 'package:chat_pot/constant/validator.dart';
import 'package:chat_pot/models/auth_response.dart';
import 'package:chat_pot/network_services/api_provider.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  final User? user;
  const UpdateProfile({Key? key, this.user}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final ApiProvider _apiProvider = ApiProvider();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _dob;
  late TextEditingController _gender;
  @override
  void initState() {
    _firstName = TextEditingController(text: widget.user!.firstName);
    _lastName = TextEditingController(text: widget.user!.lastName);
    _dob = TextEditingController(text: widget.user!.dob);
    _gender = TextEditingController(text: widget.user!.gender);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    controller: _firstName,
                    validator: Validator.validateEmpty,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "firstName")),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _lastName,
                    validator: Validator.validateEmpty,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "LastName")),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _dob,
                    validator: Validator.validateEmpty,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "DOB")),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _gender,
                    validator: Validator.validateEmpty,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Gender")),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final response = await _apiProvider.updateProfile(
                                User(
                                        firstName: _firstName.text,
                                        lastName: _lastName.text,
                                        dob: _dob.text,
                                        gender: _gender.text)
                                    .profileMap());
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
