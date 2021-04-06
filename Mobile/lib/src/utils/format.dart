class DateTimeFormat {
  final DateTime _dateTime;
  DateTimeFormat(this._dateTime);

  String toMString(String slash) {
    return _dateTime.day.toString() +
        slash +
        _dateTime.month.toString() +
        slash +
        _dateTime.year.toString();
  }

  String toRequestFormat() {
    var day = _dateTime.day;
    var month = _dateTime.month;
    var dayS = day.toString();
    var monthS = month.toString();
    if (day < 10) dayS = "0" + dayS;
    if (month < 10) monthS = "0" + monthS;

    return _dateTime.year.toString() +
        '-' +
        monthS.toString() +
        '-' +
        dayS.toString();
  }
}
