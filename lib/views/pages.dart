import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../style/AppColors.dart';
import '../views/home_screen.dart';
import '../views/profile_screen.dart';

// ignore: must_be_immutable
class PagesScreen extends StatefulWidget {
  dynamic currentIndex;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget currentPage = HomeScreen();

  PagesScreen({
    Key key,
    this.currentIndex,
  }) : super(key: key);

  @override
  _PagesScreenState createState() => _PagesScreenState();
}

class _PagesScreenState extends State<PagesScreen> {
  final HomeController _pagesController = Get.put(HomeController());

  initState() {
    super.initState();

    _selectTab(widget.currentIndex);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentIndex = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = HomeScreen();
          break;
        case 1:
          //  widget.currentPage = ProfileScreen();
          break;

        case 2:
          showPostOptions();
          break;

        case 3:
          //    widget.currentPage = SavedView();
          break;

        case 4:
          widget.currentPage = ProfileScreen();

          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      // drawer: NavDrawerWidget(
      //     // key: scaffoldKey,
      //     ),

      // floatingActionButton: new FloatingActionButton(
      //   backgroundColor: AppColors.themeColorLight,
      //   onPressed: () {
      //     showPostOptions();
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.black54,
      //   ),
      // ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.themeColor,
          iconSize: 22,
          elevation: 0,
          backgroundColor: Colors.grey[200],
          selectedIconTheme: IconThemeData(size: 28),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(.4),
          currentIndex: widget.currentIndex,
          onTap: (int i) {
            this._selectTab(i);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 38,
                height: 38,
                child: Icon(Icons.add),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.notifications_none),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_sharp),
              label: "",
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: widget.currentPage,
    );
  }

  showPostOptions() {
    Get.snackbar("", "",
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        borderRadius: 4.0,
        duration: Duration(hours: 1),
        titleText: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _pagesController.pickVideoFromGallery();
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/video.svg",
                    width: 56,
                    height: 56,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    "Video",
                    style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _pagesController.createTextPost();
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/text.svg",
                    width: 56,
                    height: 56,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    "Text",
                    style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _pagesController.pickImageFromGallery();
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/image.svg",
                    width: 56,
                    height: 56,
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    "Photo",
                    style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  )
                ],
              ),
            )
          ],
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey.shade200);
  }
}
