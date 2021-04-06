import 'dart:async';

import 'package:Mobile/src/models/response/home/list_request_data.dart';
import 'package:Mobile/src/models/response/home/list_request_data_item.dart';
import 'package:Mobile/src/services/request_service.dart';
import 'package:Mobile/src/ui/login/login_page.dart';
import 'package:Mobile/src/utils/constants.dart';
import 'package:Mobile/src/utils/error.dart';
import 'package:Mobile/src/utils/format.dart';
import 'package:Mobile/src/utils/mcolors.dart';
import 'package:flutter/material.dart';

class ManageRequestPage extends StatefulWidget {
  @override
  _ManageRequestPageState createState() => _ManageRequestPageState();
}

class _ManageRequestPageState extends State<ManageRequestPage>
    with TickerProviderStateMixin {
  Future<ListRequestData> _listRequestDataFurture;
  RequestService _requestService;
  TabController _tabController;

  @override
  void initState() {
    _requestService = RequestService();
    _listRequestDataFurture = _requestService.loadAllRequest();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRequestModal,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      appBar: AppBar(
        actions: [
          FlatButton(
            textColor: Colors.white,
            child: Icon(Icons.refresh),
            onPressed: _onRefresh,
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: _listRequestDataFurture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return AlertDialog(content: CircularProgressIndicator());
              } else {
                if (snapshot.hasError &&
                    snapshot.error.runtimeType.toString() ==
                        (UnauthorizedException).toString()) {
                  @override
                  void run() {
                    scheduleMicrotask(() {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    });
                  }

                  run();
                } else if (snapshot.hasData) {
                  return ListRequest(
                      snapshot.data, MediaQuery.of(context).size.height);
                }
              }
              return AlertDialog(content: Text(snapshot.error.toString()));
            },
          ),
        ),
      ),
    );
  }

  Widget ListRequest(ListRequestData data, double height) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 50,
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                25.0,
              ),
              color: Colors.green,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                text: 'Waiting',
              ),
              Tab(
                text: 'More',
              )
            ],
          ),
        ),
        Container(
          height: height - 70,
          child: TabBarView(
            controller: _tabController,
            children: [
              TabTypeRequest(data.items
                  .where((x) => x.status == RequestStatus.WAITING)
                  .toList()),
              TabTypeRequest(data.items
                  .where((x) =>
                      x.status == RequestStatus.CANCELED ||
                      x.status == RequestStatus.APPROVED)
                  .toList()),
            ],
          ),
        )
      ],
    );
  }

  Widget TabTypeRequest(List<ListRequestDataItem> data) {
    return ListView(
      children: data
          .map((item) => InkWell(
                onTap: () {
                  if (item.status == RequestStatus.WAITING)
                    _showEditDialog(item);
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: _takeRequestCardBg(item.status),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          _takeRequestTypeCircle(item.type),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: _takeDayOffRequestInfo(
                                item.fromDate,
                                item.toDate,
                                _takeRequestCardColor(item.status)),
                          )
                        ],
                      ),
                    )),
              ))
          .toList(),
    );
  }

  Color _takeRequestCardBg(String status) {
    return status == RequestStatus.APPROVED
        ? RequestColor.requestAprovedBg
        : status == RequestStatus.WAITING
            ? RequestColor.requestWaitingBg
            : RequestColor.requestCanceledBg;
  }

  Color _takeRequestCardColor(String status) {
    return status == RequestStatus.APPROVED
        ? RequestColor.requestAprovedColor
        : status == RequestStatus.WAITING
            ? RequestColor.requestWaitingColor
            : RequestColor.requestCanceledColor;
  }

  Widget _takeRequestTypeCircle(String type) {
    var _color = Colors.white;
    var _background = Colors.white;
    var _text = '';
    if (type == RequestType.OTRequest) {
      _background = RequestColor.circleTypeOTRequest;
      _text = 'OT';
    } else if (type == RequestType.DayOffRequest) {
      _background = RequestColor.circleTypeDayOffRequest;
      _text = 'Off';
    }

    return CircleAvatar(
      backgroundColor: _background,
      child: Text(
        _text,
        style: TextStyle(color: _color),
      ),
    );
  }

  Widget _takeDayOffRequestInfo(String fromDate, String toDate, Color color) {
    var _text = '';
    if (fromDate != null) {
      _text += fromDate;
    }
    if (toDate != null) {
      _text += ' - ' + toDate;
    }
    return Text(
      _text,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }

  void _showEditDialog(ListRequestDataItem item) {
    showDialog(context: context, builder: (context) => _takeEditDialog(item));
  }

  Widget _takeEditDialog(ListRequestDataItem item) {
    Color bg = Colors.white;
    Color color = Colors.white;
    if (item.type == RequestType.DayOffRequest) {
      bg = RequestColor.circleTypeDayOffRequest;
    } else if (item.type == RequestType.OTRequest) {
      bg = RequestColor.circleTypeOTRequest;
    }

    String date = item.fromDate;
    if (item.toDate != null && item.toDate != item.fromDate) {
      date += " - " + item.toDate;
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              color: bg,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  item.type,
                  style: TextStyle(color: color),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(date),
            ),
            item.type == RequestType.OTRequest
                ? Container(child: Text('OT: ' + item.timeOT.toString() + ' h'))
                : Container(),
            RaisedButton.icon(
              icon: Icon(Icons.delete_outline_rounded),
              label: Text('Cancel request'),
              onPressed: () {
                _showDialogDelete(context, item);
              },
            )
          ],
        ),
      ),
    );
  }

  void _showDialogDelete(BuildContext context, ListRequestDataItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cancel this request?"),
        actions: [
          FlatButton(
            child: Text("No"),
            onPressed: () {
              _onCancelDelete(context);
            },
          ),
          FlatButton(
            child: Text("Yes"),
            onPressed: () {
              _onDelete(context, item);
            },
          ),
        ],
      ),
    );
  }

  void _onCancelDelete(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> _onDelete(BuildContext context, ListRequestDataItem item) async {
    bool isSuccess = false;
    if (item.type == RequestType.DayOffRequest) {
      isSuccess = await _requestService.deleteDayOffRequest(item.requestId);
    } else {
      isSuccess = await _requestService.deleteOTRequest(item.requestId);
    }
    if (isSuccess) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Success'),
              Icon(
                Icons.check_circle_outline_rounded,
                color: MColors.success,
              )
            ],
          ),
        ),
      ).then((v) {
        _onRefresh();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Failed'),
              Icon(
                Icons.warning_rounded,
                color: MColors.danger,
              )
            ],
          ),
        ),
      ).then((v) {
        _onRefresh();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    }
  }

  Future<void> _onRefresh() async {
    ListRequestData data = await _requestService.loadAllRequest();
    setState(() {
      _listRequestDataFurture = Future.value(data);
    });
  }

  void _showAddRequestModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: _takeAddRequestForm(_onRefresh),
      ),
    );
  }
}

class _takeAddRequestForm extends StatefulWidget {
  Future<void> Function() _onRefresh;
  _takeAddRequestForm(this._onRefresh);
  @override
  _takeAddRequestFormState createState() => _takeAddRequestFormState();
}

class _takeAddRequestFormState extends State<_takeAddRequestForm> {
  String dropdownValue = RequestType.OTRequest;
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  String timeOT = '1';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton(
            value: dropdownValue,
            items: <String>[RequestType.OTRequest, RequestType.DayOffRequest]
                .map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                dropdownValue = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(DateTimeFormat(fromDate).toMString('/')),
                  IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () {
                      _chooseFromDate();
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Text(DateTimeFormat(toDate).toMString('/')),
                  IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () {
                      _chooseToDate();
                    },
                  ),
                ],
              )
            ],
          ),
          dropdownValue == RequestType.OTRequest
              ? Container(
                  child: Row(
                    children: [
                      Text("TimeOT"),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        child: DropdownButton(
                          value: timeOT,
                          items: <String>[
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '7',
                            '8',
                            '9',
                            '10',
                            '11',
                            '12'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              timeOT = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          RaisedButton(
            color: Color(0xFF4CAF50),
            child: Text(
              'Send Request',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _onSendRequest(fromDate, toDate, dropdownValue, timeOT);
            },
          )
        ],
      ),
    );
  }

  Future<void> _chooseFromDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: fromDate,
        firstDate: DateTime(2021, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != fromDate) {
      setState(() {
        fromDate = picked;
        toDate = picked;
      });
    }
  }

  Future<void> _chooseToDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: fromDate,
        firstDate: fromDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != toDate) {
      setState(() {
        toDate = picked;
      });
    }
  }

  Future<void> _onSendRequest(
      DateTime fromDate, DateTime toDate, String type, String timeOt) async {
    var _requestService = new RequestService();
    bool isSuccess = false;
    if (type == RequestType.OTRequest) {
      isSuccess = await _requestService.sendOTRequest(
          fromDate, toDate, int.parse(timeOt));
    } else if (type == RequestType.DayOffRequest) {
      isSuccess = await _requestService.sendDayOffRequest(fromDate, toDate);
    }
    if (isSuccess) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Success'),
              Icon(
                Icons.check_circle_outline_rounded,
                color: MColors.success,
              )
            ],
          ),
        ),
      ).then((v) {
        widget._onRefresh();
        Navigator.of(context).pop();
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Your request date is duplicate.'),
              Icon(
                Icons.warning_rounded,
                color: MColors.danger,
              )
            ],
          ),
        ),
      ).then((v) {
        widget._onRefresh();
      });
    }
  }
}
