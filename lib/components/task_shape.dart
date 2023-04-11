import 'package:flutter/material.dart';
import 'package:todo/shared/app_cubit/cubit.dart';
import 'package:todo/size_config.dart';

class TaskShape extends StatelessWidget {
  final Map model;
  const TaskShape({super.key,required this.model,});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background:Container(
        color: Colors.red,
      ),
      key: Key(model['id'].toString()),
      onDismissed: (direction) => AppCubit.getInstanse(context).deleteData(id: model['id']),
      child: Padding(padding: const EdgeInsets.all(16.0),child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Center(
              child: Text('${model['time']}'),
            ),
          ),
          SizedBox(
            width: getWidth(20),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model['title']}',style: Theme.of(context).textTheme.bodyText1,),
                 Text('${model['date']}',style: const TextStyle(color: Colors.grey),),
              ],
            ),
          ),
          SizedBox(
            width: getWidth(10),
          ),
          TextButton(onPressed: () => AppCubit.getInstanse(context).updateData(status: "done", id: model['id']),
           style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.transparent),elevation: MaterialStatePropertyAll(0)),
           child: const Text('Done',style: TextStyle(color: Colors.green),),
           ),
            TextButton(onPressed: () => AppCubit.getInstanse(context).updateData(status: 'Archived', id: model['id']),
           style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.transparent),elevation: MaterialStatePropertyAll(0)),
           child: const Text('Archived',style: TextStyle(color: Colors.grey),),
           )
        ],
      ),),
    );
  }
}