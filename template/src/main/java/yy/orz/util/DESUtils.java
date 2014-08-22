package yy.orz.util;


import org.apache.shiro.codec.Base64;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.SecureRandom;

public class DESUtils {
    private final static String KEY = "SSOFOUNDER"; // 字节数必须是8的倍数

    public static byte[] desEncrypt(byte[] plainText) throws Exception {
        SecureRandom sr = new SecureRandom();
        DESKeySpec dks = new DESKeySpec(KEY.getBytes());
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        SecretKey key = keyFactory.generateSecret(dks);
        Cipher cipher = Cipher.getInstance("DES");
        cipher.init(Cipher.ENCRYPT_MODE, key, sr);
        byte data[] = plainText;
        byte encryptedData[] = cipher.doFinal(data);
        return encryptedData;
    }

    public static byte[] desDecrypt(byte[] encryptText) throws Exception {
        SecureRandom sr = new SecureRandom();
        DESKeySpec dks = new DESKeySpec(KEY.getBytes());
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        SecretKey key = keyFactory.generateSecret(dks);
        Cipher cipher = Cipher.getInstance("DES");
        cipher.init(Cipher.DECRYPT_MODE, key, sr);
        byte encryptedData[] = encryptText;
        byte decryptedData[] = cipher.doFinal(encryptedData);
        return decryptedData;
    }

    public static String encrypt(String input) throws Exception {
        return base64Encode(desEncrypt(input.getBytes()));
    }

    public static String decrypt(String input) throws Exception {
        byte[] result = base64Decode(input);
        return new String(desDecrypt(result));
    }

    public static String base64Encode(byte[] s) {
        if (s == null)
            return null;
        try {
            return new String(Base64.encode(s), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static byte[] base64Decode(String s) throws IOException {
        if (s == null) {
            return null;
        }
        byte[] b = Base64.decode(s);
        return b;
    }

    public static void main(String args[]) {
        try {
            String s = "R7iOJjHOEOxAgN96lDb1veEfLI4PwPdXyeOfWsooigYJhSJLVpROwj7w/uRY4WHptNbIL3Udiy6vTkHx4XHJPjNctsF7F9iBmljqHsk6" +
                    "UupyILLClT49YFB3chvNStVh6679py6bQvuY8NOhtqMVAfI7cO4Mjqib7bL/QjtJoNymu1b5VorIHMQs4Y7zEbe2Tk7235eqIRBSs/YLHTuapI+QOOf8CjdPC5Wtt+1mOxoQ5rFXYEni/+yoxgu2p+tYHY2wVnUJRFfgIOJitJCdSV6HylY" +
                    "W6i4IKIlDgsjNC3wFGA4dJeSXFFe/RssQ6jatZQi2dIJ1tfurR1Fg+kFZ3sQX2/9miR1e6Bi8sThgGt5ivEzNHkXXHZNNH7ZYEOOB6ng31X29v6hbu7Bhe7uqnFknkwrhlBXf5HPZaGrwrvdCzFhv7uw2fUR1CRmwnVwQPbug6SC806h272" +
                    "MxYJH+bEBOhiVwDsow/BJLtAVoFbAD8wk0HLdpXkKEghmpTHPCip3Elg1VOURQJpCM14Ad5ybTGmIKBp7e0aBgNqVGx0rymPHu2noza2uvnuNh/F+/w50unIGCBx7iiEw9qHFLXc+RQ1z37VLWbuAQCBdhigYyMiDP//MIUXz6Da4MqM16i" +
                    "EfoJc6Q99TX1RO5ZfM8C2rl4JV6neXG9EUPvbzq7cP5t3yDrHo2Fya4L9LY2PW0b3Y3/1Z/ozwprubyCIld5zPd3ow/EhXd6FggFRSDFPsprubyCIld55YuOBUXDfYAIzGb6Dgp+DFbrnUUE5J2qiCt/Vew30NXAuB74+VChsAfsovs9i2H" +
                    "54weyjZD0uIPL1X00xM1lxj4hCxJzX3ciHBr0rVvDi1uHmXhSmmd4+8zOzzH/8nQpvMMFLh403HLUX1dJHiTwX67jUjbnXK1K+j+11JWtCpu";
            String ss = s;//URLDecoder.decode(s);
            System.out.println(ss);
            System.out.println(DESUtils.decrypt(ss));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
