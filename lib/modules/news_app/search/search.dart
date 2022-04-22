import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_app/cubit/cubit.dart';
import '../../../layout/news_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
var searchController=TextEditingController();
var isSearch=true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
                  Padding(
          padding: const EdgeInsets.all(20.0),
          child: defaultFormField(
              controller: searchController,
              type: TextInputType.text,
              validate: (String? value){
                if(value!.isEmpty){
                  return 'search must not be empty';
                }
                else
                  return null;
              },
              label: 'Search',
              prefix: Icons.search,
              onChange: (value){
                NewsCubit.get(context).getSearch(value);
              }
          ),
        ),
                NewsCubit.get(context).search.length>0
                    ? Expanded(
                      child: ListView.separated(
                      physics:BouncingScrollPhysics() ,
                      itemBuilder: (context,index)=>buildArticalItem(NewsCubit.get(context).search[index],context),
                      separatorBuilder:(context,index)=>myDivider() ,
                      itemCount:NewsCubit.get(context).search.length
                ),
                    )
                    : isSearch?Container():Center(child: CircularProgressIndicator())
        ],
        ),
        );
      },
    );
  }
}
