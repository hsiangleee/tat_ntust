import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/debug/log/log.dart';
import 'package:flutter_app/src/R.dart';
import 'package:flutter_app/src/file/my_downloader.dart';
import 'package:flutter_app/src/notifications/notifications.dart';
import 'package:flutter_app/src/providers/app_provider.dart';
import 'package:flutter_app/src/store/model.dart';
import 'package:flutter_app/src/util/analytics_utils.dart';
import 'package:flutter_app/src/util/language_utils.dart';
import 'package:flutter_app/src/util/remote_config_utils.dart';
import 'package:flutter_app/src/version/app_version.dart';
import 'package:flutter_app/ui/other/my_toast.dart';
import 'package:flutter_app/ui/pages/calendar/calendar_page.dart';
import 'package:flutter_app/ui/pages/course_table/course_table_page.dart';
import 'package:flutter_app/ui/pages/other/other_page.dart';
import 'package:flutter_app/ui/pages/score/score_page.dart';
import 'package:flutter_app/ui/pages/subsystem/sub_system_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with RouteAware {
  final _pageController = PageController();
  int _currentIndex = 0;
  int _closeAppCount = 0;
  List<Widget> _pageList = [];

  @override
  void initState() {
    appInit();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AnalyticsUtils.observer.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    AnalyticsUtils.observer.unsubscribe(this);
    super.dispose();
  }

  void appInit() async {
    R.set(context);
    await Model.instance.getInstance(); //一定要先getInstance()不然無法取得資料
    try {
      await RemoteConfigUtils.init();
      await initLanguage();
      Log.init();
      APPVersion.initAndCheck();
      initFlutterDownloader();
      initNotifications();
    } catch (e, stack) {
      Log.eWithStack(e.toString(), stack);
    }
    setState(() {
      _pageList = [];
      _pageList.add(CourseTablePage());
      _pageList
          .add(SubSystemPage(title: R.current.informationSystem, arg: null));
      _pageList.add(CalendarPage());
      _pageList.add(ScoreViewerPage());
      _pageList.add(OtherPage(_pageController));
    });
  }

  void initFlutterDownloader() async {
    await MyDownloader.init();
  }

  void initNotifications() async {
    await Notifications.instance.init();
  }

  Future<void> initLanguage() async {
    await LanguageUtils.init(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
        appProvider.navigatorKey = Get.key;
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: _buildPageView(),
            bottomNavigationBar: _buildBottomNavigationBar(),
          ),
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    var canPop = Navigator.of(context).canPop();
    //Log.d(canPop.toString());
    if (canPop) {
      Navigator.of(context).pop();
      _closeAppCount = 0;
    } else {
      _closeAppCount++;
      MyToast.show(R.current.closeOnce);
      Future.delayed(Duration(seconds: 2)).then((_) {
        _closeAppCount = 0;
      });
    }
    return (_closeAppCount >= 2);
  }

  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      children: _pageList,
      physics: NeverScrollableScrollPhysics(), // 禁止滑動
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: _onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            EvaIcons.clockOutline,
          ),
          label: R.current.titleCourse,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            EvaIcons.infoOutline,
          ),
          label: R.current.informationSystem,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            EvaIcons.calendarOutline,
          ),
          label: R.current.calendar,
        ),
        BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.bookOpenOutline,
            ),
            label: R.current.titleScore),
        BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.menu,
            ),
            label: R.current.titleOther),
      ],
    );
  }

  void _onPageChange(int index) {
    String screenName = _pageList[index].toString();
    AnalyticsUtils.setScreenName(screenName);
  }

  void _onTap(int index) {
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      _onPageChange(_currentIndex);
    });
  }
}
