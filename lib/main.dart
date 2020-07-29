import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'package:my_list_framework/src/blocs/albums_bloc.dart';
import 'package:my_list_framework/src/blocs/posts_bloc.dart';
import 'package:my_list_framework/src/blocs/todos_bloc.dart';
import 'package:my_list_framework/src/ui/pages/tab_list_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      tagText: 'blocFrwk',
      child: MaterialApp(
        title: 'My List Framework',
        color: Colors.deepPurple,
        home: MyTabList(),
        debugShowCheckedModeBanner: false,
      ),
      blocs: [
        Bloc((i) => AlbumsBloc()),
        Bloc((i) => PostsBloc()),
        Bloc((i) => TodosBloc()),
      ],
    );
  }
}