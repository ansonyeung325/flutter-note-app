import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:couple/models/note_model.dart';
import 'package:couple/providers/auth_provider.dart';
import 'package:couple/services/note_service.dart';
import 'package:couple/utils/components/general_layout.dart';
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
    authProvider = Provider.of(context, listen: false);
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    noteList = await noteService.getByUserId(authProvider.profile!.uid) ?? [];
    if (noteList.isNotEmpty) {
      noteList = noteList.map((e) => NoteModel.copy(e)).toList();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger(from: "Home Screen", message: "Called didChangeDepends");
  }

  Widget noteCard(NoteModel note) {
    final String title = note.title ?? "";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Dismissible(
        key: ValueKey<String>(note.docId),
        onDismissed: (DismissDirection direction) async {
          logger(
              from: "Home Screen onDismiss",
              message: "DismissDirection: $direction");
          switch (direction) {
            case DismissDirection.endToStart:
              await noteService.delete(note.docId);
              noteList.remove(note);
              loadData();
              break;
            case DismissDirection.startToEnd:
              // TODO: Handle this case.
              break;
            default:
              return;
          }
        },
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RoutePath.noteScreen, arguments: note);
          },
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16)),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Consumer<AuthProvider>(builder: (context, profileProvider, child) {
      return GeneralLayout(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF3F6CE6),
            shape: Theme.of(context).floatingActionButtonTheme.shape,
            onPressed: () async {
              if (authProvider.profile != null) {
                NoteModel newNote = NoteModel(
                    owner: authProvider.userId!,
                    createdAt: Timestamp.fromDate(DateTime.now()),
                    docId: authProvider.userId!);
                await noteService.create(newNote);
                Navigator.pushNamed(context, RoutePath.noteScreen,
                    arguments: newNote);
              }
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        widgetChild: Padding(
          padding: screenPadding,
          child: Column(children: [
            Row(children: [
              Text("Note",
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headlineLarge!.fontSize!,
                    fontWeight:
                        Theme.of(context).textTheme.headlineLarge!.fontWeight!,
                  )),
            ]),
            const SizedBox(
              height: 12,
            ),
            const SearchInput(),
            const SizedBox(
              height: 20,
            ),
            noteList.isNotEmpty
                ? Expanded(
                    child: RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 1));
                      logger(message: "Pulling");
                    },
                    child: ListView(
                        scrollDirection: Axis.vertical,
                        children: noteList
                            .asMap()
                            .entries
                            .map((e) => noteCard(e.value))
                            .toList()),
                  ))
                : Container()
          ]),
        ),
      );
    });
  }
}
