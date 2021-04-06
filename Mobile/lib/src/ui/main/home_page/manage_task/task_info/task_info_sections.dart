part of 'task_info_page.dart';

Widget _takeTaskTitle(String title, int priority) {
  var priorityString = '';
  var priorityBg = Colors.white;
  if (priority == TaskPriority.LOW) {
    priorityString = 'low';
    priorityBg = PriorityColor.low;
  } else if (priority == TaskPriority.MEDIUM) {
    priorityString = 'medium';
    priorityBg = PriorityColor.medium;
  } else if (priority == TaskPriority.HIGHT) {
    priorityString = 'hight';
    priorityBg = PriorityColor.hight;
  }

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      Card(
        color: priorityBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            priorityString,
            style: TextStyle(color: Colors.white),
          ),
        ),
      )
    ],
  );
}

Widget _takeUser(UserView createdBy, UserView assignee) {
  final currentUserId = AuthService().currentUserId;
  final textStyle1 = TextStyle(color: Color(0xFF222222), fontSize: 10);
  final textStyle2 = TextStyle(
      color: Color(0xFF222222), fontSize: 15, fontWeight: FontWeight.bold);
  return Column(
    children: [
      Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              'created by',
              style: textStyle1,
            ),
          ),
          createdBy == null
              ? ''
              : createdBy.id == currentUserId
                  ? _spanName('YOU')
                  : createdBy.fullname == null
                      ? _spanName('No Name')
                      : Text(
                          createdBy.fullname,
                          style: textStyle2,
                        ),
        ],
      ),
      Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              'assignee',
              style: textStyle1,
            ),
          ),
          assignee == null
              ? _spanName('Không thuộc về ai')
              : assignee.id == currentUserId
                  ? _spanName('YOU')
                  : assignee.fullname == null
                      ? _spanName('No Name')
                      : Text(
                          assignee.fullname,
                          style: textStyle2,
                        ),
        ],
      )
    ],
  );
}

Widget _spanName(String name) {
  return Card(
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Text(
        name,
        style: TextStyle(color: Color(0xFF222222), fontSize: 12),
      ),
    ),
  );
}

Widget _takeStatus(String createdAt, String status) {
  final textStyle1 = TextStyle(color: Color(0xFF222222), fontSize: 10);
  final textStyle2 = TextStyle(color: Color(0xFFFFFFFF), fontSize: 12);
  var statusBg = TaskColor.taskOpenBg;
  var statusColor = TaskColor.taskOpenColor;
  if (status == TaskStatus.Open || status == TaskStatus.ReOpen) {
    statusBg = TaskColor.taskOpenBg;
    statusColor = TaskColor.taskOpenColor;
  } else if (status == TaskStatus.Open || status == TaskStatus.ReSolved) {
    statusBg = TaskColor.taskResolvedBg;
    statusColor = TaskColor.taskResolvedColor;
  } else if (status == TaskStatus.Open || status == TaskStatus.Closed) {
    statusBg = TaskColor.taskClosedBg;
    statusColor = TaskColor.taskClosedColor;
  }

  return Column(
    children: [
      Text(createdAt.split(' ')[0] +
          '   ' +
          createdAt.split(' ')[1].split('.')[0]),
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        color: statusBg,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text(
            status,
            style: textStyle2,
          ),
        ),
      )
    ],
  );
}

Widget _takeTaskContent(String content, double width) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Card(
        elevation: 10,
        child: ClipPath(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                content,
                style: TextStyle(color: _cardColor),
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.green, width: 5),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class takeTaskProgress extends StatefulWidget {
  String _currentUserId = AuthService().currentUserId;

  TaskInfoData _task;
  takeTaskProgress(this._task);

  @override
  _takeTaskProgressState createState() => _takeTaskProgressState();

  int getProgressValue() {
    return _task.process.toInt();
  }
}

class _takeTaskProgressState extends State<takeTaskProgress> {
  @override
  Widget build(BuildContext context) {
    if (widget._task == null) return Container();

    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      widthFactor: 0.5,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(1),
            child: Slider(
              min: 0,
              max: 100,
              value: widget._task.process == null
                  ? 0
                  : widget._task.process.toDouble(),
              divisions: 5,
              label: widget._task.process.toString() + "%",
              onChanged: widget._task.assignee != null && widget._currentUserId == widget._task.assignee.id &&
                          widget._task.status == TaskStatus.Open ||
                      widget._task.status == TaskStatus.ReOpen
                  ? (newValue) {
                      setState(() {
                        widget._task.process = newValue.toInt();
                      });
                    }
                  : null,
            ),
          ),
          Text(widget._task.process.toString() + "%")
        ],
      ),
    );
  }
}
