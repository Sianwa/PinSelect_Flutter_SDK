class InstitutionData{
  String clientId;
  String clientSecret;
  int institutionId ;
  String rsaPublicKey;
  String rsaPrivateKey;
  String keyId;
  String callbackURL;

  InstitutionData(this.clientId, this.clientSecret, this.institutionId,
      this.rsaPublicKey, this.rsaPrivateKey, this.keyId, this.callbackURL);
}