using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Text;
using System.IO;
    public class encryption
    {
        const string KEY_64 = "EavicCpp";//密匙，8个字符，64位   

        const string IV_64 = "EavicCpp";



        #region EnCode 加密
        /// <summary>   
        /// EnCode 加密   
        /// </summary>   
        /// <param name="str">要加密的字符串</param>   
        /// <returns></returns>   

        public static string EnCode(string data)
        {
            byte[] byKey = System.Text.ASCIIEncoding.ASCII.GetBytes(KEY_64);
            byte[] byIV = System.Text.ASCIIEncoding.ASCII.GetBytes(IV_64);

            DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();
            int i = cryptoProvider.KeySize;
            MemoryStream ms = new MemoryStream();
            CryptoStream cst = new CryptoStream(ms, cryptoProvider.CreateEncryptor(byKey,

    byIV), CryptoStreamMode.Write);

            StreamWriter sw = new StreamWriter(cst);
            sw.Write(data);
            sw.Flush();
            cst.FlushFinalBlock();
            sw.Flush();
             string s=Convert.ToBase64String(ms.GetBuffer(), 0, (int)ms.Length);
             s = s.Replace("+", ".").Replace("&", "-");
            return s;
        }
        #endregion

        #region DeCode 解密
        /// <summary>   
        /// DeCode 解密   
        /// </summary>   
        /// <param name="str">要解密的字符串</param>   
        /// <returns></returns>   
        public static string DeCode(string data)
        {
            if (data != null)
            {
                data = data.Replace(".", "+").Replace("-", "&");
            }
            byte[] byKey = System.Text.ASCIIEncoding.ASCII.GetBytes(KEY_64);
            byte[] byIV = System.Text.ASCIIEncoding.ASCII.GetBytes(IV_64);

            byte[] byEnc;
            try
            {
                byEnc = Convert.FromBase64String(data);
            }
            catch
            {
                return null;
            }

            DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();
            MemoryStream ms = new MemoryStream(byEnc);
            CryptoStream cst = new CryptoStream(ms, cryptoProvider.CreateDecryptor(byKey,

    byIV), CryptoStreamMode.Read);
            StreamReader sr = new StreamReader(cst);
            return sr.ReadToEnd();
        }
        #endregion  
    }
