import 'package:flutter/material.dart';
import 'package:task_organizer/components/task.dart';
import 'package:task_organizer/models/task_dao.dart';

class FormScreen extends StatefulWidget {
  final BuildContext taskContext;

  const FormScreen({super.key, required this.taskContext});

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

  @override
  void initState() {
    super.initState();

    imageController.addListener(updateImage);
  }

  @override
  void dispose() {
    nameController.dispose();
    difficultyController.dispose();
    imageController.dispose();
    super.dispose();
  }

  void _clearForm() {
    nameController.clear();
    difficultyController.clear();
    imageController.clear();
  }

  void updateImage() {
    setState(() {

    });
  }

  Widget _buildAppBar() {
    return AppBar(
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
    );
  }

  Widget _buildTextFormField({
      required TextEditingController controller,
      required String labelText,
      IconData? icon,
      TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator
    }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.blue,
          ),
          labelText: labelText,
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
    );
  }

  String? _validateInput(String? value, String fieldName, int? minValue, int? maxValue) {
    if (value == null || value.isEmpty) {
      return 'Please enter the $fieldName';
    }

    if (minValue != null && maxValue != null) {
      int parsedValue = int.tryParse(value) ?? 0;

      if (parsedValue < minValue || parsedValue > maxValue) {
        return 'Please enter a $fieldName between $minValue and $maxValue';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56), child: _buildAppBar()),
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
                  _buildTextFormField(
                    controller: nameController,
                    labelText: 'Task Description *',
                    icon: Icons.task,
                    keyboardType: TextInputType.name,
                    validator: (value) => _validateInput(value, 'task name', null, null)
                  ),
                  _buildTextFormField(
                    controller: difficultyController,
                    labelText: 'Task Difficulty *',
                    icon: Icons.stars,
                    keyboardType: TextInputType.number,
                    validator: (value) => _validateInput(value, 'difficulty', 1, 5),
                  ),
                  _buildTextFormField(
                    controller: imageController,
                    labelText: 'Task Image *',
                    icon: Icons.image,
                    keyboardType: TextInputType.url,
                    validator: (value) => _validateInput(value, 'image URL', null, null),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.blue),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageController.text,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.no_photography_outlined,
                                color: Colors.grey,
                                size: 42,
                              ),
                            );
                          },
                        ),
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

                              TaskDao().save(Task(taskName: getTaskName(), imageUrl: getImageUrl(), difficultyRating: getDifficulty()));

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Saving new task...')));

                              Navigator.pop(context);

                              _clearForm();
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
