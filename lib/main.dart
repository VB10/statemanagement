import 'package:flutter/material.dart';

import 'bloc/bloc_cats_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocCatsView(),
    );
  }
}
