// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../domain/api/api_utils.dart';
import '../ruler.dart';
import 'tool_game_provider.dart';

class HandleGame extends StatefulWidget {
  HandleGame({Key? key, this.text1, this.text2}) : super(key: key);

  String? text1;
  String? text2;

  @override
  State<HandleGame> createState() => _HandleGameState();
}

class _HandleGameState extends State<HandleGame>
    with SingleTickerProviderStateMixin {
  final api = APIUtils(Dio());
  AnimationController? _animationController;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      api.getInfoTool().then((value) {
        log(value.status!.toString());
        Provider.of<ToolGameProvider>(context, listen: false)
            .checkStatus(value.status!);
        log(value.status!.toString());
        setState(() {
          _animationController!.repeat(reverse: true);
        });
      });
    });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    timer?.cancel();
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToolGameProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 160,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            provider.status == 2
                                ? FadeTransition(
                                    opacity: _animationController!,
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: const Color(0Xff70ff71),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: const Color(0Xff70ff71),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                            const SizedBox(height: 7.5),
                            Ruler.setText(
                              widget.text1!,
                              size: Ruler.setSize + 2,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      Image.asset('assets/images/icon_center.png', height: 40),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            provider.status == 1
                                ? FadeTransition(
                                    opacity: _animationController!,
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: const Color(0Xffff7070),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: const Color(0Xffff7070),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                            const SizedBox(height: 7.5),
                            Ruler.setText(
                              widget.text2!,
                              size: Ruler.setSize + 2,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 5,
                  child: Ruler.setText(
                    //
                    'v2',
                    size: Ruler.setSize,
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      color: Colors.transparent,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/x-symbol-svgrepo-com.svg',
                          height: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
