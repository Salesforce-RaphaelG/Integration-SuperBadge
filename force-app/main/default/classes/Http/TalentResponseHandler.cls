public with sharing class TalentResponseHandler {
  @future(callout=true)
  public static void saveLog(String endpoint, String newTalentsJSON) {
    HttpResponse response = TalentCallout.makePostCallout(
      endpoint,
      newTalentsJSON
    );

    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(
      response.getBody()
    );
    String statusMsg = (String) results.get('statusMsg');
    String statusCode = (String) results.get('statusCode');
    String status = (String) results.get('status');

    Log__c log = new Log__c(
      Platform__c = 'TW',
      Status__c = status,
      StatusCode__c = statusCode,
      Message__c = statusMsg
    );

    insert log;
  }

}
