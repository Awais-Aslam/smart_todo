import 'package:googleapis_auth/auth_io.dart';

class get_server_key {
  Future<String> server_token() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "smarttodo-65f42",
          "private_key_id": "163bddc6ec5410f7067f4cb65ff364aa5f081129",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDdZrAG3mxA0sqI\nXsvuCP8eNccuKDqPMoAPZbAoIA7nsNFXV/vkFGMXMr/NSM7JbKowHVfO4/hwebpf\nFlNDxyZJeLJUGICnJGvWkojYnozck5X5Uf5kxNW3cBLteEakYKYPf5XfTe6X2TnX\ny26r0frdH9svD2IMhLtYJgczsoPzgCtQdWDH1+1qsfSHU5JIvc5rBbo/B0MGVYkN\n4Fb0q9vuqd/oAKkPdTTSAEAnsELxOmfjtgOkwf3iEEdkwPnJcz5gE2QTjR8S1mMW\nsGC8vndrmba0WeAB3tszNrBONcaMO1GInMWN16FdnFXy9d2MWkVHp3wQRNFir16T\nTshLTo0jAgMBAAECggEAIKpgmPgtdfhOdDBdsOZtkuzRpmMTwMJCrVg41V1lgD77\npAIR4ro0pIeS+kbJEQ7nTTyxvToFaGg4By9+uXv4j36Epm5ht5y4DGsyUEOUT4xh\njuzPYS6+xCx/nmnQgmWAGr6dmNohXxC9vV5WcHiv+qVolq4+WSUm6aqIBX32hJvD\ncUXmQMLPgPQbvkZ57mK+TAUEbXMXEwyU+fJRpPGuvzZO9Rcgk9f+Je2o+OBFw7yr\nD+IlmETHS63f0j2wrQx7a1gaOoAAzmdIY5DkV7e9ruBTXu06G3O56T59b9hrgGN8\nlpSKHr3S27zBeRNAkyK7fqwYyTEF7p6fzM7msM+ugQKBgQD6TL+FF8m3C2fu/MNh\nyVb3dyoyMAvJXIvHMRQHxTDTJNSukPRC7Z89B5Gp3j/m4UEaugbTmRgsqkX4+Rqk\nzekKaM/se3O7FcgJPRaWaYpTY8+uuhsWAKn/AcRtn6knvJDrRrZTU2jruO6epEle\nzUHQdZs8dDsDsw2QmcAy9cuH5wKBgQDicXWxtyh4EqlrtW4VZjbrLWFhKZyb0Bku\n1tDNptmKz+lu4olar8y8rpW6r2y5bqgAKFigcwgCxJLKrPN+EhD344sM6tr2UP+g\nlmzR3PrPjrCySZXQIQjN3ucj8ZtJkvmxrObZ7Nfc7URPyvKzGsogD9WwJigvaFhr\n0aGNk1S5ZQKBgQDjB4IgAnegY+QdzX6az7jmNVw8sX+/YQYX4tg8RAwJODsBK9Gi\nc04gWSEyZrinfmFDEMDoZNCcksVtEuWr3mkmW/NcmI1cgGE0oAhA3fHtuXbDEWNI\nDcoj10KH/G298TexcC4oXluok9E8a99w8dRkdIgdyX9N17bSFeNTVccKuQKBgQCm\nJKM7GmzZ9K9T9NFpaA7BbRF27cYXWI8xm7GmQlZ5D+VxU0t+O2CXy+zWBaJbR8KC\nIxgr2Vq2VS5zAITDKlRC3TQH7UVs1q9ITzZWoLFxmnswxObjx2kjS/oBmGLcj7ce\n0wKqQKl9UqT9eqWqHezRq2yZCtYPOpstuKi1LLVMNQKBgAQ83XkjlDWWsezRem+c\nY3IP6f+tlwYMaQfvVP3C4WtnvqRQgjyMMV+EBYWxUD/qTmYHw7Ui5jmt5VjxG1Qr\nqe47LhAmq5Cwrxhib0fNFlGBF3fUEjosYHNbQiRld3mnkcRKaWCzfLZBB6bFM0o4\nvjSdcYiM9W28CvhA+qbskU2D\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-fbsvc@smarttodo-65f42.iam.gserviceaccount.com",
          "client_id": "115649944158564402461",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40smarttodo-65f42.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessserverkey = client.credentials.accessToken.data;
    return accessserverkey;
  }
}
