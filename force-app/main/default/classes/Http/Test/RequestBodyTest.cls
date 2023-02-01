@isTest
public with sharing class RequestBodyTest {
  @isTest
  public static void formatSyncTalentBodyTest() {
    //given
    List<Talent__c> mockTalents = MockTalent.insertMockTalents();

    //when
    String actualString = RequestBody.formatSyncTalentBody(mockTalents);
    Map<String, Object> actual = (Map<String, Object>) JSON.deserializeUntyped(
      actualString
    );

    //then
    String expectedString = '{"talentInfo":{"talentList":[{"Skill_Set__c":"English;Salesforce;Java","Project_Experience__c":"no","Certification__c":"dev1;admin","Education__c":"master","Email":"jack@1.com","Phone":"88888888","LastName":"Jack","External_ID__c":null},{"Skill_Set__c":"English;Java","Project_Experience__c":"yes","Certification__c":"dev2;admin","Education__c":"doc","Email":"nina@1.com","Phone":"7777777","LastName":"Nina","External_ID__c":null}],"talentSource":"猎头公司"}}';
    Map<String, Object> expected = (Map<String, Object>) JSON.deserializeUntyped(
      expectedString
    );

    System.assertEquals(expectedString, actualString);
  }
}
