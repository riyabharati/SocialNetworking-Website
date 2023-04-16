import 'package:chat_pot/constant/app_color.dart';
import 'package:chat_pot/models/success_response.dart';
import 'package:chat_pot/network_services/api_provider.dart';
import 'package:flutter/material.dart';

class EditPost extends StatefulWidget {
  final String? id;
  final String? message;
  const EditPost({Key? key, this.message, this.id}) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final ApiProvider _apiProvider = ApiProvider();
  late TextEditingController _message;
  @override
  void initState() {
    _message = TextEditingController(text: widget.message);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Edit Post"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: _message,
                style: const TextStyle(fontSize: 12),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIconConstraints:
                        const BoxConstraints(minHeight: 40, minWidth: 40),
                    prefixIcon: const Icon(Icons.message),
                    hintStyle: const TextStyle(fontSize: 12),
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    fillColor: AppColor.backgroundColor),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final response = await _apiProvider.editPost(
                        id: widget.id,
                        jsonBody:
                            SuccessResponse(message: _message.text).toMap());
                    if (response.success == true) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("failed")));
                    }
                  },
                  child: const Text("Edit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
