import 'package:couple/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class QuillTextEditor {
  static QuillSimpleToolbar simpleToolbar(
    QuillController quillController,
  ) {
    return QuillToolbar.simple(
        configurations: QuillSimpleToolbarConfigurations(
            controller: quillController,
            buttonOptions: QuillSimpleToolbarButtonOptions(
                base: QuillToolbarBaseButtonOptions(
                    iconTheme: QuillIconTheme(
                        iconButtonSelectedData: IconButtonData(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                          color: ColorConstant.primaryDarkColor,
                        ),
                        iconButtonUnselectedData: IconButtonData(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                        )))),
            sharedConfigurations: const QuillSharedConfigurations(
              locale: Locale('en'),
            ),
            toolbarSize: 50,
            color: Colors.grey[300],
            showDirection: false,
            showClearFormat: false,
            showHeaderStyle: false,
            showFontSize: false,
            showDividers: false,
            multiRowsDisplay: false,
            showRedo: false,
            showUndo: false,
            showSearchButton: false,
            showColorButton: false,
            showBackgroundColorButton: false,
            showFontFamily: false,
            showStrikeThrough: false,
            showSubscript: false,
            showSuperscript: false));
  }
}
