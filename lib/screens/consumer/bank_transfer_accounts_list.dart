import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/dashed_line_border_button.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:tara_app/screens/chat/send_money.dart';
import 'package:tara_app/screens/consumer/bank_transfer_new_contact.dart';
import 'package:tara_app/screens/consumer/enter_mpin.dart';

class BankTransferAccountsList extends StatefulWidget {
  final bool isFromSend;

  BankTransferAccountsList({Key key,this.isFromSend}) : super(key: key);

  @override
  _BankTransferAccountsListState createState() =>
      _BankTransferAccountsListState();
}

class _BankTransferAccountsListState
    extends BaseState<BankTransferAccountsList> {
  final TextEditingController _searchQuery = TextEditingController();
  String _searchText = "";
  final key = GlobalKey<ScaffoldState>();
  List<BankAccountContactInfo> arrContactInfo = [];
  List<BankAccountContactInfo> arrRecentlyAddedContactInfo = [];
  List<BankAccountContactInfo> arrFilterContactInfo = [];
  List<String> arrContactNames = [
    "Kiran Kumar Y",
    "George G",
    "Simon S",
    "Yakub Y",
    "Harish H"
  ];
  List<String> arrContactBankAccounts = [
    "BCA....4421",
    "BNI....1233",
    "Mandiri....2124",
    "BTPN....5521",
    "BNI....1231"
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
      body: SafeArea(child: _buildTaraAndAllContactsList(),),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    arrContactInfo = [];
    for (var i = 0; i < arrContactNames.length; i++) {
      var taraContact = BankAccountContactInfo();
      taraContact.name = arrContactNames[i];
      taraContact.accountNumber = arrContactBankAccounts[i];
      taraContact.isRecentlyContact = true;
      arrRecentlyAddedContactInfo.add(taraContact);
    }

    for (var i = 0; i < arrContactNames.length; i++) {
      var contact = BankAccountContactInfo();
      contact.name = arrContactNames[i];
      contact.accountNumber = arrContactBankAccounts[i];
      contact.isRecentlyContact = false;
      arrContactInfo.add(contact);
    }
  }

  Widget _buildTaraAndAllContactsList() {
    return listViewContainer();
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
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
          getTranslation(Strings.TRANSFER_TO_BANK_ACCOUNT),
          textAlign: TextAlign.left,
          style: BaseStyles.topBarTextStyle,
        ),
      ),
    );
  }

  Widget contactListTitleWidget()
  {
    return Container(
      margin: EdgeInsets.only(top: 16,left: 16,right: 16),
      height: 50,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 8.0,
            child:Container(
              height:16,
              width: 85,
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: AppColors.bottom_border_color,
              ),
              child: Container(),
            ),
          ),
          Positioned(
            top: 0.0,
            child: Container(
              child: Text(
                getTranslation(Strings.CONTACT_LIST),
                textAlign: TextAlign.left,
                style: BaseStyles.bankAccountHeaderTitleStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listViewContainer() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SectionTableView(
        sectionCount:
        (_searchText != null && _searchText.toString().isNotEmpty) ? 1 : 2,
        //for recent search, popular search and user search
        numOfRowInSection: (section) {
          if (_searchText
              .toString()
              .isNotEmpty && arrFilterContactInfo.isEmpty)
          {
            return 0;
          }
          else {
            //default state when search not applied
            if (!(_searchText != null && _searchText
                .toString()
                .isNotEmpty)) {
              if (section == 0) {
                return arrRecentlyAddedContactInfo.length;
              } else {
                return arrContactInfo.length;
              }
            }
            //search applied
            else {
              return arrFilterContactInfo.length;
            }
          }
        },

        cellAtIndexPath: (section, row) {
          if (_searchText
              .toString()
              .isNotEmpty && arrFilterContactInfo.isEmpty)
          {
            return Container();
          }
          else {
            if (!(_searchText != null && _searchText
                .toString()
                .isNotEmpty)) {
              if (arrRecentlyAddedContactInfo.isNotEmpty && section == 0) {
                return getContactItemWidget(arrRecentlyAddedContactInfo[row]);
              } else {
                return getContactItemWidget(arrContactInfo[row]);
              }
            }
            //search applied
            else {
              return getContactItemWidget(arrFilterContactInfo[row]);
            }
          }
        },

        headerInSection: (section) {
          if (_searchText
              .toString()
              .isNotEmpty && arrFilterContactInfo.isEmpty)
          {
            return headerViewContainer(
                getTranslation(Strings.SEARCHED_ACCOUNTS));
          }
          else {
            if (!(_searchText != null && _searchText
                .toString()
                .isNotEmpty)) {
              if (arrRecentlyAddedContactInfo.isNotEmpty && section == 0) {
                return headerViewContainer(
                    getTranslation(Strings.RECENTLY_ADDED));
              } else {
                return headerViewContainer(
                    getTranslation(Strings.ALL_ACCOUNTS));
              }
            } else {
              return headerViewContainer(
                  getTranslation(Strings.SEARCHED_ACCOUNTS));
            }
          }
        },
      ),
    );
  }

  Widget headerViewContainer(String headerTitle) {
    return Column(
      children: [
        (headerTitle==getTranslation(Strings.RECENTLY_ADDED) || headerTitle==getTranslation(Strings.SEARCHED_ACCOUNTS))? getSearchBarWidget():Container(),
        (headerTitle==getTranslation(Strings.RECENTLY_ADDED) || headerTitle==getTranslation(Strings.SEARCHED_ACCOUNTS))?contactListTitleWidget():Container(),
        (headerTitle==getTranslation(Strings.RECENTLY_ADDED) || headerTitle==getTranslation(Strings.SEARCHED_ACCOUNTS))?Container(
          margin: EdgeInsets.only(bottom: 8),
          child: DashedLineBorderButton(buttonText: getTranslation(Strings.SEND_TO_NEW_ACCOUNT),buttonColor: Color(0xfff7f7fa),
          onPressed: (){
           push(BankTransferNewContact());
          },),
        ):Container(),
        Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(headerTitle, style: BaseStyles.backAccountHeaderTextStyle),
            )),
        (_searchText
            .toString()
            .isNotEmpty && arrFilterContactInfo.isEmpty)?Container(
          child: Center(
            child: errorTitleTextWidget(),
          ),
        ):Container(),
      ],
    );
  }

  Widget getSearchBarWidget()
  {
    return Column(
      children: [
        Container(
          height: 40,
          margin: EdgeInsets.only(
            left: 16,
            right: 16,
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
                arrFilterContactInfo = [];
                if (arrContactInfo.isNotEmpty) {
                  arrFilterContactInfo = arrContactInfo
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
                    arrFilterContactInfo.clear();
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
              hintText: getTranslation(Strings.SEARCH_CONTACT_OR_BANK),
              hintStyle: BaseStyles.hintTextStyle,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              suffixIcon:  IconButton(
                icon: Icon(Icons.clear,
                    color: (_searchText != null &&
                        _searchText.toString().isNotEmpty)
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
        Container(
          margin: EdgeInsets.only(top: 16),
          color: Colors.grey[200],
          height: 1,
        )
      ],
    );
  }
  Widget getContactItemWidget(BankAccountContactInfo contactInfo) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 8),
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
          child:
          Row(
            children: [
              Image.asset(
                "assets/images/avatar-11.png",
                height: 32,
                width: 32,
              ),
              Container(
                margin: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        contactInfo.name,
                        textAlign: TextAlign.left,
                        style: BaseStyles.transactionItemPersonNameTextStyle,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        contactInfo.accountNumber,
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
        if (widget.isFromSend != null && widget.isFromSend == true) {
          sendBottomSheet(contactInfo);
        }
        else {
          push(BankTransferNewContact(bankAccInfo: contactInfo,));
        }
      }
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

  Future  sendBottomSheet(BankAccountContactInfo contactInfo) {
    return showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return SendWidget(selectedContact:contactInfo);
        });
  }



}

class BankAccountContactInfo {
  String name;
  bool isRecentlyContact;
  String accountNumber;
}
