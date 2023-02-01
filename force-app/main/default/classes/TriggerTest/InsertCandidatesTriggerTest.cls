@isTest
public with sharing class InsertCandidatesTriggerTest {
  @isTest
  static void Test() {
    //given
    List<Talent__c> talents = TalentMock.insertMockTalents();
    Test.setMock(HttpCalloutMock.class, new TalentCalloutMock());

    //when
    Test.startTest();
    List<Database.SaveResult> result = Database.insert(talents, false);
    Test.stopTest();

    //then
    System.assertEquals(true, result[0].isSuccess());
    System.assertEquals(true, result[1].isSuccess());
  }
}
