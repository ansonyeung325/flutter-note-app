import 'package:couple/models/image_model.dart';
import 'package:couple/models/user_profile_model.dart';
import 'package:couple/providers/auth_provider.dart';
import 'package:couple/services/user_service.dart';
import 'package:couple/utils/logger.dart';
import 'package:couple/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final UserProfileModel profile;
  const ProfileScreen({super.key, required this.profile});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final Loader loader;
  late final UserProfileModel profile;
  final TextEditingController _usernameController = TextEditingController();
  final imagePicker = ImagePicker();
  final userService = UserService();

  // UI value
  double userIconSize = 140;
  int infoContainerFlex = 8;
  Widget labelSpacing = const SizedBox(
    height: 6,
  );

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger(from: "Profile Screen", message: "Called didChangeDepends");
  }

  @override
  void didUpdateWidget(covariant ProfileScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    super.didChangeDependencies();
    logger(
        from: "Profile Screen",
        message: "Called didUpdateWidget, nothing change");
    if (widget.profile != oldWidget.profile) {
      logger(
          from: "Profile Screen",
          message: "Called didUpdateWidget,  profile change");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadData() {
    loader = Loader(context: context);
    profile = widget.profile;
    debugPrint("User profile: ${profile.username}");
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: deviceHeight / infoContainerFlex),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Theme.of(context).primaryColorDark),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: (userIconSize / 2), horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Username",
                              style: Theme.of(context).textTheme.labelLarge),
                        ],
                      ),
                      labelSpacing,
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                fillColor: Theme.of(context)
                                    .inputDecorationTheme
                                    .fillColor,
                                contentPadding: Theme.of(context)
                                    .inputDecorationTheme
                                    .contentPadding,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: (deviceHeight / infoContainerFlex) - (userIconSize / 2),
              left: (deviceWidth / 2) - (userIconSize / 2),
              child: Stack(children: [
                Container(
                    height: userIconSize,
                    width: userIconSize,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        border: Border.all(color: Colors.grey[100]!)),
                    child: CircleAvatar(
                      backgroundImage: authProvider.getProfile?.profileImage !=
                              null
                          ? Image.memory(
                                  authProvider.getProfile!.profileImage!.data!)
                              .image
                          : null,
                    )),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                        onTap: () async {
                          try {
                            XFile? image = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              ImageModel newProfileImage = ImageModel(
                                  name: image.name,
                                  data: await image.readAsBytes());
                              UserProfileModel newProfile =
                                  UserProfileModel.copy(profile);
                              newProfile.profileImage = newProfileImage;
                              loader.show();
                              UserProfileModel? updatedProfile =
                                  await userService.update(newProfile);
                              if (updatedProfile != null) {
                                authProvider.setProfile(updatedProfile);
                              }
                            }
                          } catch (error) {
                            logger(from: "Profile Screen", message: "$error");
                          }
                          loader.dismiss();
                        },
                        child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(Icons.edit))))
              ])),
        ],
      ),
    );
  }
}
