public with sharing class TalentUtils {
  public static List<Talent__c> getTalentsMatchSkillsSet(
    List<Talent__c> newTalents
  ) {
    List<Talent__c> talentToBeCreatedInTW = new List<Talent__c>();

    List<Talent_Sync_Condition__mdt> skillsList = [
      SELECT Skill_Set__c
      FROM Talent_Sync_Condition__mdt
      WHERE Label = 'TW Talent Sync'
      LIMIT 1
    ];

    String skills = (String) skillsList[0].get('Skill_Set__c');
    Set<String> skillsSetTW = new Set<String>(skills.split(';'));

    for (Talent__c talent : newTalents) {
      Set<String> skillsSetHH = new Set<String>(talent.Skill_Set__c.split(';'));

      if (skillsSetHH.containsAll(skillsSetTW)) {
        talentToBeCreatedInTW.add(talent);
      }
    }
    return talentToBeCreatedInTW;
  }

  public static List<Talent__c> filterInterviewResult(List<Talent__c> talents) {
    List<Talent__c> updatedTalents = new List<Talent__c>();

    for (Talent__c talent : talents) {
      if (talent.Interview_Result__c != 'Fail') {
        updatedTalents.add(talent);
      }
    }

    return updatedTalents;
  }
}
