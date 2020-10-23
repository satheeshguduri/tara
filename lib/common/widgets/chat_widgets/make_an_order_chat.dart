
import 'package:flutter/material.dart';
import 'package:flutter_flavorizr/parser/models/config/app.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/screens/base/base_state.dart';

class MakeAnOrderChat extends StatefulWidget{

  final Function onSelectOption;

  const MakeAnOrderChat({Key key, this.onSelectOption}) : super(key: key);

  @override
  _MakeAnOrderChatState createState() => _MakeAnOrderChatState();
  
}

class _MakeAnOrderChatState extends BaseState<MakeAnOrderChat>{
  
  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(right: 8),
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8),
        width: 160,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(8)
              ),
              border: Border.all(
                  color: AppColors.light_grey_blue,
                  width: 1
              ),
              color: Colors.white
          ),
        child: InkWell(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(Assets.ic_bag),
              Container(width: 8,),
              Text(getTranslation(Strings.make_an_order),
                style: BaseStyles.backAccountHeaderTextStyle,)
            ],
          ),
          onTap: (){
            widget.onSelectOption("makeAnOrder");
          },
        ),
      ),
    );
  }
  
}