import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/app_component.dart';
import '../../utils/size_utils.dart';
import '../overview/model/payment_gateway.dart';
class BuyCryptoDialog extends StatelessWidget {
   BuyCryptoDialog({super.key});
  List<PaymentGateway> gateways=[
    PaymentGateway(name: "MoonPay", image: "assets/moonpay.jpeg", paymentUrl: "https://www.moonpay.com/"),
    PaymentGateway(name: "Coinbase", image: "assets/coinbase.png", paymentUrl: "https://www.coinbase.com/"),
    PaymentGateway(name: "BTCx", image: "assets/btcx.jpeg", paymentUrl: "https://bt.cx/en/"),
    PaymentGateway(name: "Bitonic", image: "assets/bitonic.png", paymentUrl: "https://bitonic.nl/order")
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeUtils.getSize(context, 6.sp),horizontal: SizeUtils.getSize(context, 4.sp)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: (){
                  context.pop();
                },
                icon: Icon(
                  Icons.close,
                  size: SizeUtils.getSize(context, 6.sp),
                )
            ),
          ),
          SizedBox(height: SizeUtils.getSize(context, 4.sp),),
          Expanded(
            child: GridView.builder(
              itemCount: gateways.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: SizeUtils.getSize(context, 2.sp),
                childAspectRatio: 2.5,
                mainAxisSpacing: SizeUtils.getSize(context, 2.sp),
              ),
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    _launchUrl(gateways[index].paymentUrl);
                  },
                  child: Container(
                    width: SizeUtils.getSize(context, 10.sp),
                    height: SizeUtils.getSize(context, 8.sp),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeUtils.getSize(context, 2.sp)),
                    ),
                    child: Image.asset(
                      gateways[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

   Future<void> _launchUrl(u) async {
     if (!await launchUrl(Uri.parse(u))) {
       throw Exception('Could not launch $u');
     }
   }
}
