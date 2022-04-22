import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/news_app/search/search.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewStates>(
        listener:(context, state) {}  ,
        builder:(context, state) {
          var cubit=NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(
                    onPressed: (){
                      navigateTO(
                          context,
                          SearchScreen()
                      );
                    },
                    icon: Icon(
                      Icons.search,
                    )
                ),
                IconButton(
                    onPressed: (){
                      AppCubit.get(context).changeAppMode();
                    },
                    icon: Icon(
                      Icons.brightness_4_outlined,
                    )
                )
              ],
            ),
            body:cubit.screens[cubit.currentIndex] ,
            bottomNavigationBar: BottomNavigationBar  (
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
            ),
          );
        } ,
    );
  }
}
