import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../components/get_games_model.dart';
import '../../constants.dart';
import '../model/get_password_model.dart';
import '../model/info_tool_model.dart';
import '../model/slide_phone_model.dart';

part 'api_utils.g.dart';

@RestApi(baseUrl: url)
abstract class APIUtils {
  factory APIUtils(Dio dio, {String baseUrl}) = _APIUtils;

  @GET('api/tool')
  Future<InfoToolModel> getInfoTool();

  @GET("api/password")
  Future<GetPasswordModel> getPassword({
    @Query("username") String? username,
    @Query("password") String? password,
  });
  @GET("api/games")
  Future<List<GetGamesModel>> getGames();

  @GET("api/slide-phone")
  Future<List<SlidePhoneModel>> getSlidePhone();
}
