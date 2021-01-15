import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/helpers/get_helper.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/common/widgets/common_your_purchase_widget.dart';
import 'package:tara_app/common/widgets/dashed_line_border_button.dart';
import 'package:tara_app/common/widgets/error_state_info_widget.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/bills/bill_details_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/screens/consumer/bank_transfer_new_contact.dart';
import 'package:tara_app/screens/consumer/my_account/connect_new_account_select_ank.dart';
import 'package:tara_app/screens/consumer/transfer_details_entry_widget.dart';
import 'package:tara_app/screens/merchant/merchant_cash_deposit_select_contact.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/utils/locale/utils.dart';
import 'package:tara_app/common/constants/values.dart';

import '../../injector.dart';
import 'my_account/myaccounts_see_all_screen.dart';
import 'my_account/otp_verification_screen.dart';


class TransferToTaraUser extends StatefulWidget {
  final bool isFromTaraUser;
  final String navBarTitle;
  TransferToTaraUser({Key key,this.isFromTaraUser=false, this.navBarTitle}) : super(key: key);

  @override
  _TransferToTaraUserState createState() =>
      _TransferToTaraUserState();
}

class _TransferToTaraUserState
    extends BaseState<TransferToTaraUser> {
  TextEditingController _searchQuery = TextEditingController();
  String _searchText = "";
  final key = new GlobalKey<ScaffoldState>();
  List<Contact> arrTaraContactInfo = List();
  List<Contact> arrFilterTaraContactInfo = List();
  List<String> arrContactNames = [
    "Yakub Merchant New",
    "George G",
    "Simon S",
    "Yakub Y",
    "Harish H"
  ];
  List<String> arrContactPhoneNumbers = [
    "**** **** **** 78633",
    "**** **** **** 2346",
    "**** **** **** 2347",
    "**** **** **** 2348",
    "**** **** **** 2349"
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
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: _buildTaraAndAllContactsList(),), //bottom: true,top: false,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  // void loadData() {
  //   arrTaraContactInfo = List();
  //   for (var i = 0; i < arrContactNames.length; i++) {
  //     var taraContact = ContactInfo();
  //     taraContact.name = arrContactNames[i];
  //     taraContact.phoneNumber = arrContactPhoneNumbers[i];
  //     taraContact.isTaraContact = true;
  //     arrTaraContactInfo.add(taraContact);
  //   }
  // }

  Future<List<Contact>> loadData() async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      if(permissionStatus.isGranted) {
        List<Contact> _contacts = (await ContactsService.getContacts(
            withThumbnails: false)).toList();
        return _contacts;
      }else{

        getIt.get<GetHelper>().getDialog(content: ErrorStateInfoWidget(desc:"Please enable contacts access permission in system settings",
        onTap: (){
          pop();
          pop();
        },),
        );

      }
    }else{
      List<Contact> _contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();
      return _contacts;
    }

  }

  _buildTaraAndAllContactsList() {
    return FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              arrTaraContactInfo = snapshot.data;
              return Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 16,
                  child: listViewContainer());
            }
            return Container();
          } else {
            return const Center(child: BaseWidgets.getIndicator);
          }
        }
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.8,
      centerTitle: false,
      automaticallyImplyLeading: false,
      // hides leading widget
      leading: IconButton(
        //  icon: Icon(Icons.arrow_back),
          icon: getSvgImage(imagePath: Assets.assets_icon_b_back_arrow,
              width: 24.0,
              height: 24.0),
          onPressed: () =>
              Navigator.pop(context, false) //Navigator.pop(context, false),
      ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslation(widget.navBarTitle),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  Widget headerViewContainer() {
    return Column(
      children: [
        getSearchBarWidget(),
        widget.isFromTaraUser == false ? Container(
          margin: EdgeInsets.only(bottom: 12, top: 16),
          child: DashedLineBorderButton(
            buttonText: getTranslation(Strings.add_bank_or_e_money_account),
            buttonColor: Color(0xfff7f7fa),
            onPressed: () {
              push(ConnectNewAccountSelectBank());
            },),
        ) : Container(margin: EdgeInsets.only(bottom: 8, top: 8),),
        (_searchText
            .toString()
            .isNotEmpty && arrFilterTaraContactInfo.isEmpty) ? Container(
          child: Center(
            child: errorTitleTextWidget(),
          ),
        ) : Container(),
      ],
    );
  }

  errorTitleTextWidget() {
    return Container(
      margin: EdgeInsets.only(top: 16,),
      child: Text(
        getTranslation(Strings.we_cannot_find_anything) +
            "\"${_searchText.toString()}\"",
        style: BaseStyles.cannotFindTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getSearchBarWidget() {
    return Column(
      children: [
        Container(
          height: 40,
          margin: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: (_searchText
                .toString()
                .isNotEmpty) ? AppColors.header_top_bar_color : Colors
                .grey[400], width: 1),
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
                  _searchText
                      .toString()
                      .trim()
                      .isNotEmpty &&
                  _searchText
                      .toString()
                      .trim()
                      .length > 2) {
                arrFilterTaraContactInfo = [];
                if (arrTaraContactInfo.isNotEmpty) {
                  arrFilterTaraContactInfo = arrTaraContactInfo
                      .where((contact) =>
                       contact?.displayName??""
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
                    arrFilterTaraContactInfo.clear();
                  });
                }
              }
            },
            decoration: InputDecoration(
              // prefixIcon: Icon(
              //   Icons.search,
              //   color: Colors.black54,
              //   size: 20,
              // ),
              prefixIcon: Padding(
                padding: EdgeInsets.all(6.0),
                child: getSvgImage(imagePath: Assets.assets_icon_s_search,
                    width: 24.0,
                    height: 24.0),
              ),
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.transparent, width: 0.1)),
              hintText: getTranslation(Strings.SEARCH_CONTACT_OR_BANK),
              hintStyle: BaseStyles.hintTextStyle,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              suffixIcon: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: getSvgImage(imagePath: Assets.close_icon,
                      width: 24.0,
                      height: 24.0,
                      color: (_searchText != null &&
                          _searchText
                              .toString()
                              .isNotEmpty)
                          ? Colors.black54
                          : Colors.transparent)).onTap(onPressed: () {
                setState(() {
                  _searchText = "";
                  _searchQuery.text = "";
                  arrFilterTaraContactInfo.clear();
                });
              },
              ),


              //IconButton(
              // icon: Icon(
              //     Icons.clear,
              //     color: (_searchText != null &&
              //         _searchText
              //             .toString()
              //             .isNotEmpty)
              //         ? Colors.black54
              //         : Colors.transparent),
              //   onPressed: () {
              //     setState(() {
              //       _searchText = "";
              //       _searchQuery.text = "";
              //       arrFilterTaraContactInfo.clear();
              //     });
              //   },
              // ),
            ),
          ),
        ),
      ],
    );
  }

  Widget listViewContainer() {
    return Container(
      child: SectionTableView(
        sectionCount: 1,
        //for recent search, popular search and user search
        numOfRowInSection: (section) {
          if (_searchText
              .toString()
              .isNotEmpty && arrFilterTaraContactInfo.isEmpty) {
            return 0;
          }
          else {
            //default state when search not applied
            if (!(_searchText != null && _searchText
                .toString()
                .isNotEmpty)) {
              return arrTaraContactInfo.length;
            }
            //search applied
            else {
              return arrFilterTaraContactInfo.length;
            }
          }
        },

        cellAtIndexPath: (section, row) {
          if (_searchText
              .toString()
              .isNotEmpty && arrFilterTaraContactInfo.isEmpty) {
            return Container();
          }
          else {
            if (!(_searchText != null && _searchText
                .toString()
                .isNotEmpty)) {
              return getTaraContactItemWidget(arrTaraContactInfo[row], row);
            }
            //search applied
            else {
              return getTaraContactItemWidget(arrFilterTaraContactInfo[row], row);
            }
          }
        },

        headerInSection: (section) {
          return headerViewContainer();
        },
      ),
    );
  }

  getTaraContactItemWidget(Contact contactInfo, int index) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
        padding: EdgeInsets.all(8),
        height: 64,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                  color: const Color(0x1f000000),
                  offset: Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: 0),
              BoxShadow(
                  color: const Color(0x14000000),
                  offset: Offset(0, 0),
                  blurRadius: 2,
                  spreadRadius: 0)
            ],
            color: AppColors.primaryBackground),
        child: Center(
          child: Row(
            children: [
              // Image.asset(
              //   "assets/images/avatar-11.png",
              //   height: 32,
              //   width: 32,
              // ),
              Container(
                  padding: EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(4)
                      ),
                      color: Colors.blue,
                  ),
                  height: 32,
                  width: 32,
                  child: Text(contactInfo.initials())),
              Container(
                margin: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            contactInfo?.displayName ?? "Un Known",
                            textAlign: TextAlign.left,
                            style: BaseStyles
                                .transactionItemPersonNameTextStyle,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Image.asset(
                              Assets.tara_contacts,
                              height: 24,
                              width: 32,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        phoneNumberValidation(contactInfo),
                        textAlign: TextAlign.left,
                        style: BaseStyles.transactionItemDateTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        // if (index == 1) {
        //   // AuthResponse resposne = AuthResponse(customerProfile:customerProfile);
        //   push(ConversationPage(arrChats: ["decline_pay"],
        //     custInfo: Utils().getCustomerProfile(),)); //YAKUB Dummy Profile
        // } else {

          if(contactInfo.phones.elementAt(0).value!=null)
         // Get.to(BankTransferNewContact(taraContact: contactInfo,));
            sendBottomSheet();

        }
     // },
    );
  }



  String phoneNumberValidation(Contact contactInfo) {
    try{
      return contactInfo.phones.elementAt(0).value;
    }catch(Exception){
      return " ";
    }
  }

  Future sendBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return TransferDetailsEntryWidget();
        });
  }

}

