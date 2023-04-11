// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/bottom_navigation_screen/view/widgets/default_textfield.dart';
import 'package:todo/components/conditional_builder.dart';
import 'package:todo/shared/app_cubit/cubit.dart';
import 'package:todo/shared/app_cubit/states.dart';
import 'package:todo/shared/theme_data_cubit/theme_data_cubit.dart';
import 'package:todo/size_config.dart';
import 'package:intl/intl.dart';

class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is InsertToDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.getInstanse(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              BlocBuilder<ThemeDataCubit, ThemeDataState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed:
                        ThemeDataCubit.getInstanse(context).toggleThemeMode,
                    icon: const Icon(Icons.brightness_6_outlined),
                  );
                },
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: state is! GetFromDatabaseLoadingState,
            builder: (context) => cubit.items[cubit.currentIndex],
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.showBottomSheet) {
                bool? isValid = formKey.currentState?.validate();
                if (isValid!) {
                  cubit.insertToDataase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text);
                }
              } else {
                cubit.changeBottomSheet(isShown: true, icon: Icons.add);
                scaffoldKey.currentState
                    ?.showBottomSheet(
                      (context) => Container(
                        padding: const EdgeInsets.all(20.0),
                        color: Colors.white,
                        child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DefaultTextField(
                                  label: 'Task Title',
                                  controller: titleController,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Please Enter a title';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  prefixIcon: Icons.title,
                                ),
                                SizedBox(
                                  height: getHeight(15),
                                ),
                                DefaultTextField(
                                  label: 'Task Time',
                                  controller: timeController,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Please Enter a Time';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      if (value != null) {
                                        timeController.text =
                                            value.format(context);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'Please enter Time');
                                      }
                                    });
                                  },
                                  keyboardType: TextInputType.datetime,
                                  prefixIcon: Icons.watch_later_outlined,
                                ),
                                SizedBox(
                                  height: getHeight(15),
                                ),
                                DefaultTextField(
                                  label: 'Task Date',
                                  controller: dateController,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Please Enter a Date';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate:
                                                DateTime.parse('2029-12-31'))
                                        .then((value) {
                                      if (value != null) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: 'PLease Enter Date');
                                      }
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icons.calendar_today,
                                ),
                              ],
                            )),
                      ),
                      elevation: 20.0,
                    )
                    .closed
                    .then((value) {
                  cubit.changeBottomSheet(isShown: false, icon: Icons.edit);
                });
              }
            },
            child: Icon(cubit.fabIcon),
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: ((value) => cubit.changeCurrentIndex(value)),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archived',
                ),
              ]),
        );
      },
    );
  }
}
