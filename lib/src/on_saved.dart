import 'package:flutter/material.dart';

extension WidgetOnSavedExtension on Widget {
  Widget onSaved(VoidCallback builder) {
    return FormField(
      onSaved: (_) => builder(),
      builder: (FormFieldState state) {
        return this;
      },
    );
  }
}
