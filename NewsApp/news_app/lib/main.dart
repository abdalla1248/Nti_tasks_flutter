import 'package:flutter/material.dart';
import 'package:news_app/feature/article/view/article_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NTI News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ArticleView(),
    );
  }
}
