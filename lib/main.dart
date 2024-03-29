import 'package:binary_music_tools/blocs/brew_db/bloc.dart';
import 'package:binary_music_tools/pages/brew_list/brew_list_page.dart';
import 'package:binary_music_tools/pages/calculator/calculator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/debug_bloc_delegate.dart';

void main() {
  Bloc.observer = DebugBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BrewDbBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Brewers Tools'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    Text('Homepage without content'),
    BrewListPage(),
    CalculatorPage(onSave: () => {}),
  ];

  @override
  void initState() {
    super.initState();
    context.bloc<BrewDbBloc>().add(GetBrewList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: Colors.green[900],
      ),
      backgroundColor: Colors.green[900],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green[900],
        unselectedItemColor: Colors.white30,
        selectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.format_list_bulleted),
            title: new Text('Biere'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_usage),
            title: Text('Rechner'),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: BlocListener<BrewDbBloc, BrewDbState>(
          listener: (BuildContext context, BrewDbState state) {
            if (state is SaveBrewSuccess || state is DeleteBrewSuccess) {
              context.bloc<BrewDbBloc>().add(GetBrewList());
            }
          },
          child: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
      ),
    );
  }
}
