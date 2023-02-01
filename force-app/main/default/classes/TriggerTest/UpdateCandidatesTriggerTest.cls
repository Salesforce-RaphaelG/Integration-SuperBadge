@isTest
public with sharing class UpdateCandidatesTriggerTest {
  @isTest
  static void Test() {
    //given
    List<Talent__c> talents = TalentMock.insertMockTalents();
    Test.setMock(HttpCalloutMock.class, new TalentCalloutMock());

    //when

    Test.startTest();
    insert talents;

    Talent__c newTalent = [SELECT id FROM Talent__C WHERE id = :talents[0].id];
    newTalent.Phone__c = '123';

    Database.SaveResult result = Database.update(newTalent, false);
    Test.stopTest();

    //then
    System.assertEquals(true, result.isSuccess());
  }
}
