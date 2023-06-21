import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:urge/common/helpers/custom_svg.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:urge/features/dashboard/views/member.dart';
import 'package:urge/features/home/views/home.dart';
import 'package:urge/features/events/views/events.dart';
import 'package:urge/features/search/views/search.dart';
import 'package:urge/features/dashboard/views/dashboard.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int pageIndex = 0;

  List<Widget> pages = const [Home(), Events(), Search(), Dashboard()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        currentIndex: pageIndex,
        onTap: (val) {
          setState(() {
            pageIndex = val;
          });
        },
        selectedItemColor: logoColor,
        unselectedItemColor: Colors.white,
        backgroundColor: appBackgroundColor,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            label: 'HOME',
            icon: Container(
                width: 42,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 3,
                      color: pageIndex == 0 ? logoColor : appBackgroundColor,
                    ),
                  ),
                ),
                child: CustomSvg(
                  assetName: 'assets/images/home_icon.svg',
                  height: 20,
                  width: 20,
                  color: pageIndex == 0 ? logoColor : Colors.white,
                )),
          ),
          BottomNavigationBarItem(
            label: 'EVENTS',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 3,
                    color: pageIndex == 1 ? logoColor : appBackgroundColor,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: CustomSvg(
                  assetName: 'assets/images/events_icon.svg',
                  height: 20,
                  width: 20,
                  color: pageIndex == 1 ? logoColor : Colors.white,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'SEARCH',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 3,
                    color: pageIndex == 2 ? logoColor : appBackgroundColor,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: CustomSvg(
                  assetName: 'assets/images/search_icon.svg',
                  height: 20,
                  width: 20,
                  color: pageIndex == 2 ? logoColor : Colors.white,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'DASHBOARD',
            icon: Container(
              width: 42,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 3,
                    color: pageIndex == 3 ? logoColor : appBackgroundColor,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: CustomSvg(
                  assetName: 'assets/images/dashboard_icon.svg',
                  height: 20,
                  width: 20,
                  color: pageIndex == 3 ? logoColor : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
