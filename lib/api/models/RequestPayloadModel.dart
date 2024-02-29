import 'package:flutter_pom/api/models/AccountModel.dart';
import 'package:flutter_pom/api/models/InstitutionModel.dart';

class RequestPayloadModel{
  Account account;
  Institution institution;

  RequestPayloadModel(this.account, this.institution);
}

class Account{
  String cardSerialNumber;
  bool isDebit;

  Account(this.cardSerialNumber, this.isDebit);
}

class Institution{
  String callbackURL;
  int instID;

  Institution(this.callbackURL, this.instID);
}