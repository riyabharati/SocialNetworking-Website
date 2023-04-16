import 'dart:io';

import 'package:chat_pot/constant/constant.dart';
import 'package:chat_pot/constant/validator.dart';
import 'package:chat_pot/models/auth_response.dart';
import 'package:chat_pot/network_services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _message = TextEditingController();
  final ApiProvider _apiProvider = ApiProvider();
  final _formKey = GlobalKey<FormState>();
  List<XFile>? _image = [];
  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final List<XFile>? pickedImage = await _picker.pickMultiImage();
    if (pickedImage != null) {
      _image!.addAll(pickedImage);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: Card(
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: _apiProvider.loginUser(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          final AuthResponse loginUser =
                              snapshot.data as AuthResponse;

                          return profileCard(user: loginUser.user);
                        }
                    }
                  }),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                ),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _message,
                    validator: Validator.validateEmpty,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        hintText: "What's on your mind?",
                        border: InputBorder.none),
                  ),
                ),
              ),
              _image!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                          itemCount: _image!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(_image![index].path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  : const SizedBox(),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0, primary: Colors.grey),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                          leading: const Icon(Icons.photo),
                                          title: const Text('Photo'),
                                          onTap: _openImagePicker),
                                      ListTile(
                                        leading:
                                            const Icon(Icons.emoji_emotions),
                                        title: const Text('Feeling/Activity'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.videocam),
                                        title: const Text('Video'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.share),
                                        title: const Text('Share'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Text("Select Photos")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 0),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final response = await _apiProvider.createPost(
                                  message: _message.text.trim(),
                                  images: _image);
                              if (response.success == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Success")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("failed")));
                              }
                            }
                          },
                          child: const Text("Post"))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget profileCard({User? user}) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage:
            NetworkImage(imageUrl + user!.profilePicture.toString()),
      ),
      title: Text(user.firstName.toString() + " " + user.lastName.toString()),
      subtitle: const Text("public"),
    );
  }
}
