import 'dart:async';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../domain/api/api_utils.dart';
import '../domain/model/info_tool_model.dart';
import '../ruler.dart';
import 'home_tool_app.dart';
import 'tool_game_provider.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp>
    with SingleTickerProviderStateMixin {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passcode = TextEditingController();


  VideoPlayerController? _controller;
  Future<InfoToolModel>? _future;
  final _api = APIUtils(Dio());
  int milliseconds = 4000;

  Timer? _timer;
  int _pos = 0;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ToolGameProvider>(context, listen: false);
    _controller = VideoPlayerController.asset('assets/videos/video.mp4')
      ..initialize().then((_) {
        _controller!.play();
        _controller!.setLooping(true);
        // setState(() {});
      });
    _future = _api.getInfoTool();
    _timer = Timer.periodic(Duration(milliseconds: milliseconds), (Timer t) {
      _pos = (_pos + 1) % provider.listSlidePhone!.length;
      showToast('${provider.listSlidePhone![_pos].phone} ${provider.listSlidePhone![_pos].description}',
          context: context,
          animation: StyledToastAnimation.slideFromRightFade,
          reverseAnimation: StyledToastAnimation.slideToRightFade,
          toastHorizontalMargin: 0.0,
          position: const StyledToastPosition(
              align: Alignment.topRight, offset: 40.0),
          startOffset: const Offset(1.0, -3.0),
          reverseEndOffset: const Offset(1.0, -3.0),
          animDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 4),
          curve: Curves.linearToEaseOut,
          reverseCurve: Curves.fastOutSlowIn);


    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: FutureBuilder<InfoToolModel>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (snapshot.hasError) {
            return Ruler.setText(
              'Tool Game Đổi Thưởng 5.0 Uy Tín Hàng Đầu Tại Việt Nam',
              size: Ruler.setSize + 2,
              weight: FontWeight.w500,
              color: Colors.white,
            );
          } else {
            final item = snapshot.data;
            return Stack(
              children: [
                SizedBox(
                  width: Ruler.width(context,100),
                  height: Ruler.height(context,100),
                  child: VideoPlayer(
                    _controller!,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Marquee(
                    text: item!.textOnTop!,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: Ruler.setSize + 4,
                    ),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 100,
                    velocity: 100.0,
                    pauseAfterRound: const Duration(seconds: 0),
                    startPadding: 0.0,
                    accelerationDuration: const Duration(seconds: 0),
                    decelerationDuration: const Duration(milliseconds: 500),
                  ),
                ),
                // Positioned(
                //   top: 80,
                //   right: 0,
                //   child: AnimatedBuilder(
                //       animation: animation!,
                //       builder: (context, child) {
                //         return AnimatedBuilder(
                //           animation: animation2!,
                //           builder: (context, child) {
                //             return Container(
                //               decoration: BoxDecoration(
                //                 border: Border(
                //                     left: BorderSide(
                //                         color: animation2!.value, width: 4)),
                //                 color: animation!.value,
                //               ),
                //               child: Padding(
                //                   padding: const EdgeInsets.symmetric(
                //                       vertical: 7.5, horizontal: 5),
                //                   child: Consumer<ToolGameProvider>(
                //                     builder: (context, model, child) {
                //                       return AnimatedBuilder(
                //                         animation: animation1!,
                //                         builder: (context, child) {
                //                           return Ruler.setText(
                //                               '${model.listSlidePhone![_pos].phone} ${model.listSlidePhone![_pos].description}',
                //                               size: Ruler.setSize + 1,
                //                               color: animation1!.value);
                //                         },
                //                         child: const SizedBox(),
                //                       );
                //                     },
                //                   )),
                //             );
                //           },
                //         );
                //       }),
                // ),
                Positioned(
                  bottom: 15,
                  left: 40,
                  right: 40,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Ruler.setText(
                          'Vui Lòng Nhận Mã Tại Hotline & Zalo',
                          size: Ruler.setSize + 3,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          weight: FontWeight.w400,
                        ),
                        const SizedBox(height: 5),
                        Ruler.setText(
                          item.hotline!,
                          size: Ruler.setSize + 4,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          weight: FontWeight.w400,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 45,
                                child: TextFormField(
                                  onChanged: (input) {},
                                  onFieldSubmitted: (value) {},
                                  keyboardType: TextInputType.text,
                                  controller: username,
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                      fontSize: Ruler.setSize),
                                  decoration: InputDecoration(
                                      hintText: "Username",
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      hintStyle: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFF9BA4AF),
                                          fontSize: Ruler.setSize),
                                      fillColor: const Color(0xffF4F4F4),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: SizedBox(
                                height: 45,
                                child: TextFormField(
                                  onChanged: (input) {},
                                  onFieldSubmitted: (value) {},
                                  keyboardType: TextInputType.text,
                                  controller: password,
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                      fontSize: Ruler.setSize),
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      hintStyle: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFF9BA4AF),
                                          fontSize: Ruler.setSize),
                                      fillColor: const Color(0xffF4F4F4),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            onChanged: (input) {},
                            onFieldSubmitted: (value) {},
                            keyboardType: TextInputType.phone,
                            controller: passcode,
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                fontSize: Ruler.setSize),
                            decoration: InputDecoration(
                                hintText: "Passcode",
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.normal,
                                    color: const Color(0xFF9BA4AF),
                                    fontSize: Ruler.setSize),
                                fillColor: const Color(0xffF4F4F4),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () async {
                            if (username.text.isEmpty ||
                                password.text.isEmpty ||
                                passcode.text.isEmpty) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                headerAnimationLoop: false,
                                title: 'Lỗi',
                                desc: 'Vui lòng điền đầy đủ thông tin!',
                                btnOkIcon: Icons.cancel,
                                btnOk: GestureDetector(
                                  onTap: () async {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Ruler.setText(
                                          'Ok',
                                          color: Colors.white,
                                          size: Ruler.setSize + 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                btnOkColor: Colors.red,
                              ).show();
                            } else {
                              await _api
                                  .getPassword(
                                      username: username.text,
                                      password: password.text)
                                  .then((value) {
                                log(value.password!);
                                if (passcode.text == value.password!) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => HomeToolApp(
                                                username: username.text,
                                                password: password.text,
                                              )),
                                      (route) => false);
                                } else {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: 'Lỗi',
                                    desc:
                                        'Phần mềm không hỗ trợ trên điện thoại này!',
                                    btnOkIcon: Icons.cancel,
                                    btnOk: GestureDetector(
                                      onTap: () async {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Ruler.setText(
                                              'Ok',
                                              color: Colors.white,
                                              size: Ruler.setSize + 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    btnOkColor: Colors.red,
                                  ).show();
                                }
                              }).onError((error, stackTrace) {});
                            }
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: const Color(0xFF80C04D),
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Ruler.setText(
                                'Tiếp tục',
                                color: Colors.white,
                                size: Ruler.setSize + 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
