import 'package:flutter/material.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:urge/features/dashboard/views/member.dart';
import 'package:urge/features/dashboard/views/speaker.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChange);
    super.initState();
  }

  void _onTabChange() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBackgroundColor,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                _buildTabBar(),
                Expanded(
                    child: TabBarView(
                  controller: _tabController,
                  children: const [
                    Member(),
                    Speaker(),
                  ],
                ))
              ],
            )));
  }

  Widget _buildTabBar() {
    return Material(
      color: appBackgroundColor,
      child: TabBar(
        labelPadding: EdgeInsets.all(0),
        indicatorColor: appBackgroundColor,
        labelColor: logoColor,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: faintBlack,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2.0, // Set the thickness of the line
            color: logoColor, // Set the color of the line
          ),
        ),
        controller: _tabController,
        tabs: const [
          SizedBox(
            child: Tab(
              text: 'MEMBER',
            ),
          ),
          SizedBox(
            child: Tab(text: 'SPEAKER'),
          )
        ],
      ),
    );
  }
}
