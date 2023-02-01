public with sharing class TalentMock {
  public static List<Talent__c> insertMockTalents() {
    List<Talent__c> mockTalents = new List<Talent__c>{
      new Talent__c(
        Name__c = 'Jack',
        Phone__c = '88888888',
        Email__c = 'jack@1.com',
        Education__c = 'Master',
        Certification__c = 'dev1;admin',
        Project_Experience__c = 'no',
        Skill_Set__c = 'English;Salesforce;Java'
      ),
      new Talent__c(
        Name__c = 'Nina',
        Phone__c = '7777777',
        Email__c = 'nina@1.com',
        Education__c = 'Bachelor',
        Certification__c = 'dev2;admin',
        Project_Experience__c = 'yes',
        Skill_Set__c = 'English;Java'
      )
    };

    return mockTalents;
  }
}
