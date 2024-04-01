import 'package:flutter/material.dart';


class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {

  final TextEditingController inputController = TextEditingController();
  final FocusNode inputFocus = FocusNode();
  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return TextFormField(
      autocorrect: false,
      focusNode: inputFocus,
      controller: inputController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6)
        ), 
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6)
        ),
        hintText: 'Search note',
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle
      ),

    );
  }
}