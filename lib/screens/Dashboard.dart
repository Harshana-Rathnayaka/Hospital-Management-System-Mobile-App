import 'package:flutter/material.dart';
import 'package:hospital_management_system/constants/colors.dart';
import 'package:hospital_management_system/widgets/DashboardTiles.dart';
import 'package:hospital_management_system/widgets/ManagementOptions.dart';

enum Page { dashboard, manage }

class Dashboard extends StatefulWidget {
  final String name;

  Dashboard({this.name});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Page _selectedPage = Page.dashboard;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
          child: Scaffold(
        // appBar: AppBar(
        //   title: Row(
        //     children: <Widget>[
        //       Expanded(
        //           child: FlatButton.icon(
        //               onPressed: () {
        //                 setState(() => _selectedPage = Page.dashboard);
        //               },
        //               icon: Icon(
        //                 Icons.dashboard,
        //                 color: _selectedPage == Page.dashboard
        //                     ? primaryColor
        //                     : colorGrey,
        //               ),
        //               label: Text('Dashboard'))),
        //       Expanded(
        //         child: FlatButton.icon(
        //             onPressed: () {
        //               setState(() => _selectedPage = Page.manage);
        //             },
        //             icon: Icon(
        //               Icons.sort,
        //               color:
        //                   _selectedPage == Page.manage ? primaryColor : colorGrey,
        //             ),
        //             label: Text('Manage')),
        //       ),
        //     ],
        //   ),
        //   elevation: 0.0,
        //   backgroundColor: appBarColor,
        // ),
        body: _loadScreen(_selectedPage),
        backgroundColor: backgroundColor,
      ),
    );
  }

  Widget _loadScreen(page) {
    switch (_selectedPage) {
      case Page.dashboard:
        return DashboardTiles(username: widget.name);
        break;
      case Page.manage:
        return ManagementOptions();
        break;
      default:
        return Container();
    }
  }
}
