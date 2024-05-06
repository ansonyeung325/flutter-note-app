import 'dart:async';
import 'package:couple/models/note_model.dart';
import 'package:couple/utils/components/quill_text_editor.dart';
import 'package:couple/utils/constant.dart';
import 'package:couple/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_quill/flutter_quill.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({required this.note, super.key});

  final NoteModel? note;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final EdgeInsetsGeometry screenPadding =
      const EdgeInsets.symmetric(horizontal: 12);
  late StreamSubscription<String> titleSubscription;
  StreamController<String> streamTitleController = StreamController<String>();
  final TextEditingController _titleController = TextEditingController();
  final QuillController _quillController = QuillController.basic();
  final FocusNode _quillFocusNode = FocusNode();
  NoteModel? oldNote;
  NoteModel? newNote;
  String title = "New Note";
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    loadData();
    // autoSaveContent();
  }

  @override
  void dispose() {
    super.dispose();
    _quillController.dispose();
    _titleController.dispose();
    titleSubscription.cancel();
  }

  void loadData() {
    titleSubscription = streamTitleController.stream.listen(
      (String value) {
        title = value;
        setState(() {});
      },
    );

    if (widget.note != null) {
      oldNote = widget.note!;
      title = oldNote!.title!;
      _titleController.text = title;
      _quillController.document.insert(0, oldNote!.content.toString());
    }
    logger(
        from: "Note Screen line 62",
        message:
            "Widget is not null ${oldNote?.title} content: ${oldNote?.content}");
  }

  // void autoSaveContent() {
  //   _quillController.document.changes.listen((event) async {
  //     await Future.delayed(const Duration(seconds: 3));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          leading: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                highlightColor: Colors.transparent,
              )
            ],
          ),
          actions: [
            KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
              if (isKeyboardVisible) {
                return TextButton(
                    onPressed: () {
                      ///UnFocus QuillEditor
                      FocusManager.instance.primaryFocus?.unfocus();

                      ///Save content
                    },
                    child: Text("Finish",
                        style: TextStyle(
                            color: ColorConstant.primaryColor, fontSize: 16)));
              } else {
                return PopupMenuButton(
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              onTap: () {
                                logger(
                                    from: "Note Screen",
                                    message:
                                        "${_quillController.document.toDelta().toJson()}");
                              },
                              child: Text("Save",
                                  style: Theme.of(context).textTheme.bodyLarge))
                        ]);
              }
            }),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                onChanged: (String value) {
                  streamTitleController.add(value);
                },
                style: Theme.of(context).textTheme.headlineMedium,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    errorBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    disabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(),
              ),
              Expanded(
                child: Padding(
                  padding: screenPadding,
                  child: QuillEditor.basic(
                    focusNode: _quillFocusNode,
                    configurations: QuillEditorConfigurations(
                      controller: _quillController,
                      sharedConfigurations: const QuillSharedConfigurations(
                        locale: Locale('en', 'zh'),
                      ),
                    ),
                  ),
                ),
              ),
              KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
                if (isKeyboardVisible) {
                  return Container(
                      child: QuillTextEditor.simpleToolbar(_quillController));
                }
                return const SizedBox();
              }),
            ],
          ),
        ));
  }
}
