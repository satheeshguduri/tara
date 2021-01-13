package app.tara_app

import androidx.annotation.NonNull
import com.indepay.umps.utils.PKIEncryptionDecryptionUtils
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.lang.Exception
import java.nio.charset.StandardCharsets
import java.security.Key
import java.security.PublicKey

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        val CHANNEL = "flutter.native/tokenFetch";
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
             if (call.method.equals("encryptionFunction")) {
                var data: String? = call.argument("data")
                var key: String? = call.argument("key")
                val requestString = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
//                    String(PKIEncryptionDecryptionUtils.encryptAndEncodeByAes(data.toByteArray(StandardCharsets.UTF_8), key), StandardCharsets.UTF_8),
                    String(PKIEncryptionDecryptionUtils.encryptAndEncodeByAes(
                            data!!.toByteArray(StandardCharsets.UTF_8),
                            Base64.getDecoder().decode(key)
                    ), StandardCharsets.UTF_8)

                } else {
                    TODO("VERSION.SDK_INT < O")
                }
                result.success(requestString)
            }else if (call.method.equals("encryptionFunction2")) {
                var data: String? = call.argument("data")
                var key: String? = call.argument("key")
                val requestString = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
    //                    String(PKIEncryptionDecryptionUtils.encryptAndEncodeByAes(data.toByteArray(StandardCharsets.UTF_8), key), StandardCharsets.UTF_8),
                    String(PKIEncryptionDecryptionUtils.encryptAndEncodeByAes(
                            data!!.toByteArray(StandardCharsets.UTF_8),
                            key!!.toByteArray()
                    ), StandardCharsets.UTF_8)

                } else {
                    TODO("VERSION.SDK_INT < O")
                }
                result.success(requestString)
        } else if (call.method.equals("decryptionFunction")) {
                var data: String?  = call.argument("data")
                var key: String? = call.argument("key")

                val responseString = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                    String(PKIEncryptionDecryptionUtils.decodeAndDecryptByAes(
                            data!!.toByteArray(StandardCharsets.UTF_8),
                            Base64.getDecoder().decode(key)
                    ), StandardCharsets.UTF_8)

                } else {
                    TODO("VERSION.SDK_INT < O")
                }
                result.success(responseString)
            } else if (call.method.equals("decryptionFunction2")) {
                 var data: String?  = call.argument("data")
                 var key: ByteArray? = call.argument("key")
                 val responseString = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                     String(PKIEncryptionDecryptionUtils.decodeAndDecryptByAes(
                             data!!.toByteArray(StandardCharsets.UTF_8),
                             key
                     ), StandardCharsets.UTF_8)

                 } else {
                     TODO("VERSION.SDK_INT < O")
                 }
                 result.success(responseString)
             }else if (call.method.equals("decodeAndDecrypt")) {
                var data: String?  = call.argument("data")
                var key: String? = call.argument("key")
                val responseString = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                    PKIEncryptionDecryptionUtils.decodeAndDecrypt(data?.toByteArray(StandardCharsets.UTF_8),
                            PKIEncryptionDecryptionUtils.convertPublicKey(Base64.getDecoder().decode(key)))
                } else {
                    TODO("VERSION.SDK_INT < O")
                }
                 println("Decrypted Symmetric Key:"+responseString);
                result.success(responseString);
            } else if (call.method.equals("encryptAndEncode")) {
                var data: String?  = call.argument("data")
                var key: ByteArray? = call.argument("key")
                val responseString = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                    String(PKIEncryptionDecryptionUtils.encryptAndEncode(data!!.toByteArray(StandardCharsets.UTF_8), PKIEncryptionDecryptionUtils.convertPublicKey(Base64.getDecoder().decode(key)))!!,StandardCharsets.UTF_8)

                } else {
                    TODO("VERSION.SDK_INT < O")
                }
                result.success(responseString)
            }else if (call.method == "generateAes") {
                val responseString = PKIEncryptionDecryptionUtils.generateAes()
                result.success(responseString)
            } else if (call.method == "encryptWithAutoRandomKey") {
                 val data: String?  = call.argument("data")
                 val sessionKey: String?  = call.argument("sessionKey")
                 val isUserRegistration: Boolean?  = call.argument("isUserRegistration")
                 val response:HashMap<String,Any> = HashMap();
                 val randomAesKey = PKIEncryptionDecryptionUtils.generateAes();
                 val encryptedData = String(PKIEncryptionDecryptionUtils.encryptAndEncodeByAes(data!!.toByteArray(StandardCharsets.UTF_8), randomAesKey), StandardCharsets.UTF_8)
                 val decodeKey= if(isUserRegistration!!){
                     Base64.getDecoder().decode(sessionKey)
                 }else{
                     Base64.getUrlDecoder().decode(sessionKey)
                 }
                 val symmetricKey = String(PKIEncryptionDecryptionUtils.encryptAndEncode(randomAesKey, PKIEncryptionDecryptionUtils.convertPublicKey(decodeKey))!!)
                 response["encryptedData"] = encryptedData
                 response["symmetricKey"] = symmetricKey
                 result.success(response)
             }else if (call.method == "decryptWithSymmetricKey") {
                 try {
                     val data: String? = call.argument("data")
                     val symmetricKey: String? = call.argument("symmetricKey")
                     val sessionKey: String? = call.argument("sessionKey")
                     val publicKey: String? = call.argument("publicKey")
                     val isUserRegistration: Boolean? = call.argument("isUserRegistration")
                     println("data: $data")
                     println("symmetricKey: $symmetricKey")
                     println("sessionKey: $sessionKey")

                     var decodeKey = if (isUserRegistration!!) {
                         Base64.getDecoder().decode(sessionKey)
                     } else {
                         Base64.getUrlDecoder().decode(sessionKey)
                     }
                     /*if(publicKey!=null){
                         decodeKey = Base64.getUrlDecoder().decode(Base64.getUrlDecoder().decode(publicKey));
                     }*/


                     println("decodeKey: $decodeKey")
                     val decSymmetricKey = PKIEncryptionDecryptionUtils.decodeAndDecrypt(symmetricKey!!.toByteArray(StandardCharsets.UTF_8),
                             PKIEncryptionDecryptionUtils.convertPublicKey(decodeKey))
                 println("decSymmetricKey: $decSymmetricKey")
                     val response = String(PKIEncryptionDecryptionUtils.decodeAndDecryptByAes(data!!.toByteArray(StandardCharsets.UTF_8), decSymmetricKey), StandardCharsets.UTF_8)
                     print("Android Response:" + response);

                 result.success(response)
                 }catch (e: Exception){
                     e.printStackTrace()
                 }
             }else if (call.method == "encryptBankData") {
                 val data: String?  = call.argument("data")
                 val bankKi: String?  = call.argument("bankKi")
                 val bankKey: String?  = call.argument("bankKey")
                 val encryptedAccountData = PKIEncryptionDecryptionUtils.encryptAndEncode(data, PKIEncryptionDecryptionUtils.convertPublicKey(Base64.getUrlDecoder().decode(Base64.getUrlDecoder().decode(bankKey))))!!
                 val encodedData = "$bankKi:$encryptedAccountData"
                 result.success(encodedData)
             }
        }

    }
}