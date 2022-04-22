import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_app/cubit/cubit.dart';
import '../../../layout/news_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is NewsGetBusinessLoadingState
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
               physics:BouncingScrollPhysics() ,
               itemBuilder: (context,index)=>buildArticalItem(NewsCubit.get(context).business[index],context),
               separatorBuilder:(context,index)=>myDivider() ,
               itemCount:NewsCubit.get(context).business.length
          );
        },
    );
  }
}
