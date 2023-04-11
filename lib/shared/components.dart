import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:news_app/modules/WebViewScreen.dart';
import 'package:news_app/shared/cubit/NewsCubit.dart';

Widget defaultFormField({
    required TextEditingController controller,
    required TextInputType inputType,
    Function(String?)? onSubmit,
    Function(String?)? onChange,
    Function()? onTap,
    required String? Function(String?) validate,
    bool obscure = false,
    required String label,
    required IconData prefixIcon,
    IconData? suffixIcon,
    bool isClickable = true,
    bool autoFocus = true,
})=> TextFormField(
    controller: controller,
    autofocus: autoFocus,
    keyboardType: inputType,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    obscureText: obscure,
    validator: validate,
    onTap: onTap,
    enabled: isClickable,
    decoration: InputDecoration(
        labelText: label,
        prefix: Icon(prefixIcon),
        suffixIcon: Icon(suffixIcon),
        border: const OutlineInputBorder(),
        floatingLabelAlignment: FloatingLabelAlignment.center,
    ),
);

Widget snackBottomNavigation(NewsCubit cubit) => SnakeNavigationBar.color(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30))
    ),
    showUnselectedLabels: true,
    showSelectedLabels: true,
    currentIndex: cubit.currentIndex,
    onTap: (index) => cubit.changeBottomIndex(index),
    items: cubit.navigationItems,
    snakeViewColor: Colors.white,
    unselectedLabelStyle: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
);

Widget newsContainer({required Function()? onTapFun,required String title, required String datetime, required String img}) =>
    InkWell(
      onTap: onTapFun,
      child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
          children: [
              Container(
                  height: 110.0,
                  width: 110.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(img),
                      ),
                  ),
              ),

              const SizedBox(width: 10,),

              Expanded(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                          Text(
                              title,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                              datetime,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 15,color: Colors.blueGrey),
                          ),
                      ],
                  ),
              ),
          ],
      ),
),
    );

Widget newsListBuilder({required List list }) => ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) => ListView.builder(
        itemBuilder: (context, index) => newsContainer(
            onTapFun: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(list[index]['url']),));
            },
            title: list[index]['title'],
            datetime: list[index]['publishedAt'],
            img: (list[index]['urlToImage'] != null)?list[index]['urlToImage']:'https://as1.ftcdn.net/v2/jpg/03/45/05/92/1000_F_345059232_CPieT8RIWOUk4JqBkkWkIETYAkmz2b75.jpg',
        ),
        itemCount: list.length,
    ),
    fallback: (context) => const Center(child: CircularProgressIndicator()),
);

Widget searchListBuilder({required List list}) => ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (context, index) => newsContainer(
        onTapFun: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(list[index]['url']),));
        },
        title: list[index]['title'],
        datetime: list[index]['publishedAt'],
        img: (list[index]['urlToImage'] != null)?list[index]['urlToImage']:'https://as1.ftcdn.net/v2/jpg/03/45/05/92/1000_F_345059232_CPieT8RIWOUk4JqBkkWkIETYAkmz2b75.jpg',
    ),
    itemCount: list.length,
);