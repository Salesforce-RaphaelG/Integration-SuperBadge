public class SyncToTW {
  public static String syncTalentToTw() {
    String iss = '3MVG9pRzvMkjMb6moTHi9bK6lB6Oacpe5Aqjfrj03k0vlbEhYcnudIYtI2afFTy0QNpAsoUd7.qZ1d9uIrHpe';
    String sub = 'cduan@creative-wolf-wt4mrd.com';
    String aud = 'https://login.salesforce.com';
    String endPoint = 'https://login.salesforce.com/services/oauth2/token';

    JWTAuthFlow jwt = new JWTAuthFlow();
    String twToken = jwt.createJWT(iss, sub, aud, endPoint);
    System.debug('twToken: ' + twToken);

    return twToken;
  }
}
