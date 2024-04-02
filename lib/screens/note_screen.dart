import 'dart:async';
import 'dart:convert';
import 'package:couple/models/note_model.dart';
import 'package:couple/utils/string_converter.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({required this.content, super.key});

  final String? content;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final EdgeInsetsGeometry screenPadding =
      const EdgeInsets.symmetric(horizontal: 12);
  final StreamController<String> _inputStreamController =
      StreamController<String>();
  TextEditingController contentController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  String? oldContent;
  String? newContent;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    contentController.dispose();
  }

  void loadData() {
    if (widget.content != null) {
      oldContent = widget.content!;
      contentController.text = oldContent!;
    }
    autoSaveChange();
  }

  Future<void> autoSaveChange() async {
    Stream stream = _inputStreamController.stream;
    stream.listen((event) async {
      await Future.delayed(const Duration(seconds: 5));

      String encoded = StringConverter.encodeContent(event);
      debugPrint(encoded);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottomNavigationBar: Container(
            height: 100,
            padding: screenPadding,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.checklist),
                  highlightColor: Colors.transparent,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.create),
                  highlightColor: Colors.transparent,
                ),
              ],
            )),
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
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
                highlightColor: Colors.transparent,
              )
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
              highlightColor: Colors.transparent,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: screenPadding,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    maxLines: 1,
                    textCapitalization: TextCapitalization.sentences,
                    style: Theme.of(context).textTheme.titleLarge,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.all(8.0),
                        filled: true,
                        fillColor: Colors.grey[300]),
                    onChanged: (value) {
                      _inputStreamController.add(value);
                    },
                  ),
                  TextFormField(
                    controller: contentController,
                    maxLines: 999999999,
                    minLines: null,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 8.0)),
                    onChanged: (value) {
                      _inputStreamController.add(value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
