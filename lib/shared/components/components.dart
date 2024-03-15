import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';


Widget defaultButton({
  double width = double.infinity,
  Color backgroundColor = Colors.deepPurpleAccent,
  required VoidCallback function,
  required String text,
  bool isUpperCase = true,
  double radius = 0,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: backgroundColor,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController control,
  required String text,
  required IconData prefix,
  required TextInputType type,
  bool isPassword = false,
  IconData? suffix,
  void Function(String)? onSubmit, // Update the type to accept a string
  void Function(String)? onChange,
  VoidCallback? onTap, // Update the type to accept a string
  required String? Function(String?) validate,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: control,
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix),
              )
            : null,
      ),
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      // Pass onSubmit directly
      onChanged: onChange,
      // Pass onChange directly
      validator: validate,
      onTap: onTap,
      enabled: isClickable,
    );


Widget buildArticleItem(article) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              image: DecorationImage(
                image: article['urlToImage'] != null
                    ? NetworkImage('${article['urlToImage']}')
                    : NetworkImage(
                        'https://images.pexels.com/photos/1092644/pexels-photo-1092644.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                      ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),
    );


Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );


Widget articleBuilder(list)=>ConditionalBuilder(
  condition: list.length>0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index]),
    separatorBuilder: (context, state) => myDivider(),
    itemCount: 10,
  ),
  fallback: (context) => Center(
    child: CircularProgressIndicator(),
  ),
);