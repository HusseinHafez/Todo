import 'package:flutter/material.dart';
import 'package:todo/components/conditional_builder.dart';
import 'package:todo/components/task_shape.dart';
import 'package:todo/size_config.dart';

class TaskBuilder extends StatelessWidget {
  final List tasks;
  const TaskBuilder({super.key,required this.tasks,});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(condition: tasks.isNotEmpty,
     builder:(context) => ListView.separated(
      itemBuilder: (context, index) => TaskShape(
        model:tasks[index],),
       separatorBuilder: (context, index) => Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
        padding: const EdgeInsetsDirectional.only(start: 40.0,),
      ), itemCount: tasks.length),
     fallback:(context) =>  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.menu,
          color: Colors.grey,
          size: 30,
          ),
          SizedBox(
            height: getHeight(10),
          ),
          Text('Please enter some tasks',style: TextStyle(
            color: Colors.grey,
            fontSize: getFont(30),
            fontWeight: FontWeight.bold,
          ),)

        ],
      ),
     ),
     );
  }
}