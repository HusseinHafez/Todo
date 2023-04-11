import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/components/task_builder.dart';
import 'package:todo/shared/app_cubit/cubit.dart';
import 'package:todo/shared/app_cubit/states.dart';


class NewTasks extends StatelessWidget {
  const NewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppStates>(
      builder: (context, state) {
        var tasks=AppCubit.getInstanse(context).newTasks;
        return  TaskBuilder(tasks: tasks);
      },
    );
  }
}