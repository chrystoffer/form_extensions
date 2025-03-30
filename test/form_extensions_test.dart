import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_extensions/form_extensions.dart';

void main() {
  testWidgets('Validation displays error message correctly', (WidgetTester tester) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    bool validator = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    CheckboxListTile.adaptive(
                          title: const Text('CheckboxListTile'),
                          value: validator,
                          onChanged: (bool? value) {
                            setState(() {
                              validator = value!;
                            });

                            formKey.currentState?.validate();
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        )
                        .onSaved(() {
                          print(validator);
                        })
                        .validator(() {
                          return !validator ? 'Required' : null;
                        }),
                    ElevatedButton(
                      onPressed: () {
                        formKey.currentState?.validate();
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Required'), findsNothing);

    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('Required'), findsOneWidget);

    await tester.tap(find.byType(CheckboxListTile));
    await tester.pump();

    expect(find.text('Required'), findsNothing);
  });
}
