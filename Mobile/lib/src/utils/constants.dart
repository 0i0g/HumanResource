class AppConfig {
  static const API_URL =
      'http://hr-env.eba-mvpdrigf.ap-southeast-1.elasticbeanstalk.com';
}

enum GenderCharacter { male, female, empty }

extension ParseToString on GenderCharacter {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

// role
class RoleConstant {
  static const PROJECT_MANAGER = 1;
  static const LINE_MANAGER = 2;
  static const EMPLOYEE = 3;
}

class Strings {
  static const INVALID_EMAIL = 'Invalid email';
  static const INVALID_FULLNAME = 'Invalid fullname';
  static const INVALID_PHONENUMBER = 'Invalid phone number';
  static const INVALID_SYSTEMCODE = 'Invalid system code';
  static const INVALID_PASSWORD = 'Invalid password';
  static const PLEASE_SELECT_GENDER = 'Please select gender';
  static const EMPTY = '';
  static const SUCCESS = 'Success';
  static const REGISTER_SUCCESS_MESSAGE =
      'Request register success. We will send to your email if your request accepted.';
  static const COMPLETED_CHECKIN_CHECKOUT = 'You finished your work';
}

class ActionState {
  final int state;
  final String message;
  final dynamic data;

  ActionState(this.state, [this.message, this.data]);

  static const Success = 0;
  static const Failed = 1;
  static const Error = 2;
  static const ServerError = 3;
}

class ApiStatusCode {
  static const OK = 200;
  static const NotFound = 404;
  static const Unauthorized = 401;
  static const BadRequest = 400;
  static const Forbidden = 403;
}

// Mapping message code
class SystemMessageConst {
  static const DuplicateCode = 1001;
  static const CodeNotExist = 1002;
}

class UserMessageConst {
  static const InvalidEmail = 2001;
  static const DuplicateEmail = 2002;
  static const InvalidPhoneNumber = 2003;
  static const UserDeleted = 2004;
  static const SystemDeleted = 2005;
  static const SystemNotExist = 2006;
  static const InvalidRole = 2007;
  static const InvalidPassword = 2008;
  static const PleaseActiveUser = 2009;
  static const NotExist = 2010;
}

class TaskMessageConst {
  static const NotExist = 3001;
}

class RequestMessageConst {
  static const Duplicate = 4001;
  static const InvalidStatus = 4002;
}

class CheckInCheckOutState {
  static const CheckedIn = 1;
  static const CheckedOut = 2;
  static const None = 0;
}

class WorkingTime {
  static const Start = 7;
  static const End = 17;
}

class TaskStatus {
  static const Open = "open";
  static const ReOpen = "reopen";
  static const ReSolved = "resolved";
  static const Closed = "closed";
}

class RequestType {
  static const OTRequest = "OT request";
  static const DayOffRequest = "Day off request";
}

class RequestStatus {
  static const WAITING = "submited";
  static const APPROVED = "accepted";
  static const CANCELED = "rejected";
}

class TaskPriority {
  static const LOW = 0;
  static const MEDIUM = 1;
  static const HIGHT = 2;
}
