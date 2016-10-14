##Security_RSA
###MAC下公私钥生成步骤:
1.在终端里输入 openssl

2.输入 genrsa -out rsa_private_key.pem 1024

3.输入 pkcs8 -topk8 -inform PEM -in rsa_private_key.pem -outform PEM –nocrypt

4.输入私钥密码两次，也可不设密码，私钥完成

5.输入 rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem  公钥完成

6.前往->“个人”文件夹下查看证书格式的密钥
###RSA加解密
一般RSA加解密需要两套公私钥，key1 服务端保留私钥，客户端保留公钥，用于加密，key2 服务端保留公钥，客户端保留私钥，用于解密。
具体看SecurityUtil.h就行了

##### PROJECT->Search Paths->Header Search Paths 里需要添加openssl文件夹路径
eg.$(inherited) $(PROJECT_DIR)/.../Security/HBRSAHandler/openssl/include