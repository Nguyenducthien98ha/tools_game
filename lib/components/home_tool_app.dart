// ignore_for_file: must_call_super

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../domain/api/api_utils.dart';
import '../ruler.dart';
import 'get_games_model.dart';
import 'handle_game.dart';
import 'modal_loading.dart';
import 'tool_game_provider.dart';

// ignore: must_be_immutable
class HomeToolApp extends StatefulWidget {
  HomeToolApp({Key? key, this.username, this.password}) : super(key: key);

  String? username;
  String? password;

  @override
  State<HomeToolApp> createState() => _HomeToolAppState();
}

class _HomeToolAppState extends State<HomeToolApp> {
  Future<List<GetGamesModel>>? _future;
  final api = APIUtils(Dio());

  @override
  void initState() {
    super.initState();
    _future = api.getGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        centerTitle: true,
        title: Ruler.setText(
          'Danh sách các game',
          size: Ruler.setSize + 4,
          color: Colors.black,
        ),
      ),
      body: FutureBuilder<List<GetGamesModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (snapshot.hasError) {
            return Ruler.setText(
              'Tool Game Đổi Thưởng hiện đang cập nhật!',
              size: Ruler.setSize + 2,
              weight: FontWeight.w500,
              color: Colors.white,
            );
          } else {
            final item = snapshot.data!;
            return Container(
              color: Colors.white,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7.5),
                      child: Wrap(
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          children: item.map((e) {
                            final index = item.indexOf(e);
                            return Padding(
                              padding: const EdgeInsets.all(7.5),
                              child: AssetThumbnail(asset: item[index]),
                            );
                          }).toList()),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class AssetThumbnail extends StatefulWidget {
  const AssetThumbnail({
    Key? key,
    @required this.asset,
  }) : super(key: key);

  final GetGamesModel? asset;

  @override
  State<AssetThumbnail> createState() => _AssetThumbnailState();
}

class _AssetThumbnailState extends State<AssetThumbnail> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _open();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              width: (Ruler.width(context, 100) - 60.0000000001) / 3,
              height: (Ruler.width(context, 100) - 60.0000000001) / 3,
              imageUrl: url + widget.asset!.featureImagePath!,
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
              imageBuilder: (context, imageProvider) => Padding(
                padding: const EdgeInsets.all(7.5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 7.5),
            SizedBox(
              width: (Ruler.width(context, 100) - 60.0000000001) / 3,
              child: Ruler.setText(
                widget.asset!.name!,
                textAlign: TextAlign.center,
                size: Ruler.setSize,
                color: Colors.black,
                maxLine: 2,
              ),
            )
          ],
        ),
      ),
    );
  }

  _open() async {
    await showDialog(context: context, builder: (context) => const OpenDialog())
        .then((value) {});
  }
}

class OpenDialog extends StatefulWidget {
  const OpenDialog({Key? key}) : super(key: key);

  @override
  State<OpenDialog> createState() => _OpenDialogState();
}

class _OpenDialogState extends State<OpenDialog> {
  @override
  void initState() {
    super.initState();
  }

  Timer? _timer;
  void startTimer() {
    final pvd = Provider.of<ToolGameProvider>(context, listen: false);
    const oneSec = Duration(milliseconds: 50);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          pvd.increment(timer.tick);
        });
        if (timer.tick == 100) {
          setState(() {
            timer.cancel();
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToolGameProvider>(context, listen: false);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(7.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Ruler.setText(
                    'Chọn Game',
                    size: Ruler.setSize + 2,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        startTimer();
                        openLoaderDialog(context);
                        Timer.periodic(const Duration(milliseconds: 5000),
                            (timer) {
                          Navigator.of(context, rootNavigator: true).pop();
                          provider.percent = 0;
                          timer.cancel();
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      HandleGame(text1: 'Tài', text2: 'Xỉu')));
                        });
                      },
                      child: Container(
                        height: (Ruler.width(context, 100) - 75) / 3,
                        width: (Ruler.width(context, 100) - 75) / 3,
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/taixiu.jpg'),
                                fit: BoxFit.fill)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        startTimer();
                        openLoaderDialog(context);
                        Timer.periodic(const Duration(milliseconds: 5000),
                            (timer) {
                          Navigator.of(context, rootNavigator: true).pop();
                          provider.percent = 0;
                          timer.cancel();
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      HandleGame(text1: 'Chẵn', text2: 'Lẻ')));
                        });
                      },
                      child: Container(
                        height: (Ruler.width(context, 100) - 75) / 3,
                        width: (Ruler.width(context, 100) - 75) / 3,
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/xocdia.jpg'),
                                fit: BoxFit.fill)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        startTimer();
                        openLoaderDialog(context);
                        Timer.periodic(const Duration(milliseconds: 5000),
                            (timer) {
                          Navigator.of(context, rootNavigator: true).pop();
                          provider.percent = 0;
                          timer.cancel();
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => HandleGame(
                                      text1: 'Player', text2: 'Banker')));
                        });
                      },
                      child: Container(
                        height: (Ruler.width(context, 100) - 75) / 3,
                        width: (Ruler.width(context, 100) - 75) / 3,
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/baccarat.jpg'),
                                fit: BoxFit.fill)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
