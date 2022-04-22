import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/news_app/web_view/web_view_screen.dart';

Widget defaultButton({
  required double? width,
  required Color? background,
  required VoidCallback? function,
  required String? text,

}) =>
    Container(
      height: 40.0,
      decoration:BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(4),
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text!.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required String? label,
  required IconData? prefix,
  IconData? suffix,
  VoidCallback?suffixPress,
  GestureTapCallback? onTap,
  bool isClickable=true,
}) =>
    TextFormField(
      enabled: isClickable,
      onTap: onTap,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed:suffixPress,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
      ),
      validator: validate,
    );


Widget buildArticalItem(article,context)=>InkWell(
  onTap: (){
    navigateTO(
        context,
        WebViewScreen(article['url'])
    );
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120,
  
          height: 120,
  
          decoration: BoxDecoration(
  
              borderRadius: BorderRadius.circular(10),
  
              image: DecorationImage(
  
                  image: NetworkImage('${article['urlToImage']}'),
  
                  fit:BoxFit.cover
  
              )
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20,
  
        ),
  
        Expanded(
  
          child: Container(
  
            height: 120,
  
            child: Column(
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text('${article['title']}',
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                    maxLines: 3,
  
                    overflow:TextOverflow.ellipsis ,
  
                  ),
  
                ),
  
                Text('${article['publishedAt']}',
  
                  style: TextStyle(
  
                    color: Colors.grey,
  
                    fontWeight: FontWeight.w600,
  
                    fontSize: 20,
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
        )
  
      ],
  
    ),
  
  ),
);
Widget myDivider()=>Padding(
  padding: const EdgeInsets.only(left: 20.0),
  child:   Container(

    width: double.infinity,

    color: Colors.grey[300],

    height: 1.0,

  ),
);
void navigateTO(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );

void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
    (Route<dynamic> route)=>false

);
void showtoast({
  required String text,
  required ToastStates state
})=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
       color=Colors.green;
      break;
    case ToastStates.ERROR:
       color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.yellow;
      break;
  }
  return color;
}
