import 'package:avestan_test/Constants/constants.dart';
import 'package:avestan_test/Constants/utils.dart';
import 'package:avestan_test/UI/widgets/appBar.dart';
import 'package:avestan_test/UI/widgets/drawer.dart';
import 'package:avestan_test/UI/widgets/post_job_form.dart';
import 'package:avestan_test/UI/widgets/posted_jobs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController? _controller;
  ScrollController _scrollController = new ScrollController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // this creates the controller with 2 tabs
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  _setCurrentIndex(int index) {
    // if we're actually changing the index
    if (index != _currentIndex) {
      setState(() {
        // change the index
        _currentIndex = index;
      });
      // scroll the TabBar to the correct position (if we have a scrollable bar)
      _controller!.animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(
        row: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.menu_rounded,
                color: Color.fromRGBO(28, 79, 122, 1),
                size: 30,
              ),
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            ),
            Spacer(),
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNtaWx5JTIwZmFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Priya Sharma",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: mainColor),
            ),
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 18,
                color: mainColor5,
              ),
              onPressed: () {},
            ),
            Container(
              decoration: ShapeDecoration(
                  color: mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              child: IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      drawer: drawer(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _setCurrentIndex(0);
                      _controller!.animateTo(0);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      decoration: _currentIndex == 0
                          ? activeTabShapeDecoration()
                          : deactivatedTabShapeDecoration(),
                      child: Center(
                        child: Text("Post Jobs",
                            style: _currentIndex == 0
                                ? activeTabTextStyle()
                                : deactivatedTabTextStyle()),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _setCurrentIndex(1);
                      _controller!.animateTo(1);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      decoration: _currentIndex == 1
                          ? activeTabShapeDecoration()
                          : deactivatedTabShapeDecoration(),
                      child: Center(
                        child: Text("Posted Jobs",
                            style: _currentIndex == 1
                                ? activeTabTextStyle()
                                : deactivatedTabTextStyle()),
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                  child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  // our Tab Views
                  PostJob(),
                  PostedJobs()
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
