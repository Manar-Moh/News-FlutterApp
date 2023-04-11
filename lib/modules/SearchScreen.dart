import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components.dart';
import '../shared/cubit/NewsCubit.dart';
import '../shared/cubit/news_states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state) {},
        builder: (context, state){
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(icon: const Icon(Icons.keyboard_backspace),onPressed: (){
                cubit.searchList = [];
                cubit.searchController.text = '';
                Navigator.of(context).pop();
              }),
              title: const Text('NewsApp',style: TextStyle(fontWeight: FontWeight.bold),),
              // leading: const Icon(Icons.newspaper),
              actions: [
                IconButton(onPressed: () => cubit.changeThemeMode(null),
                  icon: (NewsCubit.iconDark)? const Icon(Icons.light_mode):const Icon(Icons.dark_mode),
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                      controller: cubit.searchController,
                      inputType: TextInputType.text,
                      validate: (String? value){
                        if(value == null){
                          return "Search Mustn\'t be Empty";
                        }
                        return null;
                      },
                      onChange: (value){
                       print(value);
                       cubit.getSearch(cubit.searchController.text);
                      },
                      // autoFocus: false,
                      label: 'Search',
                      prefixIcon: Icons.search
                  ),
                ),
                Expanded(child: searchListBuilder(list: cubit.searchList))
              ],
            ),
          );
        }
    );
  }
}
