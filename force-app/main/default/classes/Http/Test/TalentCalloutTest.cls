@istest
public with sharing class TalentCalloutTest {
  @isTest
  static void makePostCalloutTest() {
    //given
    Test.setMock(HttpCalloutMock.class, new TalentCalloutMock());
    List<Talent__c> newTalents = TalentMock.insertMockTalents();
    String newTalentsJSON = JSON.serialize(newTalents);

    //when
    HttpResponse result = TalentCallout.makePostCallout(
      'endpoint',
      newTalentsJSON
    );

    //then
    System.assertNotEquals(
      null,
      result,
      'The callout returned a null response.'
    );
    System.assertEquals(
      200,
      result.getStatusCode(),
      'The status code is not 200.'
    );
    System.assertEquals(
      'application/json;charset=UTF-8',
      result.getHeader('Content-Type'),
      'The content type value is not expected.'
    );
    // Verify the array contains 3 items
    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(
      result.getBody()
    );
    String status = (String) results.get('status');
    System.assertEquals('success', status, 'The status is wrong');
  }
}
