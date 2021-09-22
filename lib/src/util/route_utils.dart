import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/connector/core/dio_connector.dart';
import 'package:flutter_app/src/model/course/course_class_json.dart';
import 'package:flutter_app/src/model/course_table/course_table_json.dart';
import 'package:flutter_app/src/store/Model.dart';
import 'package:flutter_app/ui/pages/course_data/course_data_page.dart';
import 'package:flutter_app/ui/pages/course_data/screen/sub_page/course_announcement_detail_page.dart';
import 'package:flutter_app/ui/pages/course_data/screen/sub_page/course_announcement_detail_webapi_page.dart';
import 'package:flutter_app/ui/pages/course_data/screen/sub_page/course_branch_page.dart';
import 'package:flutter_app/ui/pages/course_data/screen/sub_page/course_branch_webapi_page.dart';
import 'package:flutter_app/ui/pages/course_data/screen/sub_page/course_folder_page.dart';
import 'package:flutter_app/ui/pages/course_data/screen/sub_page/course_folder_webapi_page.dart';
import 'package:flutter_app/ui/pages/course_detail/course_detail_page.dart';
import 'package:flutter_app/ui/pages/file_viewer/file_viewer_page.dart';
import 'package:flutter_app/ui/pages/log_console/log_console.dart';
import 'package:flutter_app/ui/pages/other/page/about_page.dart';
import 'package:flutter_app/ui/pages/other/page/contributors_page.dart';
import 'package:flutter_app/ui/pages/other/page/dev_page.dart';
import 'package:flutter_app/ui/pages/other/page/privacy_policy_page.dart';
import 'package:flutter_app/ui/pages/other/page/setting_page.dart';
import 'package:flutter_app/ui/pages/other/page/store_edit_page.dart';
import 'package:flutter_app/ui/pages/subsystem/sub_system_page.dart';
import 'package:flutter_app/ui/pages/web_view/web_view_page.dart';
import 'package:flutter_app/ui/screen/login_screen.dart';
import 'package:get/get.dart';

class RouteUtils {
  static Transition transition =
      (Platform.isAndroid) ? Transition.downToUp : Transition.cupertino;

  static Future toLoginScreen() async {
    return await Get.to(
      () => LoginScreen(),
      transition: transition,
    );
  }

  static Future toSubSystemPage(String title, String arg) async {
    return Get.to(
        () => SubSystemPage(
              title: title,
              arg: arg,
            ),
        transition: transition,
        preventDuplicates: false //必免重覆頁面時不載入
        );
  }

  static Future toDevPage() async {
    return await Get.to(
      () => DevPage(),
      transition: transition,
    );
  }

  static Future toFileViewerPage(String title, String path) async {
    return await Get.to(
        () => FileViewerPage(
              title: title,
              path: path,
            ),
        transition: transition);
  }

  static Future toCourseDataPage(CourseInfoJson courseInfo) async {
    return await Get.to(
      () => CourseDataPage(courseInfo),
      transition: transition,
    );
  }

  static Future toCourseFolderPage(
      CourseInfoJson courseInfo, dynamic value) async {
    if (Model.instance.getOtherSetting().useMoodleWebApi) {
      return await Get.to(() => CourseFolderWebApiPage(courseInfo, value));
    } else {
      return await Get.to(() => CourseFolderPage(courseInfo, value));
    }
  }

  static Future toCourseBranchPage(
      CourseInfoJson courseInfo, dynamic value) async {
    if (Model.instance.getOtherSetting().useMoodleWebApi) {
      return await Get.to(() => CourseBranchWebApiPage(courseInfo, value));
    } else {
      return await Get.to(() => CourseBranchPage(courseInfo, value));
    }
  }

  static Future toAnnouncementDetailPage(
      CourseInfoJson courseInfo, dynamic value) async {
    if (Model.instance.getOtherSetting().useMoodleWebApi) {
      return await Get.to(
          () => CourseAnnouncementDetailWebApiPage(courseInfo, value));
    } else {
      return await Get.to(
          () => CourseAnnouncementDetailPage(courseInfo, value));
    }
  }

  static Future toCourseDetailPage(
      SemesterJson semester, CourseInfoJson courseInfo) async {
    return await Get.to(
      () => CourseDetailPage(courseInfo, semester),
      transition: transition,
    );
  }

  static Future toPrivacyPolicyPage() async {
    return await Get.to(
      () => PrivacyPolicyPage(),
      transition: transition,
    );
  }

  static Future toContributorsPage() async {
    return await Get.to(
      () => ContributorsPage(),
      transition: transition,
    );
  }

  static Future toAboutPage() async {
    return await Get.to(
      () => AboutPage(),
      transition: transition,
    );
  }

  static Future toSettingPage(PageController controller) async {
    return await Get.to(
      () => SettingPage(controller),
      transition: transition,
    );
  }

  static Future toWebViewPage(String title, String url,
      {bool openWithExternalWebView = true,
      Function(Uri) onWebViewDownload}) async {
    return await Get.to(
      () => WebViewPage(
        title: title,
        url: Uri.parse(url),
        openWithExternalWebView: openWithExternalWebView,
        onWebViewDownload: onWebViewDownload,
      ),
      transition: transition,
    );
  }

  static Future toLogConsolePage() async {
    return await Get.to(
      () => LogConsole(dark: true),
      transition: transition,
    );
  }

  static Future toStoreEditPage() async {
    return await Get.to(
      () => StoreEditPage(),
      transition: transition,
    );
  }

  static Future toAliceInspectorPage() async {
    DioConnector.instance.alice.showInspector();
  }
}
