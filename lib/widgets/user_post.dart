import 'package:chat_pot/constant/constant.dart';
import 'package:chat_pot/models/post_response.dart';
import 'package:chat_pot/network_services/api_provider.dart';
import 'package:chat_pot/widgets/edit_profile.dart';
import 'package:flutter/material.dart';

class UserPost extends StatefulWidget {
  const UserPost({Key? key}) : super(key: key);

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  final ApiProvider _apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: FutureBuilder(
          future: _apiProvider.userPost(),
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
                  final MyPostResponse myPost = snapshot.data as MyPostResponse;
                  return myPost.myPost!.isEmpty
                      ? const Center(
                          child: Text("Empty"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: myPost.myPost!.length,
                          itemBuilder: (context, index) {
                            var post = myPost.myPost![index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (builder) => EditPost(
                                              id: post.id,
                                              message: post.message,
                                            )))
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              child: Card(
                                elevation: 0,
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: SizedBox(
                                              height: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10)),
                                                child: Image.network(
                                                  imageUrl + post.photos![0],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )),
                                            Expanded(
                                                flex: 2,
                                                child: SizedBox(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(post
                                                                .user!.firstName
                                                                .toString() +
                                                            " " +
                                                            post.user!.lastName
                                                                .toString()),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          post.message
                                                              .toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: const Text(
                                                  "Are you sure you want to delete? ",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text("Cancel")),
                                                  TextButton(
                                                      onPressed: () async {
                                                        final response =
                                                            await _apiProvider
                                                                .deletePost(
                                                                    id: post
                                                                        .id);
                                                        if (response.success ==
                                                            true) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          "Success")));
                                                          setState(() {});
                                                          Navigator.of(context)
                                                              .pop();
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          "Failed")));
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      },
                                                      child: const Text("Ok")),
                                                ],
                                              );
                                            });
                                      },
                                      child: const Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                }
            }
          }),
    );
  }
}
