import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks_tutorial/timer_hook.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer _timer;
  int _number = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _number = timer.tick;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Center(
        child: Text(
          _number.toString(),
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class HomePageHook extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _numberNotifier = useState(0);

    useEffect(() {
      final timer = Timer.periodic(Duration(seconds: 1), (time) {
        _numberNotifier.value = time.tick;
      });

      return timer.cancel;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Center(
        child: Text(_numberNotifier.value.toString()),
      ),
    );
  }
}

class HomePageCustomHook extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final number = useInfiniteTimer();

    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Center(
        child: Text(number.toString()),
      ),
    );
  }
}

class HomePageCustomHook2 extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final number = useInfiniteTimer();
    return Text(number.toString());
  }
}
