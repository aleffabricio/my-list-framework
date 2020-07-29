import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:my_list_framework/src/blocs/albums_bloc.dart';
import 'package:my_list_framework/src/blocs/posts_bloc.dart';
import 'package:my_list_framework/src/blocs/todos_bloc.dart';
import 'package:my_list_framework/src/core/entity/albums_entity.dart';
import 'package:my_list_framework/src/core/entity/posts_entity.dart';
import 'package:my_list_framework/src/core/entity/todos_entity.dart';

class MyTabList extends StatefulWidget {
  @override
  _MyTabListState createState() => _MyTabListState();
}

class _MyTabListState extends State<MyTabList>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final AlbumsBloc blocAlbums =
      BlocProvider.tag('blocFrwk').getBloc<AlbumsBloc>();

  final PostsBloc blocPosts = BlocProvider.tag('blocFrwk').getBloc<PostsBloc>();

  final TodosBloc blocTodos = BlocProvider.tag('blocFrwk').getBloc<TodosBloc>();

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    blocAlbums.getAlbumsService();
    blocPosts.getPostService();
    blocTodos.getTodoService();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            title: Image.asset('assets/logo2.png', fit: BoxFit.cover),
            centerTitle: true,
            backgroundColor: Color(0xff6800DC),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.photo_library,
                  ),
                  text: 'Albums',
                ),
                Tab(
                  icon: Icon(
                    Icons.add_to_photos,
                  ),
                  text: 'Posts',
                ),
                Tab(
                  icon: Icon(
                    Icons.insert_photo,
                  ),
                  text: 'Todos',
                )
              ],
            )),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            StreamBuilder<List<AlbumsEntity>>(
                initialData: [],
                stream: blocAlbums.outAlbums,
                builder: (_, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xff6800DC)),
                        ),
                      );
                    default:
                      if (!snapshot.hasError) {
                        return MyCustomCard(
                            positionTab: 0,
                            lengthList: snapshot.data.length,
                            listPosts: List<PostsEntity>(),
                            listTodos: List<TodosEntity>(),
                            listAlbums: snapshot.data);
                      } else {
                        return Center(
                          child: Text("Erro ao carregar"),
                        );
                      }
                  }
                }),
            StreamBuilder<List<PostsEntity>>(
                initialData: [],
                stream: blocPosts.outPosts,
                builder: (_, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xff6800DC)),
                        ),
                      );
                    default:
                      if (!snapshot.hasError) {
                        return MyCustomCard(
                            positionTab: 1,
                            lengthList: snapshot.data.length,
                            listAlbums: List<AlbumsEntity>(),
                            listTodos: List<TodosEntity>(),
                            listPosts: snapshot.data);
                      } else {
                        return Center(
                          child: Text("Erro ao carregar"),
                        );
                      }
                  }
                }),
            StreamBuilder<List<TodosEntity>>(
                initialData: [],
                stream: blocTodos.outTodos,
                builder: (_, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xff6800DC)),
                        ),
                      );
                    default:
                      if (!snapshot.hasError) {
                        return MyCustomCard(
                            positionTab: 2,
                            lengthList: snapshot.data.length,
                            listAlbums: List<AlbumsEntity>(),
                            listPosts: List<PostsEntity>(),
                            listTodos: snapshot.data);
                      } else {
                        return Center(
                          child: Text("Erro ao carregar"),
                        );
                      }
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class MyCustomCard extends StatelessWidget {
  int positionTab = 0;
  int lengthList = 0;

  List<AlbumsEntity> listAlbums = List<AlbumsEntity>();
  List<PostsEntity> listPosts = List<PostsEntity>();
  List<TodosEntity> listTodos = List<TodosEntity>();

  MyCustomCard({
    @required this.positionTab,
    @required this.lengthList,
    @required this.listAlbums,
    @required this.listPosts,
    @required this.listTodos,
  });

  @override
  Widget build(BuildContext context) {
    if (positionTab == 1) {
      listPosts.forEach((e) {
        listAlbums.add(AlbumsEntity(e.userId, e.id, e.title));
      });
    } else if (positionTab == 2) {
      listTodos.forEach((e) {
        listAlbums.add(AlbumsEntity(e.userId, e.id, e.title));
      });
    }
    return ListView.builder(
      itemCount: lengthList,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(width: 5, color: Color(0xff6800DC)),
              )),
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: Icon(
                        Icons.verified_user,
                        color: Colors.deepPurple.shade300,
                      ),
                      title: Text("User ID"),
                      subtitle: Text(listAlbums[index].userId.toString())),
                  ListTile(
                    leading: Icon(Icons.supervised_user_circle,
                        color: Colors.deepPurple.shade300),
                    title: Text("ID"),
                    subtitle: Text(listAlbums[index].id.toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.text_fields,
                        color: Colors.deepPurple.shade300),
                    title: Text("Title"),
                    subtitle: Text(
                      listAlbums[index].title,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  positionTab == 1 || positionTab == 2
                      ? ListTile(
                          leading: Icon(Icons.text_fields,
                              color: Colors.deepPurple.shade300),
                          title: Text(
                            positionTab == 1 ? "Body" : "Completed",
                            textAlign: TextAlign.justify,
                          ),
                          subtitle: Text(positionTab == 1
                              ? listPosts[index].body
                              : listTodos[index].completed.toString()),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
