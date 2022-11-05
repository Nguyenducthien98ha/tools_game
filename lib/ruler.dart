import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Ruler {
  static late double setSize;

  void init(BuildContext context) {
    if (MediaQuery.of(context).size.width < 380) {
      setSize = 14;
    } else if (MediaQuery.of(context).size.width < 490) {
      setSize = 15;
    } else if (MediaQuery.of(context).size.width < 600) {
      setSize = 17;
    } else {
      setSize = 18;
    }
  }

  static toastSuccess(String content) {
    Fluttertoast.showToast(
        msg: content,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static String formatTime(String value) {
    int date = DateTime.parse(value).millisecondsSinceEpoch;
    int a = DateTime.now().millisecondsSinceEpoch - date;
    if (a < 60000) {
      return ' ${a ~/ 1000} giây trước';
    } else if (a < 3600000) {
      return ' ${a ~/ 60000} phút trước';
    } else if (a >= 3600000 && a < 86400000) {
      return ' ${a ~/ 3600000} giờ trước';
    } else if (a >= 86400000 && a < 2592000000) {
      return ' ${a ~/ 86400000} ngày trước';
    } else if (a >= 2592000000 && a < 31104000000) {
      return ' ${a ~/ 2592000000} tháng trước';
    } else {
      return ' ${a ~/ 31104000000} năm trước';
    }
  }

  static double width(BuildContext context, double value) {
    return value * MediaQuery.of(context).size.width / 100;
  }

  static double height(BuildContext context, double value) {
    return value * MediaQuery.of(context).size.height / 100;
  }

  static double sizeText(BuildContext context, double value) {
    return ((value * MediaQuery.of(context).size.width / 100) +
            (value * MediaQuery.of(context).size.height / 100)) /
        2;
  }

  static double tinyText(BuildContext context) {
    return 8;
  }

  static double smolText(BuildContext context) {
    return 12;
  }

  static double regular(BuildContext context) {
    return 14;
  }

  static double big(BuildContext context) {
    return 18;
  }

  static Widget setText(String value,
      {FontWeight? weight,
      @required double? size,
      Color? color,
      TextDecoration? through,
      int? maxLine,
      TextOverflow? overFlow,
      FontStyle? fontStyle,
      TextAlign? textAlign}) {
    return Text(
      value,
      maxLines: maxLine,
      overflow: overFlow,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: weight,
        fontStyle: fontStyle,
        fontSize: size,
        color: color,
        decoration: through,
      ),
    );
  }

  static double tryParseStringToDouble(String value) {
    return double.tryParse(value)!;
  }

  static int tryParseStringToInt(String value) {
    return int.tryParse(value)!;
  }

  static String tryParseDoubleToString(double value) {
    return value.toString();
  }

  static String tryParseDoubleToMoney(double value) {
    final oCcy = NumberFormat("#,###", "en_US");
    return oCcy.format(value);
  }

  static String tryParseIntToMoney(int value) {
    final oCcy = NumberFormat("#,###", "vi_VI");
    //return value.toStringAsFixed(0) + " VNĐ";
    return oCcy.format(value);
  }

  static DateTime tryParseStringToDate(String value) {
    return DateTime.parse(value);
  }

  static String formatStringDate(String value) {
    return '${value.substring(8, 10)}-${value.substring(5, 7)}-${value.substring(0, 4)}';
  }

  static String formatStringDateymd(String value) {
    return '${value.substring(0, 4)}-${value.substring(5, 7)}-${value.substring(8, 10)}';
  }

  static bool checkDate(String value) {
    int date = DateTime.parse(value).millisecondsSinceEpoch;
    if (DateTime.now().millisecondsSinceEpoch - date < 0) return true;
    return false;
  }
}
