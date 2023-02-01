public class JWTAuthFlow {
  public string createJWT(String iss, String sub, String aud, String endPoint) {
    // static resource to get the key that will be use for Crypto-Sign
    StaticResource jwtPrivate = [
      SELECT Id, Body
      FROM StaticResource
      WHERE Name = 'JWT_Private_Key'
      LIMIT 1
    ];
    String privateKey = jwtPrivate.Body.toString();
    system.debug('privateKey:' + privateKey);

    // create body of the Json that contains endpoint, url, consumer key, type etc
    JSONGenerator jsonHeader = Json.createGenerator(false);
    jsonHeader.writeStartObject();
    jsonHeader.writeStringField('alg', 'RS256');
    jsonHeader.writeStringField('type', 'JWT');
    jsonHeader.writeEndObject();
    String endcodeHeader = EncodingUtil.base64Encode(
      Blob.valueOf(jsonHeader.getAsString())
    );
    system.debug('endcodeHeader:' + endcodeHeader);

    JSONGenerator jsonBody = Json.createGenerator(false);
    jsonBody.writeStartObject();
    jsonBody.writeStringField('iss', iss);
    jsonBody.writeStringField('sub', sub);
    jsonBody.writeStringField('aud', aud);
    jsonBody.writeNumberField('exp', DateTime.now().addMinutes(30).getTime());
    jsonBody.writeEndObject();
    String endcodeBody = EncodingUtil.base64Encode(
      Blob.valueOf(jsonBody.getAsString())
    );
    system.debug('endcodeBody:' + endcodeBody);
    String jwtRequest = endcodeHeader + '.' + endcodeBody;

    //String the JWT Request
    Blob key = EncodingUtil.base64Decode(privateKey);
    Blob rs256sig = Crypto.sign('RSA-SHA256', Blob.valueOf(jwtRequest), key);
    String signature = EncodingUtil.base64Encode(rs256sig);
    signature = signature.replace('+', '-');
    signature = signature.replace('/', '_');
    String signedJWTRequest = jwtRequest + '.' + signature;
    System.debug('signedJWTRequest:' + signedJWTRequest);

    // create thw payload
    String payload = 'grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer';
    payload += '&assertion=' + signedJWTRequest;
    System.debug('payload:' + payload);

    // create httpRequest and send it to server
    Http httpObj = new Http();
    HttpRequest req = new HttpRequest();
    HttpResponse res;
    req.setEndpoint(endPoint);
    req.setMethod('POST');
    req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
    req.setBody(payload);
    res = httpObj.send(req);

    system.debug('res:' + res.getStatus());
    system.debug('res:' + res.getBody());

    if (res.getStatusCode() == 200) {
      Map<String, Object> mapTokenResponse = (Map<String, Object>) JSON.deserializeUntyped(
        res.getBody()
      );
      String access_token =
        (String) mapTokenResponse.get('token_type') +
        ' ' +
        (String) mapTokenResponse.get('access_token');
      system.debug('access_token:' + access_token);
      return access_token;
    }

    return res.getBody();
  }
}
