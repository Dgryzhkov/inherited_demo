import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inherited Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Iherited Demo',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int get counterValue => _counter;

  void _incrementCounter() => setState(() => _counter++);
  void _decrementConter() => setState(() => _counter--);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inherited Widget'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          MyInheritedWidget(
            myState: this,
            child: AppRootWidget(),
          ),
        ],
      ),
    );
  }
}

class AppRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootWidgetState = MyInheritedWidget.of(context)!.myState;
    return Card(
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          Text(
            'Root Widget',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            '${rootWidgetState.counterValue}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[Counter(), Counter()]),
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final rootWidgetState = MyInheritedWidget.of(context)!.myState;
    return Card(
      margin: EdgeInsets.all(4.0).copyWith(bottom: 32.0),
      color: Colors.yellowAccent,
      child: Column(children: <Widget>[
        Text('Child Widget'),
        Text(
          '${rootWidgetState.counterValue}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        ButtonBar(
          children: <Widget>[
            IconButton(
              onPressed: () =>rootWidgetState._decrementConter(),
              icon: Icon(Icons.remove),
              color: Colors.red,
            ),
            IconButton(
              onPressed: () =>rootWidgetState._incrementCounter(),
              icon: Icon(Icons.add),
              color: Colors.green,
            )
          ],
        )
      ]),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final _MyHomePageState myState;

  MyInheritedWidget({Key, key, required Widget child, required this.myState})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return this.myState.counterValue != oldWidget.myState.counterValue;
  }

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}
