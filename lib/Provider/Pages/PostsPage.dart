import 'dart:js';

import 'package:example/Api/Models/Post.dart';

import 'package:example/main.dart';
import 'package:provider/provider.dart';
import 'package:example/Provider/Models/PostsModel.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: MyApp.BuildAppBar(context), drawer: MyApp.BuildDrawer(context), body: PostsGrid());
  }
}

class PostsGrid extends StatelessWidget {
  PostsGrid({Key? key}) : super(key: key);
  Future<void> _selectDate(BuildContext context, PostsModel postsModel) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null) {
      postsModel.GetByDateTime(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    var post = context.watch<PostsModel>();
    // TODO: implement build
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: RaisedButton(
          onPressed: () => _selectDate(context, post),
          child: Text('Select date'),
        ),
      ),
      Container(
          height: 25,
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.red),
          )),
          child: TextField(
            decoration: new InputDecoration.collapsed(hintText: 'Enter Name-Surname of Therapist'),
            keyboardType: TextInputType.text,
            onSubmitted: (String str) {
              post.GetByNameSurname(str);
            },
          )),
      Container(
          height: (MediaQuery.of(context).size.height / 4) * 3,
          child: FutureBuilder(
              future: post.posts,
              builder: (BuildContext bcontext, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Post.PostCard(snapshot.data[index], context);
                      });
                }
              }))
    ]);
  }
}
