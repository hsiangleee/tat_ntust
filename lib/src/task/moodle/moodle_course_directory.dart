import 'package:flutter_app/src/R.dart';
import 'package:flutter_app/src/connector/moodle_connector.dart';

import '../task.dart';
import 'moodle_task.dart';

class MoodleCourseDirectoryTask
    extends MoodleTask<List<MoodleCourseDirectoryInfo>> {
  final String id;

  MoodleCourseDirectoryTask(this.id) : super("MoodleCourseDirectoryTask");

  @override
  Future<TaskStatus> execute() async {
    TaskStatus status = await super.execute();
    if (status == TaskStatus.Success) {
      List<MoodleCourseDirectoryInfo> value;
      super.onStart(R.current.getMoodleCourseDirectory);
      value = await MoodleConnector.getCourseDirectory(id);
      super.onEnd();
      if (value != null && value.length != 0) {
        result = value;
        return TaskStatus.Success;
      } else {
        return await super.onError(R.current.getMoodleCourseDirectoryError);
      }
    }
    return status;
  }
}