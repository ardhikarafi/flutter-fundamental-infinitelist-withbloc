import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list_withbloc/bloc/post_bloc.dart';
import 'package:infinite_list_withbloc/ui/mainpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<PostBloc>(
          builder: (context) => PostBloc()..add(PostEvent()),
          child: MainPage()),
    );
  }
}
