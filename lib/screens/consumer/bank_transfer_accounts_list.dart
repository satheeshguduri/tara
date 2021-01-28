import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/common/widgets/dashed_line_border_button.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/controller/contacts_transfer_controller.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/models/transfer/search_beneficiary_response.dart';
import 'package:tara_app/models/transfer/transaction_history_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:tara_app/screens/consumer/bank_transfer_new_contact.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/screens/consumer/transfer_details_entry_screen.dart';


class BankTransferAccountsList extends StatefulWidget {


  BankTransferAccountsList({Key key,}) : super(key: key);

  @override
  BankTransferAccountsListState createState() =>
      BankTransferAccountsListState();

}

class BankTransferAccountsListState extends BaseState<BankTransferAccountsList> {

  final TextEditingController _searchQuery = TextEditingController();
  TransactionController controller = Get.find();
  ContactsTransferController contactsController = ContactsTransferController();


  final key = GlobalKey<ScaffoldState>();
 // List<BankAccountContactInfo> contactsController.contactList = [];
  //List<Contact> arrRecentlyAddedContactInfo = [];
 // List<BankAccountContactInfo> contactsController.filteredContactList = [];
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
     // appBar: _buildAppBar(context),
      appBar: CustomAppBarWidget(title:getTranslation(Strings.TRANSFER_TO_BANK_ACCOUNT),addNewWidgetShow: false,),

      body: Obx(()=>SafeArea(child: _buildTaraAndAllContactsList().withProgressIndicator(showIndicator: contactsController.showProgress.value))),
    );
  }












  @override
  void initState()  {
    super.initState();
    contactsController.loadData();
    // loadData();
    contactsController.getBeneficiaries();
  }

  // void loadData() {
  //   contactsController.contactList = [];
  //   for (var i = 0; i < arrContactNames.length; i++) {
  //     var taraContact = BankAccountContactInfo();
  //     taraContact.name = arrContactNames[i];
  //     taraContact.accountNumber = arrContactBankAccounts[i];
  //     taraContact.isRecentlyContact = true;
  //     arrRecentlyAddedContactInfo.add(taraContact);
  //   }
  //
  //   for (var i = 0; i < arrContactNames.length; i++) {
  //     var contact = BankAccountContactInfo();
  //     contact.name = arrContactNames[i];
  //     contact.accountNumber = arrContactBankAccounts[i];
  //     contact.isRecentlyContact = false;
  //     contactsController.contactList.add(contact);
  //   }
  // }

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
    // return Container(
    //   margin: EdgeInsets.only(top: 16,left: 16,right: 16),
    //   height: 50,
    //   child: Stack(
    //     children: <Widget>[
    //       Positioned(
    //         top: 8.0,
    //         child:Container(
    //           height:16,
    //           width: 85,
    //           margin: EdgeInsets.only(top: 8),
    //           decoration: BoxDecoration(
    //             color: AppColors.bottom_border_color,
    //           ),
    //           child: Container(),
    //         ),
    //       ),
    //       Positioned(
    //         top: 0.0,
    //         child: Container(
    //           child: Text(
    //             getTranslation(Strings.CONTACT_LIST),
    //             textAlign: TextAlign.left,
    //             style: BaseStyles.bankAccountHeaderTitleStyle,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  return  Container(margin:EdgeInsets.only(left: 16),child: TextWithBottomOverlay(titleStr: getTranslation(Strings.CONTACT_LIST)));

  }

  Widget listViewContainer() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SectionTableView(
        sectionCount:
        (contactsController.searchText != null && contactsController.searchText.toString().isNotEmpty) ? 1 : 2,
        //for recent search, popular search and user search
        numOfRowInSection: (section) {
          if (contactsController.searchText
              .toString()
              .isNotEmpty && contactsController.filteredContactList.isEmpty)
          {
            return 0;
          }
          else {
            //default state when search not applied
            if (!(contactsController.searchText != null && contactsController.searchText
                .toString()
                .isNotEmpty)) {
              if (section == 0) {
                return contactsController.arrRecentlyAddedContactInfo.length;
              } else {
                return contactsController.contactList.length;
              }
            }
            //search applied
            else {
              return contactsController.filteredContactList.length;
            }
          }
        },

        cellAtIndexPath: (section, row) {
          if (contactsController.searchText
              .toString()
              .isNotEmpty && contactsController.filteredContactList.isEmpty)
          {
            return Container();
          }
          else {
            if (!(contactsController.searchText != null && contactsController.searchText
                .toString()
                .isNotEmpty)) {
              if (contactsController.arrRecentlyAddedContactInfo.isNotEmpty && section == 0) {
                return getContactItemWidget(null,contactsController.arrRecentlyAddedContactInfo[row]);
              } else {
                return getContactItemWidget(contactsController.contactList[row],null);
              }
            }
            //search applied
            else {
              return getContactItemWidget(contactsController.filteredContactList[row],null);
            }
          }
        },

        headerInSection: (section) {
          if (contactsController.searchText
              .toString()
              .isNotEmpty && contactsController.filteredContactList.isEmpty)
          {
            return headerViewContainer(
                getTranslation(Strings.SEARCHED_ACCOUNTS));
          }
          else {
            if (!(contactsController.searchText != null && contactsController.searchText
                .toString()
                .isNotEmpty)) {
              if (contactsController.arrRecentlyAddedContactInfo.isNotEmpty && section == 0) {
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
        (contactsController.searchText
            .toString()
            .isNotEmpty && contactsController.filteredContactList.isEmpty)?Container(
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
            border: Border.all(color: (contactsController.searchText.toString().isNotEmpty)?AppColors.header_top_bar_color:Colors.grey[400], width: 1),
          ),
          child: TextField(
            controller: contactsController.searchQuery,
            keyboardType: TextInputType.text,
            style: BaseStyles.baseTextStyle,
            cursorColor: Colors.black,
            autofocus: false,
            onChanged: (value) {
              contactsController.filterTheContacts(value);
              // contactsController.searchText = value;
              // if (contactsController.searchText != null &&
              //     contactsController.searchText.toString().trim().isNotEmpty &&
              //     contactsController.searchText.toString().trim().length > 2) {
              //   contactsController.filteredContactList = [];
              //   if (contactsController.contactList.isNotEmpty) {
              //     contactsController.filteredContactList = contactsController.contactList
              //         .where((contact) => contact.name
              //         .toLowerCase()
              //         .contains(contactsController.searchText.toLowerCase()))
              //         .toList();
              //   }
              //   setState(() {
              //
              //   });
              // } else {
              //   if (_searchQuery.text == "") {
              //     setState(() {
              //       contactsController.searchText = "";
              //       _searchQuery.text = "";
              //       contactsController.filteredContactList.clear();
              //     });
              //   }
              // }
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
              suffixIcon:  Padding(
                padding: EdgeInsets.all(6.0),
              child: getSvgImage(imagePath: Assets.close_icon,
                  width: 24.0,
                  height: 24.0,
                  color: (contactsController.searchText != null &&
                      contactsController.searchText
                          .toString()
                          .isNotEmpty)
                      ? Colors.black54
                      : Colors.transparent)).onTap(onPressed: () {

            contactsController.searchText = "";
            contactsController.searchQuery.text = "";
            contactsController.filteredContactList.value.clear();
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
  Widget getContactItemWidget([Contact contactInfo,BeneDetailBean recentContactInfo]) {
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
                    width:getWidth(contactInfo?.displayName ?? "Un Known"),
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                     // contactInfo?.displayName ?? "Un Known",
                      contactInfo!=null?contactInfo?.displayName ?? "Un Known":recentContactInfo?.beneName ?? "Un Known",
                      //contactInfo.name,
                      textAlign: TextAlign.left,
                      style: BaseStyles.transactionItemPersonNameTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                     // phoneNumberValidation(contactInfo),
                      contactInfo!=null?phoneNumberValidation(contactInfo):recentContactInfo?.beneMobile ?? "0000",
                      //contactInfo.accountNumber,
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
    ).onTap(onPressed: (){
      Contact  taraContactParam =  contactInfo!=null?contactInfo:null;
      BeneDetailBean  beneContactParam =  recentContactInfo!=null?recentContactInfo:null;
       Get.to(TransferDetailsEntryScreen(taraContact:taraContactParam,beneContact: beneContactParam));
    });
  }

  errorTitleTextWidget() {
    return Container(
      margin: EdgeInsets.only(top: 16,),
      child: Text(
        getTranslation(Strings.we_cannot_find_anything) +
            "\"${contactsController.searchText.toString()}\"",
        style: BaseStyles.cannotFindTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  String phoneNumberValidation(Contact contactInfo) {
    try{
      return contactInfo.phones.elementAt(0).value;
    }catch(Exception){
      return " ";
    }
  }

  double getWidth(String s) {
    if(s.length>30)
      return Get.width*0.6;
  }



}

class BankAccountContactInfo {
  String name;
  bool isRecentlyContact;
  String accountNumber;
}
