using System.Security.Cryptography;

public static class EncryptionExtensions
{
    private static readonly string base64Key = "hK9Jh8gURnJ1Pb6gDQ9Gg0qS4zQv+fYok/5HQy+63xE=";

    private static byte[] GetKey()
    {
        byte[] key = Convert.FromBase64String(base64Key);

        if (key.Length != 32)
        {
            throw new ArgumentException("Invalid key length. Key must be 32 bytes for AES-256.");
        }

        return key;
    }

    public static string Encrypt(this string plainText)
    {
        if (string.IsNullOrEmpty(plainText))
            throw new ArgumentNullException(nameof(plainText));

        byte[] encrypted;
        using (Aes aesAlg = Aes.Create())
        {
            aesAlg.Key = GetKey();
            aesAlg.IV = new byte[16]; // Initialization vector with zeros

            ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

            using (MemoryStream msEncrypt = new MemoryStream())
            {
                using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                {
                    using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                    {
                        swEncrypt.Write(plainText);
                    }
                    encrypted = msEncrypt.ToArray();
                }
            }
        }
        return Convert.ToBase64String(encrypted);
    }

    public static string Decrypt(this string cipherText)
    {
        if (string.IsNullOrEmpty(cipherText))
            throw new ArgumentNullException(nameof(cipherText));

        string plaintext = null;
        using (Aes aesAlg = Aes.Create())
        {
            aesAlg.Key = GetKey();
            aesAlg.IV = new byte[16]; // Initialization vector with zeros

            ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

            using (MemoryStream msDecrypt = new MemoryStream(Convert.FromBase64String(cipherText)))
            {
                using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                {
                    using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                    {
                        plaintext = srDecrypt.ReadToEnd();
                    }
                }
            }
        }
        return plaintext;
    }
}
