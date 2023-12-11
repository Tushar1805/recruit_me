import 'package:avestan_test/Constants/constants.dart';
import 'package:avestan_test/Constants/utils.dart';
import 'package:avestan_test/UI/widgets/home_page_app_bar.dart';
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

  // this will control the animation when a button changes from an off state to an on state
  AnimationController? _animationControllerOn;

  // this will control the animation when a button changes from an on state to an off state
  AnimationController? _animationControllerOff;

  // this will give the background color values of a button when it changes to an on state
  Animation? _colorTweenBackgroundOn;
  Animation? _colorTweenBackgroundOff;

  // this will give the foreground color values of a button when it changes to an on state
  Animation? _colorTweenForegroundOn;
  Animation? _colorTweenForegroundOff;

  // when swiping, the _controller.index value only changes after the animation, therefore, we need this to trigger the animations and save the current index
  int? _currentIndex = 0;

  // saves the previous active tab
  int _prevControllerIndex = 0;

  // saves the value of the tab animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
  double _aniValue = 0.0;

  // saves the previous value of the tab animation. It's used to figure the direction of the animation
  double _prevAniValue = 0.0;

  // active button's foreground color
  Color _foregroundOn = Colors.white;
  Color _foregroundOff = mainColor;

  // active button's background color
  Color _backgroundOn = mainColor;
  Color _backgroundOff = Colors.white;

  // resist if the the button was tapped
  bool _buttonTap = false;

  // scroll controller for the TabBar
  ScrollController _scrollController = new ScrollController();

  // this will save the keys for each Tab in the Tab Bar, so we can retrieve their position and size for the scroll controller
  List _keys = [];

  List _widgets = [
    PostJob(),
    PostedJobs(),
  ];

  @override
  void initState() {
    super.initState();

    for (int index = 0; index < _widgets.length; index++) {
      // create a GlobalKey for each Tab
      _keys.add(new GlobalKey());
    }

    // this creates the controller with 2 tabs
    _controller = TabController(vsync: this, length: 2);
    // this will execute the function every time there's a swipe animation
    _controller!.animation!.addListener(_handleTabAnimation);
    // this will execute the function every time the _controller.index value changes
    _controller!.addListener(_handleTabChange);

    _animationControllerOff =
        AnimationController(vsync: this, duration: Duration(milliseconds: 50));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOff!.value = 1.0;
    _colorTweenBackgroundOff =
        ColorTween(begin: _backgroundOn, end: _backgroundOff)
            .animate(_animationControllerOff!);
    _colorTweenForegroundOff =
        ColorTween(begin: _foregroundOn, end: _foregroundOff)
            .animate(_animationControllerOff!);

    _animationControllerOn =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOn!.value = 1.0;
    _colorTweenBackgroundOn =
        ColorTween(begin: _backgroundOff, end: _backgroundOn)
            .animate(_animationControllerOn!);
    _colorTweenForegroundOn =
        ColorTween(begin: _foregroundOff, end: _foregroundOn)
            .animate(_animationControllerOn!);
  }

  // runs during the switching tabs animation
  _handleTabAnimation() {
    // gets the value of the animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
    _aniValue = _controller!.animation!.value;

    // if the button wasn't pressed, which means the user is swiping, and the amount swipped is less than 1 (this means that we're swiping through neighbor Tab Views)
    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      // set the current tab index
      _setCurrentIndex(_aniValue.round());
    }

    // save the previous Animation Value
    _prevAniValue = _aniValue;
  }

  // runs when the displayed tab changes
  _handleTabChange() {
    // if a button was tapped, change the current index
    if (_buttonTap) _setCurrentIndex(_controller!.index);

    // this resets the button tap
    if ((_controller!.index == _prevControllerIndex) ||
        (_controller!.index == _aniValue.round())) _buttonTap = false;

    // save the previous controller index
    _prevControllerIndex = _controller!.index;
  }

  _setCurrentIndex(int index) {
    // if we're actually changing the index
    if (index != _currentIndex) {
      setState(() {
        // change the index
        _currentIndex = index;
      });
      // trigger the button animation
      _triggerAnimation();
      // scroll the TabBar to the correct position (if we have a scrollable bar)
      _scrollTo(index);
    }
  }

  _triggerAnimation() {
    // reset the animations so they're ready to go
    _animationControllerOn!.reset();
    _animationControllerOff!.reset();

    // run the animations!
    _animationControllerOn!.forward();
    _animationControllerOff!.forward();
  }

  _scrollTo(int index) {
    // get the screen width. This is used to check if we have an element off screen
    double screenWidth = MediaQuery.of(context).size.width;

    // get the button we want to scroll to
    RenderBox renderBox = _keys[index].currentContext!.findRenderObject();
    // get its size
    double size = renderBox.size.width;
    // and position
    double position = renderBox.localToGlobal(Offset.zero).dx;

    // this is how much the button is away from the center of the screen and how much we must scroll to get it into place
    double offset = (position + size / 2) - screenWidth / 2;

    // if the button is to the left of the middle
    if (offset < 0) {
      // get the first button
      renderBox = _keys[0].currentContext!.findRenderObject();
      // get the position of the first button of the TabBar
      position = renderBox.localToGlobal(Offset.zero).dx;

      // if the offset pulls the first button away from the left side, we limit that movement so the first button is stuck to the left side
      if (position > offset) offset = position;
    } else {
      // if the button is to the right of the middle

      // get the last button
      renderBox = _keys[_widgets.length - 1].currentContext!.findRenderObject();
      // get its position
      position = renderBox.localToGlobal(Offset.zero).dx;
      // and size
      size = renderBox.size.width;

      // if the last button doesn't reach the right side, use it's right side as the limit of the screen for the TabBar
      if (position + size < screenWidth) screenWidth = position + size;

      // if the offset pulls the last button away from the right side limit, we reduce that movement so the last button is stuck to the right side limit
      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }

    // scroll the calculated amount
    _scrollController.animateTo(offset + _scrollController.offset,
        duration: new Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  _getBackgroundColor(int index) {
    if (index == _currentIndex) {
      // if it's active button
      return _colorTweenBackgroundOn!.value;
    } else if (index == _prevControllerIndex) {
      // if it's the previous active button
      return _colorTweenBackgroundOff!.value;
    } else {
      // if the button is inactive
      return _backgroundOff;
    }
  }

  _getForegroundColor(int index) {
    // the same as the above
    if (index == _currentIndex) {
      return _colorTweenForegroundOn!.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenForegroundOff!.value;
    } else {
      return _foregroundOff;
    }
  }

  _getForeGroundText(index) {
    if (index == 0) {
      return "Post Jobs";
    } else {
      return "Posted Jobs";
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              height: MediaQuery.of(context).size.height * 0.1,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                controller: _scrollController,
                itemCount: _widgets.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width * 0.45,
                    key: _keys[index],
                    child: ButtonTheme(
                      child: AnimatedBuilder(
                        animation: _colorTweenBackgroundOn!,
                        builder: (context, child) => FlatButton(
                          color: _getBackgroundColor(index),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50, color: Color(0xFFD2D2D2)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                _buttonTap = true;
                                // trigger the controller to change between Tab Views
                                _controller!.animateTo(index);
                                // set the current index
                                _setCurrentIndex(index);
                                // scroll to the tapped button (needed if we tap the active button and it's not on its position)
                                _scrollTo(index);
                              },
                            );
                          },
                          child: Center(
                            child: Text(
                              _getForeGroundText(index),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: _getForegroundColor(index),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    // our Tab Views
                    PostJob(),
                    PostedJobs()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
