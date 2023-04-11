import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:news_app/modules/SearchScreen.dart';
import 'package:news_app/shared/components.dart';
import 'package:news_app/shared/cubit/NewsCubit.dart';
import 'package:news_app/shared/cubit/news_states.dart';

import '../shared/local/ChacheHelper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('NewsApp',style: TextStyle(fontWeight: FontWeight.bold),),
            leading: const Icon(Icons.newspaper),
            actions: [
              IconButton(onPressed: () => cubit.changeThemeMode(null),
                  icon: (NewsCubit.iconDark)? const Icon(Icons.light_mode):const Icon(Icons.dark_mode),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(onPressed: (){
                  cubit.searchList = [];
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
                },
                  icon: const Icon(Icons.search),
                ),
              ),
            ],
          ),
          bottomNavigationBar: snackBottomNavigation(cubit),
          body: cubit.screens[cubit.currentIndex],
        );
      }
    );
  }
}
