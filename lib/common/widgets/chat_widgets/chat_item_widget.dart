import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tara_app/common/widgets/chat_widgets/agent_confirmed.dart';
import 'package:tara_app/common/widgets/chat_widgets/agent_uin_otp_code.dart';
import 'package:tara_app/common/widgets/chat_widgets/decline_pay_widget.dart';
import 'package:tara_app/common/widgets/chat_widgets/deposit_success.dart';
import 'package:tara_app/common/widgets/chat_widgets/on_the_way.dart';

// ignore: must_be_immutable
class ChatItemWidget extends StatelessWidget{
  var index;

  ChatItemWidget(this.index);

  @override
  Widget build(BuildContext context) {

    if (index==0)
      {
        return Container(
          padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child:  Container(
                      child: OnTheWay(isArrived: true,),),
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                  )
                ],
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          margin: EdgeInsets.only(bottom: 10.0),
        );
      }
    else if (index==1)
    {
      return Container(
        padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child:  Container(
                    child: OnTheWay(isArrived: false,),),
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                )
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
    else if (index ==2)
      {
        return Container(
          padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: AgentConfirmed(),
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                  )
                ],
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          margin: EdgeInsets.only(bottom: 10.0),
        );
      }
    else if (index==3)
    {
      return Container(
        padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child:  Container(
                    child: OnTheWay(isVerifyingAgent: true,),),
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                )
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
    else if (index==4)
    {
      return Container(
        padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child:  Container(
                    child: AgentUINOROTP(isAgentUINCode: true,),),
                  width: 230,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                )
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
    else if (index==5)
    {
      return Container(
        padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child:  Container(
                    child: AgentUINOROTP(isAgentUINCode: false,),),
                  width: 230,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                )
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
    else if (index==7)
    {
      return Container(
        padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child:  Container(
                    child: DepositSuccess(),),
                  width: 230,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                )
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
    else if (index==8)
    {
      return Container(
        padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child:  Container(
                    child: DeclinePay(),),
                  width: 230,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                )
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }

    else{
      return Container();
    }

   /* if (index % 2 == 0) {
      //This is the sent message. We'll later use data from firebase instead of index to determine the message is sent or received.
      return Container(
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    'This is a sent message',
                    style: TextStyle(color: AppColors.header_top_bar_color),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0)),
//                  margin: EdgeInsets.only(right: 10.0,),
                )
              ],
              mainAxisAlignment:
              MainAxisAlignment.end, // aligns the chatitem to right end
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm')
                          .format(DateTime.fromMillisecondsSinceEpoch(1565888474278)),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal),
                    ),
                    margin: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0,right: 50),
                  )])
          ]));
    } else {
      // This is a received message
      return Container(
        padding: EdgeInsets.only(left: 8,right: 8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child:  Container(
                    child: index==1?OnTheWay():OnTheWay(isArrived: false,),),
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                )
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    } */
  }

}