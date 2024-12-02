

class OtpArgs{
  String email;
  Function initialCallBack;
  Function callBack;
  String? otp;

  OtpArgs({required this.email,required this.callBack,required this.initialCallBack,this.otp});
}