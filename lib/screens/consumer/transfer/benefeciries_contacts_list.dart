import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/common/widgets/base_widgets.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/common/widgets/dashed_line_border_button.dart';
import 'package:tara_app/common/widgets/text_with_bottom_overlay.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/controller/contacts_transfer_controller.dart';
import 'package:tara_app/controller/transaction_controller.dart';
import 'package:tara_app/injector.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/auth/registration_status.dart';
import 'package:tara_app/models/transfer/search_beneficiary_response.dart';
import 'package:tara_app/models/transfer/transaction_history_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:tara_app/screens/consumer/bank_transfer_new_contact.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/screens/consumer/transfer_details_entry_screen.dart';


class BensAndContactsScreen extends StatefulWidget {

  @override
  BensAndContactsScreenState createState() =>
      BensAndContactsScreenState();
}

class BensAndContactsScreenState extends BaseState<BensAndContactsScreen> {

  final TextEditingController _searchQuery = TextEditingController();
  TransactionController controller = Get.find();
  ContactsTransferController contactsController = Get.find();
  final key = GlobalKey<ScaffoldState>();

  @override
  BuildContext getContext() => context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: key,
      appBar: CustomAppBarWidget(title:getTranslation(Strings.TRANSFER_TO),addNewWidgetShow: false,),
      body: Obx(()=>SafeArea(
          child: _buildTaraAndAllContactsList().withProgressIndicator(showIndicator: contactsController.showProgress.value))),
    );
  }

  @override
  void initState()  {
    super.initState();
    contactsController.loadData();
    contactsController.getBeneficiaries();

  }

  Widget _buildTaraAndAllContactsList() {
    return ListView(
      children: [
         selfAccountWidget(),
        // getSearchBarWidget(),
        (contactsController.arrRecentlyAddedContactInfo.length>0)?debitCardsHeadingWidget("Beneficiaries"):Container(),
        beneListView(),
        debitCardsHeadingWidget("All Contacts"),
        allAccountListView(),
      ],
    );
  }

  Widget contactListTitleWidget() => Container(margin:EdgeInsets.only(left: 16),child: TextWithBottomOverlay(titleStr: getTranslation(Strings.CONTACT_LIST)));

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
  Widget getContactItemWidget({Contact contactInfo,BeneDetailBean recentContactInfo}) {
    var name = contactInfo?.displayName ?? recentContactInfo?.beneName ?? "Un Known";
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
            BaseWidgets.bigCircle(name),
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
    ).onTap(onPressed: () async{
      Contact  taraContactParam =  contactInfo;
      BeneDetailBean  beneContactParam =  recentContactInfo;
      var selectedMobile = contactInfo?.phones?.elementAt(0)?.value?.removeAllWhitespace;
      var selectedContactName = contactInfo?.displayName;
      if(contactInfo!=null){
        selectedMobile = contactInfo?.phones?.elementAt(0)?.value?.removeAllWhitespace;
        selectedContactName = contactInfo?.displayName;
      }else{
        selectedMobile = recentContactInfo.beneMobile.removeAllWhitespace;
        selectedContactName = recentContactInfo.beneName.removeAllWhitespace;
      }

      if(selectedMobile?.isNotEmpty??false){
        contactsController.arrRecentlyAddedContactInfo.value = contactsController.arrRecentlyAddedContactInfo?.value?.where((element) => element.beneMobile?.contains(selectedMobile))?.toList();
        // Get.to(TransferDetailsEntryScreen(taraContact:taraContactParam,beneContact: beneContactParam,list:beneficiaryAccountList));
        // arrRecentlyAddedContactInfo == benficiearies
        //{"mobile":"999999999",account:"1234467890"}
        //

        if( contactsController.arrRecentlyAddedContactInfo?.isNotEmpty??false){ // if benefecialries exists
          print("first");
          var benDetails =  contactsController.arrRecentlyAddedContactInfo[0];
          var customerInfo = CustomerProfile(mobileNumber: benDetails.beneMobile, firstName:benDetails.beneName,registrationStatus: RegistrationStatus.BENEFICIARY);
          Get.to(TransferDetailsEntryScreen(taraContact:taraContactParam,beneContact: beneContactParam,benList:  contactsController.arrRecentlyAddedContactInfo.value,customerProfile: customerInfo,));
        }else{ // check for Tara user
          print("second");
          var toAddrResp = await Get.find<AuthController>().getToAddressForPayment(selectedMobile);
          if(toAddrResp.isRight()){
            var toContactInfo = toAddrResp.getOrElse(() => null);
            Get.to(TransferDetailsEntryScreen(taraContact:taraContactParam,beneContact: beneContactParam,customerProfile: toContactInfo.customerProfile,));
          }else{
            print("third");
            //user doesnot exist
            var customerInfo = CustomerProfile(mobileNumber: selectedMobile, firstName:selectedContactName,registrationStatus: RegistrationStatus.INACTIVE);
            Get.to(TransferDetailsEntryScreen(taraContact:taraContactParam,beneContact: beneContactParam,customerProfile: customerInfo,));
          }
        }
      }else{
        //Alert no accociated mobile
      }


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

  Widget debitCardsHeadingWidget(String heading) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(heading, style: BaseStyles.backAccountHeaderTextStyle),
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


  Widget beneListView() {
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: contactsController.arrRecentlyAddedContactInfo.length,
        itemBuilder: (context, index) {
          return getContactItemWidget(recentContactInfo: contactsController.arrRecentlyAddedContactInfo[index]);
        });
  }



  Widget allAccountListView() {

    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: getItemCount(),
        itemBuilder: (context, index) {
          if (!(contactsController.searchText != null && contactsController.searchText.toString().isNotEmpty)) {
            if (contactsController.contactList.isNotEmpty) {
              return getContactItemWidget(contactInfo: contactsController.contactList[index]);
            } else {
              return Container();
            }
          }
          //search applied
          else {
            return getContactItemWidget(contactInfo:contactsController.filteredContactList[index]);


          }


        });
  }

 int getItemCount() {
  return  !(contactsController.searchText != null && contactsController.searchText.toString().isNotEmpty)?
            contactsController.contactList.length:
            contactsController.filteredContactList.length;

  }

 Widget selfAccountWidget() {
  return Container(
    height:64,
    padding: EdgeInsets.only(left: 16),
    margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
    decoration: getSelfAccoundWidgetDecoration(),
    child: Row(
      children: [
        getSvgImage(imagePath: Assets.illustration_transfer_to_my_account,width: 40.0,height: 40.0),
        SizedBox(width:8,),
        Text("My Account",style: TextStyles.subtitle1222)

      ],
    ),
  ).onTap(onPressed: (){
   // var customerInfo = CustomerProfile(registrationStatus: RegistrationStatus.RTP);
    print("status"+Get.find<AuthController>().user.value.customerProfile.registrationStatus.toString());
    Get.to(TransferDetailsEntryScreen(isSelf:true,customerProfile: Get.find<AuthController>().user.value.customerProfile));
  });
  }

  BoxDecoration getSelfAccoundWidgetDecoration() {
   return  BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(8)
        ),
        boxShadow: [BoxShadow(
            color: const Color(0x1f000000),
            offset: Offset(0,4),
            blurRadius: 6,
            spreadRadius: 0
        ), BoxShadow(
            color: const Color(0x14000000),
            offset: Offset(0,0),
            blurRadius: 2,
            spreadRadius: 0
        )] ,
        color: AppColors.elevation_off_2_2_2
    );
  }

}

class BankAccountContactInfo {
  String name;
  bool isRecentlyContact;
  String accountNumber;
}
