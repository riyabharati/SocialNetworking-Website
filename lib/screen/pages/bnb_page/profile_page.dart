import 'package:chat_pot/constant/constant.dart';
import 'package:chat_pot/models/auth_response.dart';
import 'package:chat_pot/network_services/api_provider.dart';
import 'package:chat_pot/screen/login_screen.dart';
import 'package:chat_pot/utils/user_pref.dart';
import 'package:chat_pot/widgets/change_password.dart';
import 'package:chat_pot/widgets/update_profile.dart';
import 'package:chat_pot/widgets/user_post.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  final ApiProvider _apiProvider = ApiProvider();
  ShakeDetector? detector;

  @override
  void initState() {
    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        UserPreferences.logoutUser();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false);
        setState(() {});
      },
    );
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    detector!.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.all(2),
                indicator: ShapeDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                unselectedLabelColor: Colors.black87,
                labelColor: Colors.white,
                tabs: const [
                  Tab(
                    text: "Post",
                  ),
                  Tab(
                    text: "Photos",
                  ),
                  Tab(
                    text: "My Network",
                  ),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: const [
                UserPost(),
                Center(child: Text("Photos")),
                Center(child: Text("My Network")),
              ],
            ))
          ],
        ),
        floatingActionButton: SpeedDial(
          elevation: 0,
          icon: Icons.add,
          children: [
            SpeedDialChild(
                child: const Icon(
                  Icons.lock,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (builder) => const ChangePassword()))
                      .then((value) {
                    setState(() {});
                  });
                },
                label: "Change Password"),
          ],
        ));
  }

  Widget profileCard({User? user}) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 15,
                ),
                user == null
                    ? const SizedBox()
                    : Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              imageUrl + user.profilePicture.toString()),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  user!.firstName.toString() + user.lastName.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  user.email.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "Following",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '1',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "Followers",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '1',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "Likes",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '100',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (builder) => UpdateProfile(
                                    user: user,
                                  )))
                          .then((value) {
                        setState(() {});
                      });
                    },
                    icon: const Icon(Icons.edit))),
          )
        ],
      ),
    );
  }
}
