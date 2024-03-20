import 'package:flutter/material.dart';

class TaskInherited extends InheritedWidget {
  const TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType();
    assert(result != null, 'No TaskInherited found in context');

    return result!;
  }
  
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw UnimplementedError();
  }
}