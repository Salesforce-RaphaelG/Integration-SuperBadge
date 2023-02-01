public with sharing class TalentCallout {
  public static HttpResponse makePostCallout(
    String endpoint,
    String newTalentsJSON
  ) {
    String token = SyncToTW.syncTalentToTw();
    List<Talent__c> newTalents = (List<Talent__c>) JSON.deserialize(
      newTalentsJSON,
      List<Talent__c>.class
    );
    String body = RequestBody.formatSyncTalentBody(newTalents);

    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(endpoint);
    request.setMethod('POST');
    request.setHeader('Content-Type', 'application/json;charset=UTF-8');
    request.setHeader('Authorization', token);
    request.setBody(body);

    HttpResponse response = http.send(request);

    return response;
  }
}
