class ApiEndpoints {
  static const String socketURL = "http://localhost:3002";
  static const String baseDomain = "http://192.168.1.190:3001/";
  static const String baseURL = "http://192.168.1.190:3001/api";
  static const Map<String, dynamic> defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'apisecret': "Apple",
  };
  static const int connectionTimeout = 5000;
  static const int receiveTimeout = 60000;

  // Endpoints
  static const String baseRoute = "/";

  // Auth
  static const String loginRoute = "/users/login";
  static const String signupRoute = "/users/signup";
  static const String signupOTPValidatorRoute = "/users/otpValidator";
  static const String loginWithTokenRoute = "/users/loginWithToken";
  static const String uploadProfilePicRoute = "/users/uploadProfilePic";
  static const String deleteUserRoute = "/users/deleteUser";
  static const String sendForgotPasswordOTPRoute =
      "/users/sendForgotPasswordOTP";
  static const String changePasswordRoute = "/users/changePassword";
  static const String resendVerificationRoute = "/users/resendVerification";
  // Music Endpoints

  // Songs
  static const String addSongRoute = '/music/addSong';
  static const String addSongsRoute = '/music/addSongs';
  static const String getAllSongsRoute = '/music/getAllSongs';
  static const String updateSongRoute = '/music/updateSong';
  //
  static const String uploadAlbumArtRoute = '/music/uploadAlbumArt';
  static const String getAllPublicSongsRoute = '/music/getAllPublicSongs';
  static const String getUserPublicSongsRoute = '/music/getUserPublicSongs';
  static const String getAllFolderWithSongsRoute =
      '/music/getAllFolderWithSongs';
  static const String getAllFoldersRoute = '/music/getAllFolders';
  static const String getFolderSongsRoute = '/music/getFolderSongs';
  static const String addFoldersRoute = '/music/addFolders';
  static const String getAllArtistWithSongsRoute =
      '/music/getAllArtistWithSongs';
  static const String addAlbumsRoute = '/music/addAlbums';
  static const String getAllAlbumsRoute = '/music/getAllAlbums';
  static const String getAllAlbumWithSongsRoute = '/music/getAllAlbumWithSongs';
  static const String addToPlaylistRoute = '/music/addToPlaylist';
  static const String createPlaylistRoute = '/music/createPlaylist';
  static const String getPlaylistsRoute = '/music/getPlaylists';
  static const String toogleSongPublicRoute = '/music/tooglePublic';
  static const String deleteSongRoute = '/music/deleteSong';
}
