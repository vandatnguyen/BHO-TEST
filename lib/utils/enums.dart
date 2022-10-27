import 'package:json_annotation/json_annotation.dart';

// enum ServerEnvironment {
//   develop,
//   staging,
//   product,
// }
enum ConditionState {
  none,
  success,
  error,
  info,
  warning,
}
enum CameraType {
  font_cmnd,
  back_cmnd,
  passport,
  portrait,
}

enum InvestType {
  @JsonValue("NORMAL")
  normal,
  @JsonValue("PROPERTY")
  property,
  @JsonValue("STOCK")
  stock,
}

enum StatusReferral {
  @JsonValue("INVITED")
  invited,
  @JsonValue("DEPOSITED")
  deposited,
}

enum PostType { faq, post }

enum NotificationType {
  account_register, // "account_register"
  account_verified_ok, // "account_verified_ok"
  account_verified_email_ok, // "account_verified_email_ok"
  transaction_deposit, // "transaction_deposit"
  transaction_withdraw, // "transaction_withdraw"
  transaction_deposit_pause, // "transaction_deposit_pause"
  promotion, // "promotion"
  transaction_recommend, // "transaction_recommend"
  social_connect, // "social_connect"
  account_not_verified, // "account_not_verified"
  transaction_saving_deposit_pause, // "transaction_saving_deposit_pause"
  transaction_saving_withdraw, // "transaction_saving_withdraw"
  transaction_saving_deposit, // "transaction_saving_deposit"
  /// add type after check android native
  user_profile,
  transaction_referral,
  system_notification,
  renew_contract,
  type_default,
  share_puzzle_piece
}

enum StepStatus {
  done,
  progressing,
  // undone,
}

enum VerifyType {
  deposit, //"DEPOSIT"
  withdraw //"WITHDRAW"

}
enum TransferType {
  manual,
  gateway,
  keep,
}

enum NinePayType {
  gateway,
  keep,
}

enum StockOrderType {
  @JsonValue(0)
  buy,
  @JsonValue(1)
  sell,
}

enum ProductType { stock }

enum TransactionType {
  @JsonValue("DEPOSIT")
  deposit,
  @JsonValue("WITHDRAW")
  withdraw,
  @JsonValue("INTEREST")
  interest,
  @JsonValue("LIMITED")
  limited,
  @JsonValue("UNLIMITED")
  unlimited,
  @JsonValue("CASHIN")
  cashin,
  @JsonValue("CASHOUT")
  cashout,
}

enum StockTransactionState {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  partiallyProcessed,
  @JsonValue(2)
  processed,
  @JsonValue(-1)
  failed,
  @JsonValue(-2)
  block,
}

enum TransactionState {
  @JsonValue("CREATED")
  create,
  @JsonValue("PROCESSING")
  progressing,
  @JsonValue("SUCCESS")
  success,
  @JsonValue("CANCEL")
  cancel,
  @JsonValue("LOCK")
  lock,
  @JsonValue("DELETED")
  delete,
  @JsonValue("APPROVED")
  approved,

  @JsonValue("CONFIRMING")
  confirming,


  @JsonValue("FAILED")
  failed,
}

enum TransactionTopupResultType {
  APPROVED,
  CONFIRMING,
  FAILED
}

enum TransactionTopupType {
  CASHIN,
  CASHOUT,
}




enum TranFunStatus {
  none,
  @JsonValue("CANCELED")
  cancel,
  @JsonValue("SUCCEED")
  success,
  @JsonValue("PROCESSING")
  progressing,
  @JsonValue("COLLECTED")
  collected,
  @JsonValue("CREATED")
  created,
}

enum InvestProductType {
  @JsonValue("FLEXIBLE")
  flexible,
  @JsonValue("SAMPLE")
  sample,
}

enum TransactionMethod {
  @JsonValue("BANK_TRANSFER")
  bankTransfer,
  @JsonValue("9PAY_KEEP")
  ninePayKeep,
  @JsonValue("9PAY_GATEWAY")
  ninePayGateWay,
  @JsonValue("BANK_TRANSFER_INTERNATIONAL")
  bankTransferGlobal,
  @JsonValue("PAYPAL")
  paypal,
  @JsonValue("REFERRAL")
  referral,
  @JsonValue("RENEW")
  renew,
  @JsonValue("MOVE_PRODUCT")
  moveProduct,
  @JsonValue("MOVE_PRODUCT_FROM_TARGET")
  moveProductFromTarget,
  @JsonValue("MOVE_SAVING_FROM_REAL_ESTATE")
  moveSavingFromRealEstate,
  @JsonValue("TRANSFER_SAVING")
  transferSaving,
  @JsonValue("9PAY_WITHDRAW")
  ninePay_withdraw,

  none,
}

enum EkycType {
  @JsonValue(0)
  none,
  @JsonValue(1)
  cmt,
  @JsonValue(2)
  cccd,
  @JsonValue(3)
  chip,
  @JsonValue(4)
  passport,
}

enum OptionType {
  passport,
  other,
}

enum WithdrawType {
  saving,
  invest,
}

enum OptionGuide {
  choiceBank,
  bankAccount,
  paymentContent,
}
enum TdSnackBarType { info, success, error, warning }
enum TradingSmartOTPType {
  registerTrading,
  cashOutTrading,
  forgotToRegister,
  forgotToCashOut,
}
enum SmsOTPType { registerTrading, cashOutTrading, cashInTrading }
enum BannerType {
  @JsonValue("IN_APP")
  inApp,
  @JsonValue("OUT_APP")
  outApp,
  @JsonValue("POST_VIEW")
  postView,
  @JsonValue("ACTION")
  action,
}

enum UpdateStatus {
  @JsonValue("OFF")
  off,
  @JsonValue("FORCE_UPDATE")
  forceUpdate,
  @JsonValue("UPDATE")
  normalUpdate,
}
