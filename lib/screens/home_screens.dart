import 'package:couple/models/note_model.dart';
import 'package:couple/providers/auth_provider.dart';
import 'package:couple/services/note_service.dart';
import 'package:couple/utils/constant.dart';
import 'package:couple/utils/logger.dart';
import 'package:couple/utils/route/path.dart';
import 'package:couple/widgets/side_menu.dart';
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
  final NoteService noteService = NoteService();
  late final AuthProvider authProvider;
  bool isLoading = false;
  List<NoteModel> noteList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    authProvider = Provider.of(context, listen: false);
    noteList =
        await noteService.getByUserId(authProvider.getProfile!.uid) ?? [];
    noteList = noteList.map((e) => NoteModel.copy(e)).toList();
    logger(message: "Note: ${noteList.first.title}", from: "Home Screen");
    setState(() {
      isLoading = false;
    });
  }

  Widget noteCard(NoteModel note) {
    final String title = note.title ?? "";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RoutePath.noteScreen, arguments: note);
        },
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
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
    final deviceHeight = MediaQuery.of(context).size.height;

    return Consumer<AuthProvider>(builder: (context, profileProvider, child) {
      return Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: ColorConstant.primaryColor,
        drawer: const SideMenu(),
        bottomNavigationBar: BottomAppBar(
          height: Theme.of(context).bottomAppBarTheme.height,
          color: Theme.of(context).bottomAppBarTheme.color,
          child: Row(
            children: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
          ),
        ),
        appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
            elevation: 0),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            shape: Theme.of(context).floatingActionButtonTheme.shape,
            onPressed: () {
              Navigator.pushNamed(context, RoutePath.noteScreen, arguments: "");
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: Stack(
          children: [
            ///background layer
            Padding(
              padding: EdgeInsets.only(top: deviceHeight / 5),
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            Padding(
              padding: screenPadding,
              child: Column(children: [
                Row(children: [
                  Text("Welcome back",
                      style: TextStyle(
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .fontSize!,
                        fontWeight: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .fontWeight!,
                      )),
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
                            .map((e) => noteCard(e.value))
                            .toList()))
              ]),
            ),
          ],
        ),
      );
    });
  }
}
