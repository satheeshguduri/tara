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
import 'package:tara_app/common/widgets/common_purchase_widget.dart';
import 'package:tara_app/common/widgets/custom_appbar_widget.dart';
import 'package:tara_app/common/widgets/dashed_line_border_button.dart';
import 'package:tara_app/common/widgets/error_state_info_widget.dart';
import 'package:tara_app/controller/auth_controller.dart';
import 'package:tara_app/controller/contacts_transfer_controller.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/bills/bill_details_response.dart';
import 'package:tara_app/screens/base/base_state.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';
import 'package:tara_app/screens/chat/chat_conversation.dart';
import 'package:tara_app/screens/consumer/Data.dart';
import 'package:tara_app/screens/consumer/bank_transfer_new_contact.dart';
import 'package:tara_app/screens/consumer/my_account/connect_new_account_select_ank.dart';
import 'package:tara_app/screens/consumer/transfer_details_entry_screen.dart';
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
  _TransferToTaraUserState createState() =>   _TransferToTaraUserState();
}

class _TransferToTaraUserState   extends BaseState<TransferToTaraUser> {

  ContactsTransferController contactsController = Get.find();
  final key = new GlobalKey<ScaffoldState>();




  @override
  void initState() {
    super.initState();
    contactsController.loadData();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      key: key,
      appBar: CustomAppBarWidget(title:  getTranslation(widget.navBarTitle),addNewWidgetShow: false,),

      //appBar: _buildAppBar(context),
      body: Obx(()=> SafeArea(
        child: buildTaraAndAllContactsList()).withProgressIndicator(showIndicator: contactsController.showProgress.value),
      ),
      //), //bottom: true,top: false,
    );
  }




  // void loadData() async {
  //   contactsController.showProgress.value = true;
  //   var status = await Permission.contacts.status;
  //   if (!status.isGranted) {
  //     PermissionStatus permissionStatus = await Permission.contacts.request();
  //     if(permissionStatus.isGranted) {
  //       contactsController.contactList.value = (await ContactsService.getContacts( withThumbnails: false)).toList();
  //     }else{
  //       getIt.get<GetHelper>().getDialog(content: ErrorStateInfoWidget(desc:"Please enable contacts access permission in system settings",
  //         onTap: (){
  //           pop();
  //           pop();
  //         },),
  //       );
  //     }
  //   }else{
  //     contactsController.contactList.value = (await ContactsService.getContacts(withThumbnails: false)).toList();
  //
  //   }
  //   contactsController.showProgress.value = false;
  // }

  Widget buildTaraAndAllContactsList() {

               return Column(
                 children: [
                   Visibility(child: Text(contactsController.title.value),visible: false,), // state is getting updated if we add this widget otherwise not.
                  Expanded(
                    child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 16,
                        child: listViewContainer()

                    ),
                  )
                 ],
               );


              // return  Container(
              //     height: MediaQuery
              //         .of(context)
              //         .size
              //         .height - 16,
              //     child: listViewContainer()
              //
              // );

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
        (contactsController.searchText
            .toString()
            .isNotEmpty && contactsController.filteredContactList.value.isEmpty) ? Container(
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
            "\"${contactsController.searchText.toString()}\"",
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
            border: Border.all(color: (contactsController.searchText
                .toString()
                .isNotEmpty) ? AppColors.header_top_bar_color : Colors
                .grey[400], width: 1),
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
                      color: (contactsController.searchText != null &&
                          contactsController.searchText
                              .toString()
                              .isNotEmpty)
                          ? Colors.black54
                          : Colors.transparent)).onTap(onPressed: () {

                contactsController.title.value = "";
                  contactsController.searchText.value = "";
                  contactsController.searchQuery.text = "";
                  contactsController.filteredContactList.value.clear();

              },
              ),



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
          if (contactsController.searchText
              .toString()
              .isNotEmpty && contactsController.filteredContactList.value.isEmpty) {
            return 0;
          }
          else {
            //default state when search not applied
            if (!(contactsController.searchText != null && contactsController.searchText
                .toString()
                .isNotEmpty)) {
              return contactsController.contactList.value.length;
            }
            //search applied
            else {
              return contactsController.filteredContactList.value.length;
            }
          }
        },

        cellAtIndexPath: (section, row) {
          if (contactsController.searchText
              .toString()
              .isNotEmpty && contactsController.filteredContactList.value.isEmpty) {
            return Container();
          }
          else {
            if (!(contactsController.searchText != null && contactsController.searchText
                .toString()
                .isNotEmpty)) {
              return getTaraContactItemWidget(contactsController.contactList.value[row], row);
            }
            //search applied
            else {
              return getTaraContactItemWidget(contactsController.filteredContactList.value[row], row);
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
                            width:getWidth(contactInfo?.displayName ?? "Un Known"),
                            margin: EdgeInsets.only(top: 4),
                            child: Text(
                              contactInfo?.displayName ?? "Un Known",
                              textAlign: TextAlign.left,
                              style: BaseStyles
                                  .transactionItemPersonNameTextStyle,
                              overflow: TextOverflow.ellipsis,
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
            // if(contactInfo.displayName!=null && contactInfo.phones.elementAt(0).value!=null)
            //Get.to(BankTransferNewContact(taraContact: contactInfo,));
            // Get.to(TransferDetailsEntryScreen(taraContact: contactInfo,));
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

  double getWidth(String s) {
    if(s.length>30)
      return Get.width*0.6;
  }

  @override
  BuildContext getContext() {
    return context;
  }

}

