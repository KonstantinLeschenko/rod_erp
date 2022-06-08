import 'package:gsheets/gsheets.dart';

class GoogleSheetsAPI {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "orders-from-dbf",
  "private_key_id": "51744e08cc018c4b9a76b81469da7b5306340adb",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCW+BSB3+Lt8yPg\nZGwppsL86nprG3An7vH33Uy97ObDaawSQ85FeHLUEfybathCNP8njmqD30qVdXNZ\nIHpT4A9mnr5E7duB32rHpbW4vKhEara2SKse8YYnxfYXT6X1XgFPU1RY71yOkr6F\nejDWO72ycjbBQ1CvJ20FwWGFwXInAkWGAzsnGWc4iN4ZFKPuUqYSr1T4IT29fBFY\nhegvms+Y/njIx1rCi19NatspEeiWSI9MrCAZae+rSOeXsWWEaxbBIG1FUHq/CdLM\n/q2jinB3txK6/W/Gj0pG23c1Pn0XKssVX+NoSkmRZ89OU1XBzP/ohYCRCXyoI/6V\nkjFi1bc5AgMBAAECggEADmfGoSvpXfY05qz+ay0H7xU6sCyyk4Tn3tRlhbvsuxnC\nuw1wSc23+0dqGLRlxU+ER1R+Em5EkiVeZ9NDCOzY21xrYG1n5Cka6ckEoYeS8NBT\n9enSNkYqnHH1zPyjI9of+t9DLadNaCdVeawSq+aQb84ZLnDLaqMy8nkk4pv2VgVq\nayJBWGS7mO03o7KMeG/z4jJloUIc1xSXUhExtKy7ypWXdbtAshQiKfusgIYsc1xB\nX8TBqYDtDgsHz6KrzX/1IsJEn18N9W3OgdFB2IGYte9cl7wF4QLaePUMyL00Kz2T\n4ISuiZ24ZXSNetdLcVrCJhsScggY2XqaEG7E3URBAQKBgQDM4j+pCnh22seJmY8d\nDD4U3rG/9uf1JNJkyiCiXYUppFVkNyVucaesJmFUXKZtLktXDFwo7Lva52QRzQdX\n5aXtXERyfB4Hxavm7SfdCfAvxOoAVN3iTtmJJ9oqNg9rREdaWNyKQpQJ1wRngBa6\nv81ODS9JyQGtfSqRr79+JROrQQKBgQC8olgxk3x8Hm7hTgAgZdGpsqNs3BA9eVlH\nFlOY4yhmGfA/ZXPkcUcVyR0dlQZZGXvek9wOFrF0vlKs3kYbnRn/jCRxb7ONF7X6\nynWKqy/4oJ893sKUciyIsnWiUX0EgERvm0+KQnWrkdJeOw6E6oib0VbONA/L/fyI\n6vJvSMPl+QKBgHpiu/xSENuOnJsJa3/CjGMTE8LDzpOVR0iFpTDYBG93hrqyZl2u\n7qXa11D5d0DI4qBA9dxMbXq5tgEcJELRH2jGMOziT139Kk5rY+CZyyv9yHoiN9iz\nmSZg8+U7HcLJqoXBhxvf4WZvVmYtEWbEo/L31UOSGrpzhjY4cX78zt8BAoGAQnuN\nTdvHUg9/0NSm4sRAAuk9BA8DgkcUmiNaT1YwVNvresyM7gSmox0Ar/5oAFsk9ytx\nsV16KcUyak7ksrLKCPEhnwFZbO7gaoWUq8zt2VjzBuFN/vfGjl8napAB2eZDOHqq\nq/YEdvWsCR4TXfEzOIetanua3bCkorT7wREKSjECgYBYFYxWtX2+G4dzhqmihG8K\nm6Ve/e38wTnpREOxVo0ooneSgzsYcjpkxam5lQD7Ue5ow3kdt7UVF/+W+7ZyqQxr\na6cozVHHh5Bhapels0UQV1bUPhpAW45FKVIygQ/VPrXoeL8u2PfIaGZEkTIFFHS7\nU13Es+l019ESRQjIYVDvgg==\n-----END PRIVATE KEY-----\n",
  "client_email": "orders-from-dbf@orders-from-dbf.iam.gserviceaccount.com",
  "client_id": "105898247687502898555",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/orders-from-dbf%40orders-from-dbf.iam.gserviceaccount.com"
}
''';

  static final _spreadsheet_ID = '1tciplqXosmDWkNMtG1vQwrJi2fogMEA_g0QXC2Q7agM';

  static final _gsheets = GSheets(_credentials);

  static Worksheet? _worksheetUsers;
  static Worksheet? _worksheetOrders;

  static int numberOfUsers = 0;
  static List<List<dynamic>> users = [];
  static int numberOfOrders = 0;
  static List<List<dynamic>> currentOrders = [];
  static bool loading = true;


  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheet_ID);
    _worksheetUsers = ss.worksheetByTitle('users');
    countUsers();
    _worksheetOrders = ss.worksheetByTitle('orders');
    countRows();
  }

  static Future countUsers() async {
    while ((await _worksheetUsers!.values
        .value(column: 1, row: numberOfUsers + 1)) !=
        '') {
      numberOfUsers++;
    }
    loadUsers();
  }

  static Future loadUsers() async {
    if (_worksheetUsers == null) return;

    for (int i = 1; i < numberOfUsers; i++) {
      final String userName =
      await _worksheetUsers!.values.value(column: 1, row: i + 1);
      final String userPassword =
      await _worksheetUsers!.values.value(column: 2, row: i + 1);
      final String userRole =
      await _worksheetUsers!.values.value(column: 3, row: i + 1);

      if (users.length < numberOfUsers) {
        users.add([
          userName, userPassword, userRole
        ]);
      }
    }
    //print(users);
    loading = false;
  }

  static Future countRows() async {
    while ((await _worksheetOrders!.values
        .value(column: 1, row: numberOfOrders + 1)) !=
        '') {
      numberOfOrders++;
    }
    // now we know how many notes to load, now let's load them!
    loadOrders();
  }

  static Future loadOrders() async{
    if (_worksheetOrders == null) return;

    for (int i = 1; i < numberOfOrders; i++) {
      final String orderNum =
      await _worksheetOrders!.values.value(column: 1, row: i + 1);
      final String orderAdress =
      await _worksheetOrders!.values.value(column: 3, row: i + 1);
      final String orderKolvo =
      await _worksheetOrders!.values.value(column: 4, row: i + 1);
      final String orderKolvomkv =
      await _worksheetOrders!.values.value(column: 5, row: i + 1);
      final String orderZakazchik =
      await _worksheetOrders!.values.value(column: 6, row: i + 1);
      final String orderDatedostav =
      await _worksheetOrders!.values.value(column: 9, row: i + 1);
      final String orderSeries =
      await _worksheetOrders!.values.value(column: 20, row: i + 1);
      final String orderSumman =
      await _worksheetOrders!.values.value(column: 22, row: i + 1);
      final String orderPropl =
      await _worksheetOrders!.values.value(column: 23, row: i + 1);

      if (currentOrders.length < numberOfOrders) {
        currentOrders.add([
          orderNum,
          orderAdress,
          orderKolvo,
          orderKolvomkv,
          orderZakazchik,
          orderDatedostav,
          orderSeries,
          orderSumman,
          orderPropl
        ]);
      }
    }
    //print(currentOrders);
    loading = false;

  }
  
  
  
  
}
