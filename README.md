# Form Extensions

Easily add `.onSaved` and `.validator` to any widget in Flutter! Simplify form handling with this powerful package.

## Screenshots

### Example Output
![Screenshot 1](https://raw.githubusercontent.com/chrystoffer/form_extensions/main/screenshots/001.png)
![Screenshot 2](https://raw.githubusercontent.com/chrystoffer/form_extensions/main/screenshots/002.png)

## 🚀 Installation
Add this to your `pubspec.yaml`:

```yaml
dependencies:
  form_extensions: latest_version
```

Run:

```sh
flutter pub get
```

## 📖 Usage
### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:form_extensions/form_extensions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Extensions Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxListTile.adaptive(
                title: const Text('Accept Terms'),
                value: _checked,
                onChanged: (bool? value) {
                  setState(() {
                    _checked = value!;
                  });
                },
              ).onSaved(() {
                print("checkTerm = $checkTerm");
              }).validator(() {
                return !checkTerm ? 'You must accept the terms' : null;
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form is valid!')),
                    );
                  } else {
                    _formKey.currentState!.save();
                  }
                },
                child: Text('Validate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## 📌 Features
✅ Add `.onSaved` and `.validator` to any widget.
✅ Improve form validation and state management.
✅ Works seamlessly with Flutter's `Form` and `FormField`.

## 🔗 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

