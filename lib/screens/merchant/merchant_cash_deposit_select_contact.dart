import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';

class CashDepositSelectContact extends StatefulWidget {
  CashDepositSelectContact({Key key}) : super(key: key);

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
    "Kiran Kumar Y",
    "George G",
    "Simon S",
    "Yakub Y",
    "Harish H"
  ];
  List<String> arrContactPhoneNumbers = [
    "+62 821 3422 4365",
    "+62 821 3422 4366",
    "+62 821 3422 4367",
    "+62 821 3422 4368",
    "+62 821 3422 4369"
  ];

  @override
  BuildContext getContext() {
    return this.context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: _buildAppBar(context)),
      body: _buildTaraAndAllContactsList(),
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
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(bottom: 16, top: 8),
        child: listViewContainer());
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.1,
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
                _searchText.toString().isNotEmpty &&
                _searchText.toString().length > 2) {
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
            hintText: Strings.SEARCH_CONTACT,
            hintStyle: BaseStyles.hintTextStyle,
            focusedBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.transparent)),
            suffixIcon: InkWell(
              onTap: () => () {
                setState(() {
                  _searchText = "";
                  _searchQuery.text = "";
                  arrFilterContactInfo.clear();
                });
              },
              child: Icon(Icons.clear,
                  color: (_searchText != null &&
                          _searchText.toString().isNotEmpty &&
                          _searchText.toString().length > 0)
                      ? Colors.black54
                      : Colors.transparent),
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
            (_searchText != null && _searchText.toString().isNotEmpty) ? 1 : 2,
        //for recent search, popular search and user search
        numOfRowInSection: (section) {
          //default state when search not applied
          if (!(_searchText != null && _searchText.toString().isNotEmpty)) {
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
          if (!(_searchText != null && _searchText.toString().isNotEmpty)) {
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
          if (!(_searchText != null && _searchText.toString().isNotEmpty)) {
            if (arrTaraContactInfo.length > 0 && section == 0) {
              return headerViewContainer(Strings.TARA_CONTACTS);
            } else {
              return headerViewContainer(Strings.ALL_CONTACTS);
            }
          } else {
            return headerViewContainer(Strings.SEARCHED_CONTACTS);
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

  getContactItemWidget(ContactInfo contactInfo) {
    return Container(
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
        child: Row(
          children: [
            contactInfo.isTaraContact == true
                ? Image.asset(
                    "assets/images/avatar-11.png",
                    height: 32,
                    width: 32,
                  )
                : bigCircle(contactInfo.name),
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
                          contactInfo.name,
                          textAlign: TextAlign.left,
                          style: BaseStyles.transactionItemPersonNameTextStyle,
                        ),
                      ),
                      contactInfo.isTaraContact == true
                          ? Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Image.asset(
                                  Assets.tara_contacts,
                                  height: 32,
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
                      contactInfo.phoneNumber,
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

class ContactInfo {
  String name;
  bool isTaraContact;
  String phoneNumber;
}