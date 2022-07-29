import 'package:flutter/material.dart';
import 'package:finews_module/theme/app_color.dart';

class AppConstants {
  static const Size designScreenSize = Size(375, 754);
  static const Duration TIME_OUT = Duration(hours: 0, minutes: 0, seconds: 15);
}

enum EnvironmentConfiguration {
  develop,
  staging,
  product,
}

enum OTPMethod { sms, smart }

enum TradingSession {
  ATO,
  ATC,
  CONTINUOUS,
}


/**
 * common error code
 */
const int SUCCESS = 200;
const int FAILURE = 999;
const int UNAUTHORIZED = 401;
const int BAD_REQUEST = 400;
//**Trading Notify
const String CASHOUT_SUCCESS = "trading_cashout_success";
const String CASHOUT_FAILURE = "trading_cashout_failure";
const String CASHIN_SUCCESS = "trading_cashin_success";
const String CASHIN_FAILURE = "trading_cashin_failure";
const String BUY_STOCK_SUCCESS = "trading_buy_stock_success";
const String BUY_STOCK_FAILURE = "trading_buy_stock_failure";
const String SELL_STOCK_SUCCESS = "trading_sell_stock_success";
const String SELL_STOCK_FAILURE = "trading_sell_stock_failure";
const String ACCOUNT_VERIFIED = "account_verified_ok";
/**
 * invalid request data when validate
 */
const int INVALID_REQUEST = 100;

/**
 * user error code
 */
const int USER_LOCKED = 101;
const int USER_ALREADY_REGISTER = 102;
const int USER_NOT_FOUND = 103;
const int USER_INVALID_OTP = 104;
const int USER_BLOCKED_ON_OTP = 105;
const int USER_INVALID_PIN = 106;
const int USER_GEN_CONTRACT_FAILED = 107;
const int USER_TRADING_NOT_FOUND = 1100;
const int USER_NOT_VERIFIED = 1324;

const NOTI_RELOAD_NOTIFICATION = "NOTI_RELOAD_NOTIFICATION";
const NOTI_RELOAD_HOMESAVING = "NOTI_RELOAD_HOMESAVING";
const NOTI_RELOAD_SAVINGDEPOSIT = "NOTI_RELOAD_SAVINGDEPOSIT";
const PROGRESSING_DIALOG = 'ProgressingDialog';

/// String Const
const AUTH_TOKEN_KEY = "trading_auth";
const TD_DEPOSIT_FIRST_SUFFIX = "_TD_DEPOSIT_FIRST";
const APP_FOLLOW_STOCK_OPENED = "_trading_Follow_Stock_Opened";
const Home_Cache = "_Home_Cache";
const Home_Maket_Cache = "_Home_Market_Cache";
const TopicsNotifySubscribe = "Topics_Notify_Subscribe";
const REGISTER_TRADING_INTRO_COMPLETE = "register_trading_intro_complete";
const appDebugMode =true;
/// TEXT
const SESSION_TIMEOUT_CODE = 1200;
const MAINTAIN_LV1_CODE = 1007;
const MAINTAIN_LV2_CODE = 1008;
const BLOCK_OTP_1_CODE = 1370;
const BLOCK_OTP_2_CODE = 1371;
const BLOCK_SMART_OTP_CODE = 1523;
const EKYC_1_CODE = 1324;
const EKYC_2_CODE = 1349;
const EKYC_WITH_POPUP_CODE = 1570;
const BLOCK_MINI_GAME = 1533;
const OUT_OFF_TURN_MINI_GAME = 1530;

const DUR_NONE = Duration();
const DUR_1000 = Duration(milliseconds: 1000);
const DUR_800 = Duration(milliseconds: 800);
const DUR_600 = Duration(milliseconds: 600);
const DUR_500 = Duration(milliseconds: 500);
const DUR_400 = Duration(milliseconds: 400);
const DUR_250 = Duration(milliseconds: 250);
const BOR_RAD12 = BorderRadius.all(Radius.circular(12.0));
const BOR_RAD24 = BorderRadius.all(Radius.circular(24.0));
const BOR_RAD18 = BorderRadius.all(Radius.circular(18.0));
const BOR_RAD8 = BorderRadius.all(Radius.circular(8.0));
const BOR_RAD4 = BorderRadius.all(Radius.circular(4.0));
const BOR_RAD16 = BorderRadius.all(Radius.circular(16.0));
const BOR_COLOR = Color.fromRGBO(0, 0, 0, 0.08);
const BOR_RAD8_ONLY = Radius.circular(8.0);
const BOR_ALL_TOP_24 = BorderRadius.only(
  topRight: Radius.circular(24),
  topLeft: Radius.circular(24),
);

/// String Const
const APPSFLYER_ID_IOS = "1520144590";
const APPSFLYER_ID_ANDROID = "com.tikop";
const DEPOSIT_RECURRING_FIRST_SUFFIX = "_DEPOSIT_RECURRING_FIRST";
const SMART_OTP_SUFFIX = "_SMART_OTP";
const MINI_GAME_SUFFIX = "_MINI_GAME";
const MINI_GAME_SOUND_SUFFIX = "_MINI_GAME_SOUND";
const UNKNOWN_ERROR = 'Có lỗi xảy ra vui lòng thử lại!';

const UPDATE_VERSION_KEY = "update_popup_version";
const UPDATE_VERSION_TIME_KEY = "update_popup_time";
const DEFAULT_VALUE = "--";

/// Email otp case
const FORGOT_OTP = "FORGOT";
const REGISTER_OTP = "REGISTER";
const SMART_OTP = "SMART";

/// SIZE
const AVATAR_SIZE = Size(40, 40);

/// Time Pending Resend OTP

const TIME_COUNTDOWN_OTP = 60;

///SizedBox Width
const SIZED_BOX_W02 = SizedBox(width: 2);
const SIZED_BOX_W04 = SizedBox(width: 4);
const SIZED_BOX_W06 = SizedBox(width: 6);
const SIZED_BOX_W08 = SizedBox(width: 8);
const SIZED_BOX_W10 = SizedBox(width: 10);
const SIZED_BOX_W12 = SizedBox(width: 12);
const SIZED_BOX_W16 = SizedBox(width: 16);
const SIZED_BOX_W20 = SizedBox(width: 20);
const SIZED_BOX_W30 = SizedBox(width: 30);
const SIZED_BOX_W40 = SizedBox(width: 40);
const SIZED_BOX_W42 = SizedBox(width: 42);
const SIZED_BOX_W45 = SizedBox(width: 45);

/// SizedBox Height
const SIZED_BOX_H02 = SizedBox(height: 2);
const SIZED_BOX_H04 = SizedBox(height: 4);
const SIZED_BOX_H06 = SizedBox(height: 6);
const SIZED_BOX_H08 = SizedBox(height: 8);
const SIZED_BOX_H12 = SizedBox(height: 12);
const SIZED_BOX_H16 = SizedBox(height: 16);
const SIZED_BOX_H20 = SizedBox(height: 20);
const SIZED_BOX_H24 = SizedBox(height: 24);
const SIZED_BOX_H26 = SizedBox(height: 26);
const SIZED_BOX_H30 = SizedBox(height: 30);
const SIZED_BOX_H40 = SizedBox(height: 40);
const SIZED_BOX_H50 = SizedBox(height: 50);
const SIZED_BOX_H60 = SizedBox(height: 60);
const SIZED_BOX_H72 = SizedBox(height: 72);

/// PADDING
const PAD_ZERO = EdgeInsets.zero;
const PAD_ALL12 = EdgeInsets.all(12.0);
const PAD_ALL16 = EdgeInsets.all(16.0);
const PAD_ALL06 = EdgeInsets.all(4.0);
const PAD_ALL08 = EdgeInsets.all(8.0);
const PAD_BOTTOM_16 = EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0);
const PAD_ONLY_T20 = EdgeInsets.only(top: 20);
const PAD_ONLY_R20 = EdgeInsets.only(right: 20);
const PAD_TOP_16 = EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0);
const PAD_SYM_H16_B24 = EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0);

const PAD_SYM_H16_V12 = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
const PAD_SYM_H16_V08 = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
const PAD_SYM_H16_V24 = EdgeInsets.symmetric(horizontal: 16, vertical: 24);
const PAD_SYM_H12_V16 = EdgeInsets.symmetric(horizontal: 12, vertical: 16);
const PAD_SYM_H08_V06 = EdgeInsets.symmetric(horizontal: 8, vertical: 6);

/// MARGIN
const MAR_ZERO = EdgeInsets.zero;
const MAR_ALL12 = EdgeInsets.all(12.0);
const MAR_ALL16 = EdgeInsets.all(16.0);
const MAR_ALL06 = EdgeInsets.all(4.0);
const MAR_BOTTOM_16 = EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0);
const MAR_SIDE_16 = EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0);
const MAR_ONLY_T20 = EdgeInsets.only(top: 20);
const MAR_ONLY_R20 = EdgeInsets.only(right: 20);

///horizontal
const PAD_SYM_H4 = EdgeInsets.symmetric(horizontal: 4);
const PAD_SYM_H6 = EdgeInsets.symmetric(horizontal: 6);
const PAD_SYM_H8 = EdgeInsets.symmetric(horizontal: 8);
const PAD_SYM_H12 = EdgeInsets.symmetric(horizontal: 12);
const PAD_SYM_H16 = EdgeInsets.symmetric(horizontal: 16);
const PAD_SYM_H20 = EdgeInsets.symmetric(horizontal: 20);
const PAD_SYM_H24 = EdgeInsets.symmetric(horizontal: 24);
const PAD_SYM_H28 = EdgeInsets.symmetric(horizontal: 28);
const PAD_SYM_H30 = EdgeInsets.symmetric(horizontal: 30);
const PAD_SYM_H40 = EdgeInsets.symmetric(horizontal: 40);
const PAD_SYM_H60 = EdgeInsets.symmetric(horizontal: 60);

///vertical
const PAD_SYM_V5 = EdgeInsets.symmetric(vertical: 5);
const PAD_SYM_V06 = EdgeInsets.symmetric(vertical: 6);
const PAD_SYM_V10 = EdgeInsets.symmetric(vertical: 10);
const PAD_SYM_V12 = EdgeInsets.symmetric(vertical: 12);
const PAD_SYM_V20 = EdgeInsets.symmetric(vertical: 20);

/// Error Code
const CODE_SUCCESS = -1;
const CODE_ERROR_SERVER_INTERNAL = 500;
const CODE_ERROR_APP_INTERNAL = 0;

//Stock color state
const refColor = Color(0xFFFFBE40);
const ceilColor = Color(0xFFA500A8);
const floorColor = Color(0xFF2F80ED);
const increaseColor = Color(0xFF00B14F);
const decreaseColor = Color(0xFFF46666);
const drawColor = Color(0xFF333333);

/// Widgets
const RIGHT_ARROW_ICON = Icon(
  Icons.arrow_forward_ios_rounded,
  size: 12,
  color: COLOR_NEUTRAL_200,
);
