import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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
import 'package:tara_app/models/transfer/constants/request_type.dart';
import 'package:tara_app/models/transfer/search_beneficiary_response.dart';
import 'package:tara_app/models/transfer/transaction_history_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/screens/consumer/bank_transfer_new_contact.dart';
import 'package:tara_app/common/constants/values.dart';
import 'package:tara_app/screens/consumer/transfer_details_entry_screen.dart';
import 'package:tara_app/services/config/api.dart';


class BeneficiariesContactsListScreen extends StatefulWidget {

  
  final RequestType requestType;
  @override
  BeneficiariesContactsListScreenState createState() =>
      BeneficiariesContactsListScreenState();

  BeneficiariesContactsListScreen({this.requestType});
}

class BeneficiariesContactsListScreenState extends BaseState<BeneficiariesContactsListScreen> {

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
  }
  @override
  init() async {
    await contactsController.getBeneficiaries();
    setState(() {});//refreshing the beneficiaries
  }
  String getGroupHeader(RegistrationStatus status){
    switch(status){
      case RegistrationStatus.BENEFICIARY:
        return "My Beneficiaries";
        break;
      case RegistrationStatus.TARA:
      case RegistrationStatus.RTP:
      case RegistrationStatus.INACTIVE:
        return "All Contacts";
        break;
      default:
        return "All Contacts";
    }
  }
  Widget getGroupedList(){

    if(contactsController.searchInProgress.value && contactsController.filteredContactsList.value.isEmpty){
      return errorTitleTextWidget();
    }
    else {
      return Container(

        child: GroupedListView<CustomerProfile, String>(
          elements: contactsController.searchInProgress.value
              ? contactsController.filteredContactsList.value
              : contactsController.totalContactsList.value,
          groupBy: (element) => getGroupHeader(element.registrationStatus),
          groupSeparatorBuilder: (String groupByValue) =>
              debitCardsHeadingWidget(groupByValue),
          itemBuilder: (context, CustomerProfile element) =>
              getListItemWidget(customerProfile: element),
          groupComparator: (item1, item2) => item2.compareTo(item1),
          // optional
          // useStickyGroupSeparators: true, // optional
          // floatingHeader: true, // optional
          order: GroupedListOrder.ASC, // optional
        ),
      );
    }
  }
  Widget _buildTaraAndAllContactsList() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
          getSearchBarWidget(),
          widget.requestType == RequestType.PAY? selfAccountWidget():Container(),
          Expanded(child: getGroupedList()),
      ],
    );
  }

  Widget contactListTitleWidget() => Container(margin:EdgeInsets.only(left: 16),child: TextWithBottomOverlay(titleStr: getTranslation(Strings.CONTACT_LIST)));

  Widget getSearchBarWidget() {
    return Column(
      children: [
        Container(
          height: 40,
          margin: EdgeInsets.only(
            left: 16,
            right: 16,
            top:16,
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
              contactsController.searchContact(value);
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

                contactsController.searchText.value = "";
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

  Widget getListItemWidget({CustomerProfile customerProfile}) {
    var name = customerProfile.firstName;
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 8),
      padding: EdgeInsets.all(8),
      height: 64,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: Shadows.shadows_list_3,
          color: AppColors.primaryBackground),
      child: Center(
        child:
        Row(
          children: [
            // BaseWidgets.bigCircle(name),
            getSvgImage(imagePath:Assets.assets_icon_user,width:32.0,height:32.0),
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      name,
                      textAlign: TextAlign.left,
                      style: BaseStyles.transactionItemPersonNameTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      customerProfile.mobileNumber,
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

        contactsController.showProgress.value = true;
        var correctedPhoneNumber  = await PhoneNumber.getRegionInfoFromPhoneNumber(customerProfile.mobileNumber,'IN'); //TODO CHANGE THE LOCALE
        customerProfile.mobileNumber = correctedPhoneNumber.phoneNumber;
        var toAddrResp = await Get.find<AuthController>().getToAddressForPayment(customerProfile.mobileNumber.substring(1,customerProfile.mobileNumber.length));
        if(toAddrResp.isRight()){
          var customerInfoResponse =  toAddrResp.getOrElse(() => null);
          if(customerInfoResponse?.customerProfile!=null){
            customerProfile = customerInfoResponse.customerProfile;
            if(customerProfile.registrationStatus==null){
              customerProfile.registrationStatus = RegistrationStatus.INACTIVE;
            }
          }
        }
        contactsController.showProgress.value = false;
        if(widget.requestType == RequestType.PAY) {
          handleNonTaraFlow(customerProfile);
        }else{
          if(customerProfile.registrationStatus == RegistrationStatus.INACTIVE){
            showToast(message: "The user does not registered with Tara");
          }else if(customerProfile?.firebaseId?.isNotEmpty??false){
            Get.to(ConversationPage(isFromReceive: true,selectedContact: ContactInfo(),custInfo: customerProfile));
          }
        }

    });
  }
  handleNonTaraFlow(CustomerProfile customerProfile)async {
    if(customerProfile.registrationStatus == RegistrationStatus.BENEFICIARY){// dint find the user in tara
      contactsController.arrRecentlyAddedContactInfo.value = contactsController.arrRecentlyAddedContactInfo?.value?.where((element) => customerProfile.mobileNumber?.contains(element.beneMobile))?.toList();
    }
    Get.to(TransferDetailsEntryScreen(toCustomerProfile: customerProfile,requestType: widget.requestType,));
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
        // (contactsController.searchText
        //     .toString()
        //     .isNotEmpty && contactsController.filteredContactList.isEmpty)?Container(
        //   child: Center(
        //     child: errorTitleTextWidget(),
        //   ),
        // ):Container(),
      ],
    );
  }

 Widget selfAccountWidget() {
  return Container(
    height:64,
    padding: EdgeInsets.only(left: 16),
    margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
    decoration: getSelfAccoundWidgetDecoration(),
    child: Row(
      children: [
        //getSvgImage(imagePath: Assets.illustration_transfer_to_my_account,width: 40.0,height: 40.0),
        SizedBox(width:8,),
        Text("My Account",style: TextStyles.subtitle1222)
      ],
    ),
  ).onTap(onPressed: (){
   // var customerInfo = CustomerProfile(registrationStatus: RegistrationStatus.RTP);
    print("status"+Get.find<AuthController>().user.value.customerProfile.registrationStatus.toString());
    Get.to(TransferDetailsEntryScreen(toCustomerProfile: Get.find<AuthController>().user.value.customerProfile));
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
