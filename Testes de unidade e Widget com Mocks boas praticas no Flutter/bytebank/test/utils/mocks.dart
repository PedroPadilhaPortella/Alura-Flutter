import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:mockito/mockito.dart';

class ContactDAOMock extends Mock implements ContactDAO {}

class TransactionWebClientMock extends Mock implements TransactionWebClient {}
