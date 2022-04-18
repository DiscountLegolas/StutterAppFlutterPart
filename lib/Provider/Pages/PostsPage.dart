import 'dart:js';

import 'package:example/Api/Models/Post.dart';
import 'package:flutter/cupertino.dart';
import 'package:example/main.dart';
import 'package:provider/provider.dart';
import 'package:example/Provider/Models/PostsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Kekemelik Therapist App"),
        ),
        drawer: MyApp.BuildDrawer(context),
        body: PostsGrid());
  }
}

class PostsGrid extends StatelessWidget {
  PostsGrid({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var post = context.watch<PostsModel>();
    // TODO: implement build
    return Column(children: <Widget>[
      Container(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              post.GetByDateTime(newDateTime);
            },
          )),
      TextField(
        keyboardType: TextInputType.text,
        onSubmitted: (String str) {
          post.GetByNameSurname(str);
        },
      ),
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
