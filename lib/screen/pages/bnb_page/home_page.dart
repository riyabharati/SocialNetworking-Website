import 'package:chat_pot/constant/constant.dart';
import 'package:chat_pot/models/post_response.dart';
import 'package:chat_pot/network_services/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiProvider _apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _apiProvider.fetchPost(),
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
                          return defaultCard(
                            post: myPost.myPost![index],
                          );
                        });
              }
          }
        });
  }

  Widget defaultCard({
    MyPost? post,
  }) {
    return Card(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      imageUrl + post!.user!.profilePicture.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: 200,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(post.user!.firstName.toString() +
                        " " +
                        post.user!.lastName.toString()),
                    subtitle: const Text("2 hrs"),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              post.message.toString(),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 250,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imageUrl + post.photos![0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Icon(
                          CupertinoIcons.heart,
                          size: 30,
                        )),
                    TextButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.send_outlined,
                          size: 30,
                        )),
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () {},
                    child: const Text("Follow"))
              ],
            ),
          ),
          Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ExpansionTile(
                title: const Text("comment"),
                children: [
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextFormField(
                          style: const TextStyle(fontSize: 12),
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormFieldDecoration("Write a comment",
                              imageUrl + post.user!.profilePicture.toString())),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
