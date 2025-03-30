import 'package:flutter/material.dart';
import 'package:form_extensions/form_extensions.dart';
import 'model/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true), home: const MyHomePage(title: 'Flutter Demo Home Page'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  UserModel userModel = UserModel();

  TextEditingController textFormField = TextEditingController();
  int gender = -1;
  int selectedAge = -1;
  List<String> address = [];
  bool withoutValidator = false;
  bool checkTerm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //^ TextFormField
              //^ No changes... continue using the same properties.
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: textFormField,
                  decoration: const InputDecoration(hintText: "Name"),
                  onSaved: (value) {
                    userModel.name = value;
                  },
                  validator: (value) {
                    return value == null || value.isEmpty ? 'Required' : null;
                  },
                ),
              ),

              //^ Radio
              const Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10), child: Text("Gender", style: TextStyle(fontWeight: FontWeight.bold)))),
              Column(
                    children: <Widget>[
                      RadioListTile.adaptive(
                        title: const Text("Male"),
                        value: 0,
                        groupValue: gender,
                        onChanged: (int? value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      RadioListTile.adaptive(
                        title: const Text("Female"),
                        value: 1,
                        groupValue: gender,
                        onChanged: (int? value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                    ],
                  )
                  .onSaved(() {
                    userModel.gender = gender;
                  })
                  .validator(() {
                    return gender == -1 ? 'You need to select a gender' : null;
                  }),

              //^ Chips
              const Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10), child: Text("Age", style: TextStyle(fontWeight: FontWeight.bold)))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                      children: [
                        ChoiceChip(
                          label: const Text('10-20'),
                          selected: selectedAge == 0,
                          onSelected: (bool selected) {
                            setState(() {
                              selectedAge = selected ? 0 : -1;
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        ChoiceChip(
                          label: const Text('21-30'),
                          selected: selectedAge == 1,
                          onSelected: (bool selected) {
                            setState(() {
                              selectedAge = selected ? 1 : -1;
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        ChoiceChip(
                          label: const Text('31-40'),
                          selected: selectedAge == 2,
                          onSelected: (bool selected) {
                            setState(() {
                              selectedAge = selected ? 2 : -1;
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        ChoiceChip(
                          label: const Text('41-50'),
                          selected: selectedAge == 3,
                          onSelected: (bool selected) {
                            setState(() {
                              selectedAge = selected ? 3 : -1;
                            });
                          },
                        ),
                      ],
                    )
                    .onSaved(() {
                      userModel.age = selectedAge;
                    })
                    .validator(() {
                      return selectedAge == -1 ? 'You need to select an age' : null;
                    }),
              ),

              //^ CheckboxListTile
              CheckboxListTile.adaptive(
                title: const Text('Option without validator'),
                value: withoutValidator,
                onChanged: (bool? value) {
                  setState(() {
                    withoutValidator = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ).onSaved(() {
                userModel.withoutValidator = withoutValidator;
              }),

              //^ ListView
              const Align(alignment: Alignment.centerLeft, child: Padding(padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10), child: Text("Address", style: TextStyle(fontWeight: FontWeight.bold)))),
              ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: address.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ListTile(
                              title: Text(address[index], maxLines: 1, overflow: TextOverflow.ellipsis),
                              trailing: const Icon(Icons.remove_circle_outline, color: Colors.red),
                              onTap: () {
                                setState(() {
                                  address.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  )
                  .onSaved(() {
                    userModel.address = [];
                    userModel.address!.addAll(address);
                  })
                  .validator(() {
                    return address.isEmpty ? 'You must provide an address' : null;
                  }),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    address.add("Test address");
                  });
                },
                label: const Text("Add address"),
                icon: const Icon(Icons.add),
              ),

              //^ CheckboxListTile
              CheckboxListTile.adaptive(
                    title: const Text('Terms of use'),
                    value: checkTerm,
                    onChanged: (bool? value) {
                      setState(() {
                        checkTerm = value!;
                      });
                    },
                    secondary: const Icon(Icons.hourglass_empty),
                  )
                  .onSaved(() {
                    userModel.checkTerm = checkTerm;
                  })
                  .validator(() {
                    return !checkTerm ? 'You must accept the terms' : null;
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          if (!_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Check the required fields!'), backgroundColor: Colors.red));
          } else {
            _formKey.currentState!.save();

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('userModel'),
                  content: Text('${userModel.toJson()}'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved!'), backgroundColor: Colors.green));
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          }
        },
        label: const Text("Save", style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.save, color: Colors.white),
      ),
    );
  }
}
