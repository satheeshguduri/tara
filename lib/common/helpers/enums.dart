
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
enum VerificationType{
  ORDER,
  BILL,
  TRANSFER,
  ADD_ACCOUNT
}