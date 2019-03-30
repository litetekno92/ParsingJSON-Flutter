import 'package:flutter/material.dart';
import 'package:flutter_json/services/product_services.dart';
import 'package:flutter_json/services/photo_services.dart';
import 'package:flutter_json/services/address_services.dart';
import 'package:flutter_json/services/student_services.dart';
import 'package:flutter_json/services/shape_services.dart';
import 'package:flutter_json/services/bakery_services.dart';
import 'package:flutter_json/services/page_services.dart';
import 'package:flutter_json/services/post_services.dart';
import 'package:flutter_json/model/post_model.dart';

void main() {
  runApp(new MyApp());
//  loadProduct();
//  loadPhotos();
//  loadAddress();
//  loadStudent();
//  loadShape();
//  loadBakery();
//  loadPage();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: Home());
  }
}

class Home extends StatelessWidget {
  List<Post> posts = [];

  callAPI() {
    Post post = Post(body: 'Testing body body body', title: 'Flutter jam6');
    createPost(post).then((response) {
      if (response.statusCode > 200)
        print(response.body);
      else
        print(response.statusCode);
    }).catchError((error) {
      print('error : $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<List<Post>>(
            future: getAllPosts(),
            builder: (context, snapshot) {
              // callAPI();
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text("Error");
                }

                // return Text('Title from Post JSON : ${snapshot.data.title}');
                return createListView(context, snapshot);
              } else
                return CircularProgressIndicator();
            }));
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Post> values = snapshot.data;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            Container(
                constraints: BoxConstraints.expand(
                  height: Theme.of(context).textTheme.display1.fontSize * 1.1 +
                      200.0,
                ),
                alignment: Alignment.center,
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: new Text(values[index].title),
                        subtitle: new Text(values[index].body),
                      ),
                      new Divider(
                        height: 2.0,
                      ),
                      ButtonTheme.bar(
                        // make buttons use the appropriate styles for cards
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('Open'),
                              onPressed: () {/* ... */},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        );
      },
    );
  }
}
