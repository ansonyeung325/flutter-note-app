import 'package:couple/models/note_model.dart';
import 'package:couple/providers/app_provider.dart';
import 'package:couple/providers/auth_provider.dart';
import 'package:couple/utils/components/general_layout.dart';
import 'package:couple/utils/route/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/search_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final EdgeInsetsGeometry screenPadding =
      const EdgeInsets.symmetric(horizontal: 12);

  final List<NoteModel> noteList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {}

  Widget noteCard(int index) {
    final String title = noteList[index].title;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routePath.noteScreen,
              arguments: title);
        },
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(6)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              Row(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Divider(
                  height: 1.0,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, profileProvider, child) {
      return GeneralLayout(
        floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () {
              Navigator.pushNamed(context, routePath.noteScreen,arguments: "");
            },
            child: Icon(Icons.create_rounded)),
        widgetChild: Padding(
          padding: screenPadding,
          child: Column(children: [
            Row(children: [
              Text("Welcome back",
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineLarge!.fontSize!,
                      fontWeight: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .fontWeight!,
                      color: Theme.of(context).primaryColor)),
            ]),
            const SizedBox(
              height: 12,
            ),
            const SearchInput(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    children: noteList
                        .asMap()
                        .entries
                        .map((item) => noteCard(item.key))
                        .toList()))
          ]),
        ),
      );
    });
  }
}
