
enum FromScreen{
  consumer,
  merchant,
  agent,
  none
}

enum ChatAction{
  decline,
  pay,
  none
}
enum PaymentStatus{
  INITIATED,
  SUCCESS,
  DECLINED,
  FAILED
}