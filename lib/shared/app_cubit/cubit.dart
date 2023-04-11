
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/done_tasks_screen/view/done_tasks_screen.dart';
import 'package:todo/shared/app_cubit/states.dart';
import '../../Network/cache_helper.dart';
import '../../archived_tasks_screen/view/archived_tasks_screen.dart';
import '../../new_tasks_screen/view/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit():super(AppInitialState());

static AppCubit getInstanse(BuildContext context)=>BlocProvider.of(context);
 


 int currentIndex=0;
  List<String> titles=['NewTasks','DoneTasks','ArchivedTasks'];
  List<Widget> items=[const NewTasks(),const DoneTasks(),const ArchivedTasks(),];
  void changeCurrentIndex(int index){
    currentIndex=index;
    emit(ChangeBottomNavBarState());
  }

  
  Database? database;
  List<Map> newTasks =[];
  List<Map> archivedTasks =[];
  List<Map> doneTasks =[];

  bool showBottomSheet=false;
  IconData fabIcon =Icons.edit;

  void changeBottomSheet({required bool isShown,required IconData icon}){
    showBottomSheet=isShown;
    fabIcon=icon;
    emit(ChangeBottomSheetState());
  }
   void getDataFromDatabase(Database database){
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
    emit(GetFromDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
               changeBottomSheet(isShown: false, icon: Icons.edit);
                for (var element in value) {
                  if(element['status']=='new'){
                    newTasks.add(element);
                  }else if(element['status'] == "done"){
                    doneTasks.add(element);
                  }else{
                    archivedTasks.add(element);
                  }
                }
                 emit(GetFromDatabaseState());
             
             });
   //emit(GetFromDatabaseState());
  }

   void createDatabase() async {

     database=await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('Database Created');
        database.execute
        ('CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,time TEXT,date TEXT,status TEXT)')
        .then((value) { 
          emit(CreateDatabaseState());
        })
        .catchError((error){
      print('error ${error.toString()}');
    });
    } ,
    onOpen: (db) {
      getDataFromDatabase(db);
      print('Database Opened');
    },);
   }

   insertToDataase(
    {
      required String title,
      required String time,
      required String date,
    }
  )async{
    await database?.transaction((txn){
   return txn.rawInsert('INSERT INTO tasks(title,time,date,status) VALUES("$title","$time","$date","new")')
.then((value) {
  emit(InsertToDatabaseState());

             getDataFromDatabase(database!);
            });

}).catchError((error){
  print(error.toString());
});
    
  }
  

  void updateData({required String status , required int id}){
    database?.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',[status,id]).then((value) {
           
      getDataFromDatabase(database!);
       emit(UpdateDatabaseState());

    });
  }
  void deleteData({required int id}){
    database?.rawDelete('DELETE FROM tasks WHERE id = ?',[id]).then((value) {
      getDataFromDatabase(database!);
       emit(DeleteDatabaseState());
    });
   
  }
  }
