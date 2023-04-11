import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/NewsCubit.dart';
import 'package:news_app/shared/cubit/news_states.dart';

import '../shared/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state){
        NewsCubit cubit = NewsCubit.get(context);
        return newsListBuilder(list: cubit.businessList);
      }
    );
  }
}
