import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/utils/locale/utils.dart';

class AccountInfoCardRow extends StatelessWidget {
  final MappedBankAccountsBean data;
  AccountInfoCardRow({this.data});


  @override
  Widget build(BuildContext context) {
    return transactionDetailRow();
  }

  Widget transactionDetailRow() {

    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff7f7fa),
      ),
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/indepay.png",width: 80,fit:BoxFit.fitWidth),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(5)
                  ),
                  boxShadow: [BoxShadow(
                      color: const Color(0x1a000000),
                      offset: Offset(0,2),
                      blurRadius: 5,
                      spreadRadius: 2
                  )] ,
                  color: AppColors.elevation_off_2_2_2
                // color: Colors.black

              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(Assets.ic_bca, height: 36,fit: BoxFit.fitHeight,),
                      SizedBox(width: 12,),
                      Text(Utils().getMaskedAccountNumber(data.maskedAccountNumber),
                        style: TextStyle(
                            color:  AppColors.color_black_100_2_2_2,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,


                      ).withPad(padding: EdgeInsets.all(16))
                    ],
                  ).withPad(padding: EdgeInsets.all(10)),
                ],
              ),
            )
          ],
        ),

      ),
    );
  }
}
