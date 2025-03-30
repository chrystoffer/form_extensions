import 'package:flutter/material.dart';

extension WidgetValidatorExtension on Widget {
  Widget validator(
    String? Function() builder, {
    bool showError = true,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    EdgeInsetsGeometry padding = const EdgeInsets.only(top: 8.0, left: 8, right: 8),
    TextStyle? style,
  }) {
    return FormField<bool>(
      validator: (_) => builder(),
      autovalidateMode: autovalidateMode,
      builder: (FormFieldState state) {
        return Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            this,
            if (state.hasError && showError)
              Padding(
                padding: padding,
                child: Text(
                  state.errorText ?? '',
                  style: style ??
                      TextStyle(
                        color: Theme.of(state.context).colorScheme.error,
                        fontSize: Theme.of(state.context).textTheme.bodySmall?.fontSize,
                      ),
                ),
              ),
          ],
        );
      },
    );
  }
}
