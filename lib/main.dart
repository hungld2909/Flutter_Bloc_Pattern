import 'package:Flutter_Bloc_Pattern/counter_bloc.dart';
import 'package:Flutter_Bloc_Pattern/counter_event.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }
  // void _decrementCounter(){
  //   setState(() {
  //     _counter--;
  //   });
  // }
  final _bloc = CounterBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: StreamBuilder(
                stream: _bloc.counter,
                initialData: 0,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'You have pushed the button this many times:',
                      ),
                      Text(
                        '${snapshot.data}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  );
                })),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: ()=> _bloc.CounterEventSink.add(IncrementEvent()),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            SizedBox(
              width: 20.0,
            ),
            FloatingActionButton(
              onPressed: ()=> _bloc.CounterEventSink.add(DecrementEvent()),
              tooltip: 'Increment',
              child: Icon(Icons.remove),
            ),
          ],
        ));
  }
  @override
  void dispose() {
    super.dispose();
  _bloc.dispose();
  }
}
