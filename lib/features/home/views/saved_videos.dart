import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/features/auth/controller/auth_controller.dart';
import 'package:urge/features/events/controller/event_controller.dart';
import 'package:urge/features/home/controller/home_controller.dart';
import 'package:urge/features/home/views/home.dart';
import 'package:urge/features/home/views/saved_events.dart';
import 'package:urge/features/home/views/videos.dart';
import 'package:urge/features/profile/views/profile.dart';

class SavedVideos extends StatefulWidget {
  const SavedVideos({super.key});

  @override
  State<SavedVideos> createState() => _SavedVideosState();
}

class _SavedVideosState extends State<SavedVideos>
    with SingleTickerProviderStateMixin {
  final HomeController _homeController = Get.put(HomeController());
  final AuthController _authController = Get.put(AuthController());
  final EventController _eventController = Get.put(EventController());


  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authController.getProfile();
      _homeController.getSavedVideoItems();
      _eventController.getSavedEventItems();

    });
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
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            //Navigator.pop(context);
           // Get.off(()=> const Home());
            Get.back();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Saved',
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800)),
            Row(
              children: [
                const SizedBox(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const Profile());
                  },
                  child: CachedNetworkImage(
                    imageUrl: _authController
                        .profileModel.profilePicture ==
                        null ||
                        _authController
                            .profileModel.profilePicture ==
                            ''
                        ? "https://pixabay.com/vectors/blank-profile-picture-mystery-man-973460/"
                        : _authController.profileModel.profilePicture!,
                    placeholder: (context, url) =>
                    const Center(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.person,
                      size: 35,
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      backgroundColor: appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            _buildTabBar(),
            Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children: const [Videos(), SavedEvents()]))
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        color: chipColor,
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          unselectedLabelStyle: Theme.of(context).textTheme.bodyLarge,
          labelStyle: Theme.of(context).textTheme.bodyLarge,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: logoColor,
            borderRadius: BorderRadius.circular(30.0),
          ),
          controller: _tabController,
          tabs: const [
            SizedBox(
              height: 40,
              child: Tab(
                text: 'VIDEOS',
              ),
            ),
            SizedBox(
              height: 40,
              child: Tab(text: 'EVENTS'),
            )
          ],
        ),
      ),
    );
  }
}
