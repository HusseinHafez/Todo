import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Network/cache_helper.dart';

part 'theme_data_state.dart';

class ThemeDataCubit extends Cubit<ThemeDataState> {
  ThemeDataCubit() : super(ThemeDataInitial());
  static ThemeDataCubit getInstanse(BuildContext context) =>
      BlocProvider.of(context);
  bool isLight = true;
  void toggleThemeMode({bool? isShared}) {
    if (isShared != null) {
      isLight = isShared;
    } else {
      isLight = !isLight;
      CacheHelper.putBoolean(key: 'isLight', value: isLight);
    }
    emit(ChangeThemeModeState());
  }
}
