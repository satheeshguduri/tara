import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/utils/locale/utils.dart';

class CashDepositSelectContact extends StatefulWidget {
  final bool isFromSend;
  final bool isFromReceive;
  final bool isFromCashDeposit;
  final Function(ContactInfo) selectedContactCallback;
  CashDepositSelectContact({Key key,this.isFromSend=false,this.isFromReceive=false,this.selectedContactCallback,this.isFromCashDeposit=false}) : super(key: key);

  @override
  _CashDepositSelectContactState createState() =>
      _CashDepositSelectContactState();
}

class _CashDepositSelectContactState
    extends BaseState<CashDepositSelectContact> {
  TextEditingController _searchQuery = TextEditingController();
  String _searchText = "";
  final key = new GlobalKey<ScaffoldState>();
  List<ContactInfo> arrContactInfo = List();
  List<ContactInfo> arrTaraContactInfo = List();
  List<ContactInfo> arrFilterContactInfo = List();
  List<String> arrContactNames = [
    "Yakub Merchant New",
    "George G",
    "Simon S",
    "Yakub Y",
    "Harish H"
  ];
  List<String> arrContactPhoneNumbers = [
    "+91 88867 78633",
    "+62 821 3422 4366",
    "+62 821 3422 4367",
    "+62 821 3422 4368",
    "+62 821 3422 4369"
  ];

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.white,
      key: key,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0), // here the desired height
          child: _buildAppBar(context)),
      body:SafeArea(child:  _buildTaraAndAllContactsList(),), //bottom: true,top: false,
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    arrContactInfo = List();
    for (var i = 0; i < arrContactNames.length; i++) {
      var taraContact = ContactInfo();
      taraContact.name = arrContactNames[i];
      taraContact.phoneNumber = arrContactPhoneNumbers[i];
      taraContact.isTaraContact = true;
      arrTaraContactInfo.add(taraContact);
    }

    for (var i = 0; i < arrContactNames.length; i++) {
      var contact = ContactInfo();
      contact.name = arrContactNames[i];
      contact.phoneNumber = arrContactPhoneNumbers[i];
      contact.isTaraContact = false;
      arrContactInfo.add(contact);
    }
  }

  _buildTaraAndAllContactsList() {
    return Container(
        height: MediaQuery.of(context).size.height-16,
//        margin: EdgeInsets.only(top: 8,bottom: 16,),
        child: listViewContainer());
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:4),
      child: AppBar(
        elevation: 0.5,
        centerTitle: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.pop(context, false) //Navigator.pop(context, false),
        ),
        title: Container(
          height: 40,
          margin: EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: new Border.all(color: Colors.grey, width: 1),
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
                arrFilterContactInfo = List();
                if (arrContactInfo.length > 0) {
                  arrFilterContactInfo = arrContactInfo
                      .where((contact) => contact.name
                      .toLowerCase()
                      .contains(_searchText.toLowerCase()))
                      .toList();
                  if (arrFilterContactInfo.length > 0) {
                    setState(() {});
                  }
                }
              } else {
                if (_searchQuery.text == "") {
                  setState(() {
                    _searchText = "";
                    _searchQuery.text = "";
                    arrFilterContactInfo.clear();
                  });
                }
              }
            },
            decoration: new InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black54,
                size: 20,
              ),
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0.1)),
              hintText: getTranslation(Strings.SEARCH_CONTACT),
              hintStyle: BaseStyles.hintTextStyle,
              focusedBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.transparent)),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear,
                    color: (_searchText != null &&
                        _searchText.toString().isNotEmpty &&
                        _searchText.toString().length > 0)
                        ? Colors.black54
                        : Colors.transparent),
                onPressed: (){
                  setState(() {
                    _searchText = "";
                    _searchQuery.text = "";
                    arrFilterContactInfo.clear();
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget listViewContainer() {
    return Container(
      child: SectionTableView(
        sectionCount:
            (_searchText != null && _searchText.toString().trim().isNotEmpty) ? 1 : 2,
        //for recent search, popular search and user search
        numOfRowInSection: (section) {
          //default state when search not applied
          if (!(_searchText != null && _searchText.toString().trim().isNotEmpty)) {
            if (section == 0) {
              return arrTaraContactInfo.length;
            } else {
              return arrContactInfo.length;
            }
          }
          //search applied
          else {
            return arrFilterContactInfo.length;
          }
        },

        cellAtIndexPath: (section, row) {
          if (!(_searchText != null && _searchText.toString().trim().isNotEmpty)) {
            if (arrTaraContactInfo.length > 0 && section == 0) {
              return getContactItemWidget(arrTaraContactInfo[row]);
            } else {
              return getContactItemWidget(arrContactInfo[row]);
            }
          }
          //search applied
          else {
            return getContactItemWidget(arrFilterContactInfo[row]);
          }
        },

        headerInSection: (section) {
          if (!(_searchText != null && _searchText.toString().trim().isNotEmpty)) {
            if (arrTaraContactInfo.length > 0 && section == 0) {
              return headerViewContainer(getTranslation(Strings.TARA_CONTACTS));
            } else {
              return headerViewContainer(getTranslation(Strings.ALL_CONTACTS));
            }
          } else {
            return headerViewContainer(getTranslation(Strings.SEARCHED_CONTACTS));
          }
        },
      ),
    );
  }

  headerViewContainer(String headerTitle) {
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(headerTitle, style: BaseStyles.contactsHeaderTextStyle),
        ));
  }

  getContactItemWidget(ContactInfo contactInfoTemp) {
    return InkWell(
      onTap: (){
        if (widget.isFromSend != null && widget.isFromSend == true) {
          push(ConversationPage(isFromSend: true,selectedContact: contactInfoTemp,custInfo: Utils().getCustomerProfile()));//YAKUB Dummy Profile
        }else  if (widget.isFromReceive != null && widget.isFromReceive == true) {
          push(ConversationPage(isFromReceive: true,selectedContact: contactInfoTemp,custInfo: Utils().getCustomerProfile()));//YAKUB Dummy Profile
        }
        else if (widget.isFromCashDeposit != null && widget.isFromCashDeposit == true) {
          widget.selectedContactCallback(contactInfoTemp);
          Navigator.pop(context, false);
        }
        else{
          push(ConversationPage(selectedContact: contactInfoTemp,custInfo: Utils().getCustomerProfile(),));
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 4,bottom: 4),
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
              contactInfoTemp.isTaraContact == true
                  ? Image.asset(
                "assets/images/avatar-11.png",
                height: 32,
                width: 32,
              )
                  : bigCircle(contactInfoTemp.name),
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
                            contactInfoTemp.name,
                            textAlign: TextAlign.left,
                            style: BaseStyles.transactionItemPersonNameTextStyle,
                          ),
                        ),
                        contactInfoTemp.isTaraContact == true
                            ? Align(
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
                            : Container()
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        contactInfoTemp.phoneNumber,
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
    );
  }

  Widget bigCircle(String name) {
    return Container(
        width: 32,
        height: 32,
        decoration: new BoxDecoration(
          color: Color(0xff123456),
          shape: BoxShape.circle,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(name.length > 0 ? name.substring(0, 1).toUpperCase() : "",
              style: BaseStyles.contactsTextStyle, textAlign: TextAlign.center),
        ));
  }
}

