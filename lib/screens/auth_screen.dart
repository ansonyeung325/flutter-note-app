import 'package:couple/models/user_profile_model.dart';
import 'package:couple/providers/auth_provider.dart';
import 'package:couple/services/auth_services.dart';
import 'package:couple/utils/components/message_toast.dart';
import 'package:couple/utils/route/path.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:couple/utils/error_handler/auth_error.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  //UI variable
  bool passwordVisible = false;
  bool isLogin = true;
  Widget textFieldSpacing = const SizedBox(
    height: 12,
  );
  Widget labelSpacing = const SizedBox(
    height: 6,
  );

  @override
  void initState() {
    emailController.text = "hiuyat0325@gmail.com";
    passwordController.text = "anson0325";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserProfileModel? profile = await AuthServices().signUp(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            username: usernameController.text.trim());
        if (context.mounted && profile != null) {
          Provider.of<AuthProvider>(context, listen: false).setProfile(profile);
          Navigator.pushNamed(context, AppRouteName.homeScreen);
        }
        AMessageToast.showToast(msg: "SignUp successfully");
      } on FirebaseAuthException catch (e) {
        debugPrint("${e.code}: ${AuthError.getError(e.code)}");
        AMessageToast.showToast(msg: AuthError.getError(e.code));
      }
    }
  }

  Future<UserProfileModel?> signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserProfileModel? profile = await AuthServices().signIn(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        if (context.mounted && profile != null) {
          Provider.of<AuthProvider>(context, listen: false).setProfile(profile);
          Navigator.pushNamed(context, AppRouteName.homeScreen);
        }
        AMessageToast.showToast(msg: "SignIn successfully");
        return profile;
      } on FirebaseAuthException catch (e) {
        debugPrint("${e.code}: ${AuthError.getError(e.code)}");
        AMessageToast.showToast(msg: AuthError.getError(e.code));
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, profileProvider, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                  height: 200,
                  child: isLogin
                      ? Lottie.asset('assets/lottieFile/welcome_gif.json',
                          repeat: false)
                      : Lottie.asset(
                          'assets/lottieFile/greeting_gif.json',
                        )),
              Text(
                isLogin ? "Welcome back!" : "Together!",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        if (!isLogin)
                          Row(
                            children: [
                              Text(
                                "Your name",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                        if (!isLogin) labelSpacing,
                        if (!isLogin)
                          TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                                fillColor: Theme.of(context)
                                    .inputDecorationTheme
                                    .fillColor,
                                contentPadding: Theme.of(context)
                                    .inputDecorationTheme
                                    .contentPadding,
                                suffixIcon: const Icon(Icons.person_outline),
                                hintText: "I am Guy"),
                          ),
                        if (!isLogin) textFieldSpacing,
                        Row(
                          children: [
                            Text("Email address",
                                style: Theme.of(context).textTheme.labelLarge)
                          ],
                        ),
                        labelSpacing,
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              contentPadding: Theme.of(context)
                                  .inputDecorationTheme
                                  .contentPadding,
                              suffixIcon: const Icon(Icons.email_outlined)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            } else {
                              if (EmailValidator.validate(value)) {
                                return null;
                              } else {
                                return "Please provide a valid email";
                              }
                            }
                          },
                        ),
                        textFieldSpacing,
                        Row(
                          children: [
                            Text("Password",
                                style: Theme.of(context).textTheme.labelLarge)
                          ],
                        ),
                        labelSpacing,
                        TextFormField(
                          controller: passwordController,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              contentPadding: Theme.of(context)
                                  .inputDecorationTheme
                                  .contentPadding,
                              suffixIcon: IconButton(
                                icon: passwordVisible
                                    ? const Icon(Icons.visibility_outlined)
                                    : const Icon(Icons.visibility_off_outlined),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              )),
                          enableSuggestions: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                        ),
                        const Expanded(child: SizedBox()),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () async {
                                      if (isLogin) {
                                        signIn();
                                      } else {
                                        signUp();
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(isLogin ? "Login" : "Get Start"),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        const Icon(Icons.arrow_forward_outlined)
                                      ],
                                    ))),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              const Expanded(child: Divider()),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: Text(
                                  "or",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                              const Expanded(child: Divider())
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(CommunityMaterialIcons.google),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: IconButton(
                                onPressed: () {},
                                icon:
                                    const Icon(CommunityMaterialIcons.facebook),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(CommunityMaterialIcons.apple),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                isLogin
                                    ? "Do not have an account?"
                                    : "Already have an account?",
                                style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLogin = !isLogin;
                                });
                              },
                              child: Text(
                                isLogin ? "SignUp" : "SignIn",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        Theme.of(context).primaryColor),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      );
    });
  }
}
