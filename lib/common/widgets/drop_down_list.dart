import 'package:flutter/material.dart';
import 'package:tara_app/common/constants/styles.dart';

class DropDownList extends StatefulWidget {
  final List<BankInfo> banksList;
  final Function(BankInfo) onPressed;

  const DropDownList( {
    Key key,
    this.banksList,
    this.onPressed,
  }) : super(key: key);

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  Widget build(BuildContext context) {
    return (widget.banksList!=null&& widget.banksList.isNotEmpty)? Card(
      child: Container(
        color: Colors.transparent,
        height: (widget.banksList.length * 40).toDouble(),
        child:ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: (widget.banksList!=null && widget.banksList.isNotEmpty)?widget.banksList.length:0,
          itemBuilder: (context, index) {
            return Container(
              height: 42,
              child:ListTile(
                onTap: (){
                  widget.onPressed(widget.banksList[index]);
                },
                title: Container(margin: EdgeInsets.only(bottom: 12),child:Text(widget.banksList[index].bankName, style: BaseStyles.bankNameTextStyle)),
                leading:(widget.banksList[index].bankIcon!=null&&widget.banksList[index].bankIcon!="")? Container(margin: EdgeInsets.only(bottom: 12),child:ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 50,
                    minHeight: 24,
                    maxWidth: 50,
                    maxHeight: 24,
                  ),
                  child: Image.asset(widget.banksList[index].bankIcon, fit: BoxFit.cover),
                )):Container(),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ) ,
      ),
    ):Container();
  }
}

class BankInfo {
  String bankName;
  String bankIcon;
}