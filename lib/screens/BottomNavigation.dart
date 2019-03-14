import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tag_me/screens/Dashboard.dart';
import 'package:tag_me/screens/Categories.dart';
import 'package:tag_me/screens/Profile.dart';

class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigaitonWidgetState createState() => _BottomNavigaitonWidgetState();
}

class _BottomNavigaitonWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;
  final List<Widget> _widgets = [
    Dashboard(),
    Categories(title: "Categories"),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: _onTabTapped, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            backgroundColor: color,
            icon: Icon(FontAwesomeIcons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            backgroundColor: color,
            icon: Icon(FontAwesomeIcons.list),
            title: new Text('Categories'),
          ),
          BottomNavigationBarItem(
              backgroundColor: color,
              icon: Icon(FontAwesomeIcons.user),
              title: Text('Profile')),
        ],
      ),
      body: _widgets[_currentIndex],
    );
  }

  _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

// class Test extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Center(child: Text("Test")),
//           Container(
//               child: Image.asset(
//             'assets/test.png',
//             fit: BoxFit.fill,
//             height: 200.0,
//           )),
//           Center(child: Text("Test")),
//         ],
//       ),
//     );
//   }
// }
