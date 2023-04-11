import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/NewsLayout.dart';
import 'package:news_app/shared/cubit/NewsCubit.dart';
import 'package:news_app/shared/cubit/cubitObserver.dart';
import 'package:news_app/shared/cubit/news_states.dart';
import 'package:news_app/shared/local/ChacheHelper.dart';
import 'package:news_app/shared/network/DioHelper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getCacheBool(key: 'isDark');

  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;
   const MyApp(this.isDark, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..businessGetData()..changeThemeMode(isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home:  const NewsLayout(),
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.teal,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,),
              ),
              primarySwatch: Colors.teal,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.teal,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.teal,
              ),
            ),
            themeMode: (NewsCubit.iconDark)?ThemeMode.dark:ThemeMode.light,
            darkTheme: ThemeData(
              colorScheme: const ColorScheme.dark(background: Colors.black12),
              appBarTheme: const AppBarTheme(color: Colors.teal),
              inputDecorationTheme: const InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                labelStyle: TextStyle(color: Colors.teal),
              ),
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: Colors.teal, //<-- SEE HERE
                )
            ),
          );
        }
      ),
    );
  }
}