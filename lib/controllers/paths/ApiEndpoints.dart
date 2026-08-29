class ApiEndpoints {
  static const String baseUrl = "https://api.alaasohail.com/api";

  static const String weatherUrl = "https://api.open-meteo.com/v1/forecast";

  static const String login = "/auth/login";

  static const String register = "/auth/register";

  static const String forgotPassword = "/auth/forgot-password";

  static const String resetPassword = "/auth/reset-password";
  static const String verifyResetCode = "/auth/verify-reset-code";

  static const String profile = "/users/profile";

  static const String logout = "/auth/logout";

  static const String facebookLogin = "/auth/facebook";

  static const String googleLogin = "/auth/google";

  static const String plants = "/plants";

  static const String chat = "/ai/chat";

  static const String posts = "/posts";
  static const String analyze = '/plants/analyze';

  static String addComment(postId) {
    return "/posts/${postId}/comments";
  }

  static String deleteComment(postId, commentId) {
    return "/posts/${postId}/comments/${commentId}";
  }

  static String addLike(postId) {
    return "/posts/${postId}/like";
  }

  static String deletePlants(plantId) {
    return "/plants/$plantId";
  }

  static String deletePosts(postId) {
    return "/posts/$postId";
  }

  static String getUserData(id) {
    return "/users/$id";
  }

  static String updatePlantAi(String plantId) {
    return '${ApiEndpoints.plants}/$plantId/analysis';
  }

  static const String updateLocation = "/users/location";
  static const String verifyEmail = "/auth/verify-email";
  static const String resendVerification = "/auth/resend-verification";
}

class ApiKeys {
  static const String email = "email";
  static const String password = "password";
  static const String name = "name";
  static const String phone = "phoneNumber";
  static const String image = "userImage";
  static const String location = "location";
  static const String token = "token";
  static const String authorization = "Authorization";
  static const String message = "message";
  static const String resetToken = "resetToken";

  static const String success = "success";
  static const String data = "data";
  static const String code = "code";
  static const String id = "id";
  static const String confirmPassword = "confirmPassword";
  static const String oldPassword = "oldPassword";
  static const String newPassword = "newPassword";
  static const String country = "country";
  static const String city = "city";
  static const String latitude = "latitude";
  static const String longitude = "longitude";
  static const String lastLocationUpdate = "last_location_update";
  static const String cachedUser = "cached_user";
  static const String cachedPlants = "cached_plants";

  static const String dailyTip = 'daily_tip';
  static const String dailyTipDate = 'daily_tip_date';
}

class PlantApiKeys {
  static const String plantName = "name";
  static const String species = "species";
  static const String description = "description";
  static const String imageUrl = "image_url";
  static const String imagePlant = "image";
  static const String plantId = "id";
}

class WeatherApiKeys {
  static const String current = "current";

  static const String hourly = "hourly";
  static const String wind_speed_unit = "wind_speed_unit";
  static const String temperature_unit = "temperature_unit";

  static const String temperature_2m = "temperature_2m";
  static const String time = "time";
  static const String weathercode = "weathercode";
  static const String relativehumidity_2m = "relativehumidity_2m";
  static const String windspeed_10m = "windspeed_10m";
}

class CommunityApiKeys {
  static const String content = "content";
  static const String image = "image";
  static const String postId = "id";
  static const String userName = "user_name";
  static const String userImage = "user_image";
  static const String postImage = 'image';
  static const String userId = "id";
  static const String likesCount = "likes_count";
  static const String commentsCount = "comments_count";
  static const String likedByMe = "liked_by_me";
  static const String createdAt = "created_at";
}
