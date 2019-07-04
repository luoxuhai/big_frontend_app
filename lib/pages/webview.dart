import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

class DocDetilPage extends StatefulWidget {
  @override
  _DocDetilPageState createState() => _DocDetilPageState();
}

class _DocDetilPageState extends State<DocDetilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: InAppWebView(
        initialUrl: 'https://www.lodashjs.com/',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.star),
        ),
      ),
    );
  }
}
