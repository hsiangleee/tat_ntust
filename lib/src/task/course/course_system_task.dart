import 'package:flutter_app/src/R.dart';
import 'package:flutter_app/src/connector/course_connector.dart';
import 'package:flutter_app/src/task/ntust/ntust_task.dart';
import 'package:flutter_app/src/task/task.dart';
import 'package:flutter_app/ui/other/error_dialog.dart';

class CourseSystemTask<T> extends NTUSTTask<T> {
  CourseSystemTask(String name) : super(name);
  static bool isLogin = false;

  @override
  Future<TaskStatus> execute() async {
    TaskStatus status = await super.execute();
    if (isLogin) return TaskStatus.success;
    name = "CourseSystemTask " + name;
    if (status == TaskStatus.success) {
      isLogin = true;
      super.onStart(R.current.loginCourse);
      CourseConnectorStatus value = await CourseConnector.login();
      super.onEnd();
      if (value != CourseConnectorStatus.loginSuccess) {
        return await onError(R.current.loginCourseError);
      }
    }
    return status;
  }

  @override
  Future<TaskStatus> onError(String message) {
    isLogin = false;
    return super.onError(message);
  }

  @override
  Future<TaskStatus> onErrorParameter(ErrorDialogParameter parameter) {
    isLogin = false;
    return super.onErrorParameter(parameter);
  }
}
