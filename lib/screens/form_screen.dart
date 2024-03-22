import 'package:flutter/material.dart';
import '../data/task_inherited.dart';

class FormScreen extends StatefulWidget {
  final BuildContext taskContext;

  const FormScreen({ super.key, required this.taskContext});
  
  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController difficultyController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  String getTaskName() => nameController.text;
  String getImageUrl() => imageController.text;
  int getDifficulty() => int.tryParse(difficultyController.text) ?? 0;

  void clearForm() {
    nameController.clear();
    difficultyController.clear();
    imageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'New Task',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 550,
              width: 375,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(width: 3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return 'Insert the task name';
                        }

                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.task,
                          color: Colors.blue,
                        ),
                        labelText: 'Task Description *',
                        labelStyle: const TextStyle(color: Colors.blue),
                        fillColor: Colors.blue.withOpacity(0.1),
                        filled: true,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      cursorColor: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            int.parse(value) > 5 ||
                            int.parse(value) < 1) {
                          return 'Insert a difficulty between 1 and 5';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: difficultyController,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.stars,
                          color: Colors.blue,
                        ),
                        labelText: 'Task Difficulty *',
                        labelStyle: const TextStyle(color: Colors.blue),
                        fillColor: Colors.blue.withOpacity(0.1),
                        filled: true,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      cursorColor: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Insert an image URL!';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.url,
                      onChanged: (text) {
                        setState(() {});
                      },
                      controller: imageController,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.image,
                          color: Colors.blue,
                        ),
                        labelText: 'Task Image *',
                        labelStyle: const TextStyle(color: Colors.blue),
                        fillColor: Colors.blue.withOpacity(0.1),
                        filled: true,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      cursorColor: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.blue)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(imageController.text,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.no_photography_outlined,
                              color: Colors.grey,
                              size: 42,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              TaskInherited.of(widget.taskContext).addNewTask(getTaskName(), getImageUrl(), getDifficulty());
                              
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saving new task...')));
                            
                              Navigator.pop(context);

                              clearForm();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.blue),
                          ),
                          child: const Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
