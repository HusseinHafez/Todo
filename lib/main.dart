import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import 'package:todo/shared/app_cubit/cubit.dart';
import 'package:todo/shared/app_cubit/states.dart';
import 'package:todo/shared/bloc_observer/bolc_observer.dart';
import 'package:todo/shared/theme_data_cubit/theme_data_cubit.dart';

import 'Network/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? isMode = CacheHelper.getBoolean(key: 'isLight');
  runApp(MyApp(isMode: isMode));
}

class MyApp extends StatelessWidget {
  final bool? isMode;

  const MyApp({super.key, required this.isMode});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => AppCubit()
            ..createDatabase(),
        ),
        BlocProvider(
          create: (context) => ThemeDataCubit()..toggleThemeMode(isShared: isMode),
        ),
      ],
      child: BlocBuilder<ThemeDataCubit, ThemeDataState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'todo',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              primarySwatch: Colors.deepOrange,
              appBarTheme: const AppBarTheme(
                actionsIconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              /* timePickerTheme: TimePickerThemeData(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    dialHandColor: Colors.deepOrange,
                    dialTextColor: Colors.black,
                    hourMinuteColor: Colors.transparent,
                    dialBackgroundColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    dayPeriodBorderSide: const BorderSide(color: Colors.black),
                  ), */
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.black,
                elevation: 40,
                type: BottomNavigationBarType.fixed,
              ),
            ),
            darkTheme: ThemeData(
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                shadowColor: Colors.white,
                elevation: 8,
                backgroundColor: HexColor('#121212'),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('#121212'),
                  statusBarIconBrightness: Brightness.light,
                ),
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              scaffoldBackgroundColor: HexColor('#121212'),
              /*  timePickerTheme: TimePickerThemeData(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    dialHandColor: Colors.deepOrange,
                    dialTextColor: Colors.white,
                    hourMinuteColor: Colors.transparent,
                    dialBackgroundColor: Colors.transparent,
                    backgroundColor: HexColor('#121212'),
                    dayPeriodBorderSide: const BorderSide(color: Colors.white),
                  ), */
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor('#121212'),
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.white,
                elevation: 40,
                type: BottomNavigationBarType.fixed,
              ),
            ),
            themeMode: ThemeDataCubit.getInstanse(context).isLight
                ? ThemeMode.light
                : ThemeMode.dark,
            home: BottomNavigationScreen(),
          );
        },
      ),
    );
  }
}
