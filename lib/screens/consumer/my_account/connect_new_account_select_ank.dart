import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/common/widgets/drop_down_list.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/transfer/bank_details_bean.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:tara_app/screens/consumer/my_account/enter_card_details.dart';
import 'package:tara_app/common/constants/values.dart';


class ConnectNewAccountSelectBank extends StatefulWidget {
  ConnectNewAccountSelectBank({Key key}) : super(key: key);

  @override
  _ConnectNewAccountSelectBankState createState() =>
      _ConnectNewAccountSelectBankState();
}

class _ConnectNewAccountSelectBankState
    extends BaseState<ConnectNewAccountSelectBank> {
  TransactionController controller = Get.find();

  final TextEditingController _searchQuery = TextEditingController();
  String _searchText = "";
  final key = GlobalKey<ScaffoldState>();

  List<BankDetailsBean> arrBankInfo = [];
  List<BankDetailsBean> arrFilterBankInfo = [];
  List<String> arrBankNames = [
    "Bank BCA",
    "Bank BNI",
    "Bank BRI",
    "Bank BTN",
    "Bank Mandiri",
    "May Bank",
    "Permata Bank",
    "GoPay",
    "DANA"
  ];
  List<String> arrBankIcons = [
    Assets.ic_bca,
    Assets.ic_bni,
    Assets.ic_bri,
    Assets.ic_btn,
    Assets.ic_mandiri,
    Assets.ic_maybank,
    Assets.ic_permata,
    Assets.ic_go_pay,
    Assets.ic_dana,
  ];
  List<String> arrBankBCACardTypesIcons = [
    Assets.ic_gpn_logo,
    Assets.ic_master_card,
    Assets.ic_visa,
  ];
  List<String> arrBankBNICardTypesIcons = [
    Assets.ic_jcb,
    Assets.ic_visa,
  ];
  List<String> arrBankBRICardTypesIcons = [
    Assets.ic_master_card,
    Assets.ic_visa,
  ];
  List<String> arrBankBtnCardTypesIcons = [
    Assets.ic_gpn_logo,
    Assets.ic_master_card,
  ];

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: key,
      appBar:CustomAppBarWidget(title: getTranslation(Strings.connect_new_account),addNewWidgetShow: false,),
      body: SafeArea(child: loadWidgets()),
    );
  }

  // Widget getRootContainer() {
  //   return Obx(() => SafeArea(
  //         child: loadWidgets()).withProgressIndicator(showIndicator: controller.showProgress.value)
  //
  //   );

 // }


  @override
  void initState() {
    super.initState();
   // loadData();
  }

  // Future<List<BankInfo>>  loadData() async {
  //   arrBankInfo = [];
  //
  //   for (var i = 0; i < arrBankNames.length; i++) {
  //     var bank = BankInfo();
  //     bank.bankName = arrBankNames[i];
  //     bank.bankIcon = arrBankIcons[i];
  //     if (bank.bankName=="Bank BCA"){
  //       bank.cardTypeIcons = arrBankBCACardTypesIcons;
  //     }
  //     else if (bank.bankName=="Bank BNI"){
  //       bank.cardTypeIcons = arrBankBNICardTypesIcons;
  //     }
  //     else if (bank.bankName=="Bank BRI"){
  //       bank.cardTypeIcons = arrBankBRICardTypesIcons;
  //     }
  //     else if (bank.bankName=="Bank BTN"){
  //       bank.cardTypeIcons = arrBankBtnCardTypesIcons;
  //     }
  //     arrBankInfo.add(bank);
  //   }
  //   return arrBankInfo;
  // }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.8,
      centerTitle: false,
      automaticallyImplyLeading: false, // hides leading widget
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
      ),
      title:Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(Strings.connect_new_account),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  loadWidgets()
  {
    return Container(
      child: Column(
        children: [
          headerViewContainer(""),
          Expanded(
            child: (_searchText.toString().isNotEmpty && arrFilterBankInfo.isEmpty)?errorWidget():getListOfBanks(),
          )
        ],
      ),
    );
  }


  listViewContainer(arrBankInfo) {
    return Container(
      margin: EdgeInsets.only(top:8),
      height: (arrFilterBankInfo!=null && arrFilterBankInfo.isNotEmpty)?(arrFilterBankInfo.length * 50).toDouble():
      (arrBankInfo!=null && arrBankInfo.isNotEmpty)?(arrBankInfo.length * 50).toDouble():0,
      child:ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: (arrFilterBankInfo!=null && arrFilterBankInfo.isNotEmpty)?arrFilterBankInfo.length:
                  (arrBankInfo!=null && arrBankInfo.isNotEmpty)?arrBankInfo.length:0,
        itemBuilder: (context, index) {
          return (arrFilterBankInfo!=null && arrFilterBankInfo.isNotEmpty)?
          getBankItemWidget(arrFilterBankInfo[index]):
          getBankItemWidget(arrBankInfo[index]);
        },

      ) ,
    );
  }

  Widget headerViewContainer(String headerTitle) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 16,right: 16,top: 8),
          child:TextWithBottomOverlay(titleStr: getTranslation(Strings.select_bank_e_money,)),
        ),
        Container(
          margin: EdgeInsets.only(left: 16,right: 16,bottom: 8),
          child: Text(
              getTranslation(Strings.select_bank_e_money_subtext),
              style: BaseStyles.subHeaderTextStyle
          ),
        ),
        getSearchBarWidget(),
      ],
    );
  }

  getSearchBarWidget()
  {
    return Column(
      children: [
        Container(
          height: 40,
          margin: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 16
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: (_searchText.toString().isNotEmpty)?AppColors.header_top_bar_color:Colors.grey[400], width: 1),
          ),
          child: TextField(
            controller: _searchQuery,
            keyboardType: TextInputType.text,
            style: BaseStyles.baseTextStyle,
            cursorColor: Colors.black,
            autofocus: false,
            onChanged: (value) {
              _searchText = value;
              if (_searchText != null &&
                  _searchText.toString().trim().isNotEmpty &&
                  _searchText.toString().trim().length > 2) {
                arrFilterBankInfo = [];
                if (arrBankInfo.isNotEmpty) {
                  arrFilterBankInfo = arrBankInfo
                      .where((contact) => contact.name
                      .toLowerCase()
                      .contains(_searchText.toLowerCase()))
                      .toList();
                }
                setState(() {

                });
              } else {
                if (_searchQuery.text == "") {
                  setState(() {
                    _searchText = "";
                    _searchQuery.text = "";
                    arrFilterBankInfo.clear();
                  });
                }
              }
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black54,
                size: 20,
              ),
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0.1)),
              hintText: getTranslation(Strings.search_bank_e_money_hint),
              hintStyle: BaseStyles.hintTextStyle,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear,
                    color: (_searchText != null &&
                        _searchText.toString().isNotEmpty)
                        ? Colors.black54
                        : Colors.transparent),
                onPressed: (){
                  setState(() {
                    _searchText = "";
                    _searchQuery.text = "";
                    arrFilterBankInfo.clear();
                  });
                },
              )
            ),
          ),
        ),
      ],
    );
  }
  getBankItemWidget(BankDetailsBean bankInfo) {
    return Container(
      child:Column(
        children: [
          ListTile(
            onTap: (){
         Get.to(EnterCardDetails(bankInfo.bic));
            },
            title: Container(child:Text(bankInfo.name, style: BaseStyles.bankNameTextStyle)),
            leading:
            //(bankInfo.bankIcon!=null&&bankInfo.bankIcon!="")?
            Container(child:ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 50,
                minHeight: 24,
                maxWidth: 50,
                maxHeight: 24,
              ),
              child: Image.asset(Assets.ic_bca,
                  fit: BoxFit.cover),
            )
            )
            //:Container(),
            //trailing: cardTypesWidget(bankInfo),
          ),
          Container(
            height: 0.5,
            margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
            color: Colors.grey[300],
          )
        ],
      ),
    );
  }

  // cardTypesWidget(BankDetailsBean bankInfo)
  // {
  //   if (bankInfo.cardTypeIcons!=null&&bankInfo.cardTypeIcons.isNotEmpty){
  //     if (bankInfo.cardTypeIcons.length==3) {
  //       return Wrap(
  //         spacing: 8,
  //         children: [
  //           Image.asset(bankInfo.cardTypeIcons[0], fit: BoxFit.cover,
  //             width: 24,
  //             height: 24,),
  //           Image.asset(bankInfo.cardTypeIcons[1], fit: BoxFit.cover,
  //             width: 24,
  //             height: 20,),
  //           Image.asset(bankInfo.cardTypeIcons[2], fit: BoxFit.cover,
  //             width: 24,
  //             height: 24,)
  //         ],
  //       );
  //     }
  //     else if (bankInfo.cardTypeIcons.length==2) {
  //       return  Wrap(
  //         spacing: 8,
  //         children: [
  //           Image.asset(bankInfo.cardTypeIcons[0], fit: BoxFit.cover,
  //             width: 24,
  //             height: 24,),
  //           Image.asset(bankInfo.cardTypeIcons[1], fit: BoxFit.cover,
  //             width: 24,
  //             height: 24,),
  //         ],
  //       );
  //     }
  //     else {
  //       return  Wrap(
  //         spacing: 8,
  //         children: [
  //           Image.asset(bankInfo.cardTypeIcons[0], fit: BoxFit.cover,
  //             width: 24,
  //             height: 24,),
  //         ],
  //       );
  //     }
  //   }
  //   return Container(
  //     width: 20,
  //     height: 20,
  //   );
  // }

  errorWidget()
  {
    return Container(
      child: SingleChildScrollView(
        child:Column(
        children: [
          Container(
            height: 24,
          ),
          bigCircle(),
          errorTitleTextWidget(),
          errorSubTitleTextWidget()
        ],
      ),),
    );
  }

  bigCircle() {
    return Container(
        width: 88,
        height: 88,
        decoration: new BoxDecoration(
          color: Color(0xffd8d8d8),
          shape: BoxShape.circle,
        ),
        child:Container());
  }

  errorTitleTextWidget()
  {
    return Container(
      margin: EdgeInsets.only(top:16,),
      child: Text(
          getTranslation(Strings.we_cannot_find_anything) + "\"${_searchText.toString()}\"",
          style: BaseStyles.cannotFindTextStyle,
          textAlign: TextAlign.center
      ),
    );
  }

  errorSubTitleTextWidget()
  {
    return Container(
      margin: EdgeInsets.only(top:8,bottom: 8),
      child: Text(
          getTranslation(Strings.maybe_try_other_items),
          style: BaseStyles.dateAndTimeTextStyle,
          textAlign: TextAlign.center
      ),
    );
  }

  getListOfBanks() {
    return FutureBuilder(
        future: Get.find<TransactionController>().getBanksList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              arrBankInfo = snapshot.data;
              return  listViewContainer(arrBankInfo);
            }
          }
          return const Center(child: BaseWidgets.getIndicator);
        }
    );



  }


}

