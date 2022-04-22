import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_app/cubit/cubit.dart';
import '../../../layout/news_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return NewsCubit.get(context).sports.length>0
            ? ListView.separated(
            physics:BouncingScrollPhysics() ,
            itemBuilder: (context,index)=>buildArticalItem(NewsCubit.get(context).sports[index],context),
            separatorBuilder:(context,index)=>myDivider() ,
            itemCount:NewsCubit.get(context).sports.length
        )
            : Center(child: CircularProgressIndicator());
      },
    );  }
}
