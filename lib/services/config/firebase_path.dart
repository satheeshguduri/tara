import 'package:characters/characters.dart';
class FirebasePath {

  static String agent() => 'agent/';
  static String merchant() => 'merchant/';
  static String customer() => 'customer/';
  static String agentMerchantChat(String uId) => 'agent_merchant_chat/$uId';
  static String merchantMerchantChat(String uId) => 'merchant_merchant_chat/$uId';
  static String customerMerchantChat(String uId) => 'customer_merchant_chat/$uId';
  static String agentCustomerChat(String uId) => 'agent_customer_chat/$uId';
  static String customerCustomerChat(String uId) => 'customer_customer_chat/$uId';


  static String getPath(String one, String two)
  {
    //modifying on 12/11/20, based on prd on chat module use case
    var array1 = one.substring(4,one.length).characters;
    var array2 = two.substring(4,two.length).characters;

    var result;
    var id;

    for(int i = 0; i < array1.length; i++)
    {
      for(int j = 0; j < array2.length; j++)
      {
        if( array1.characterAt(i).string.compareTo(array2.characterAt(j).string)<0)
        {
          id = one.substring(4,one.length)+"_"+two.substring(4,one.length);
        }
        else
        {
          id = two.substring(4,one.length)+"_"+one.substring(4,one.length);
        }
      }
    }
    if(one.startsWith("C") && two.startsWith("C"))
    {
      result =customerCustomerChat(id);
    }
    else if((one.startsWith("A") && two.startsWith("M")) || (one.startsWith("M") && two.startsWith("A")))
    {
      result = agentMerchantChat(id);
    }
    else if(one.startsWith("A") && two.startsWith("C") || one.startsWith("C") && two.startsWith("A"))
    {
      result = agentCustomerChat(id);
    }
    else if((one.startsWith("M") && two.startsWith("M")) || two.startsWith("M") && one.startsWith("M"))
    {
      result = merchantMerchantChat(id);
    }
    else if((one.startsWith("M") && two.startsWith("C")) || one.startsWith("C") && two.startsWith("M"))
    {
      result = customerMerchantChat(id);
    }
    print(result);
    return result;
  }
}
