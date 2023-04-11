import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/components/task_builder.dart';
import 'package:todo/shared/app_cubit/cubit.dart';
import 'package:todo/shared/app_cubit/states.dart';



class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppStates>(
      builder: (context, state) {
        var tasks=AppCubit.getInstanse(context).archivedTasks;
        return  TaskBuilder(tasks: tasks);
      },
    );
  }
}