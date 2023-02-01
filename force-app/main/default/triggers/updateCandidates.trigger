trigger updateCandidates on Talent__c(after update) {
  String endpoint = 'https://creative-wolf-wt4mrd-dev-ed.my.salesforce.com/services/apexrest/accept/AcceptTalentInfoService';

  List<Talent__c> updatedTalents_skill = TalentUtils.getTalentsMatchSkillsSet(
    Trigger.new
  );

  List<Talent__c> updatedTalents = TalentUtils.filterInterviewResult(
    updatedTalents_skill
  );
  Boolean ignoreInterview = true;

  if (updatedTalents.size() > 0) {
    for (Talent__c talent : updatedTalents) {
      Talent__c oldTalent = Trigger.oldMap.get(talent.Id);
      if (
        talent.Interview_Date__c != oldTalent.Interview_Date__c ||
        talent.Interview_Result__c != oldTalent.Interview_Result__c
      ) {
        ignoreInterview = false;
      }
    }

    if (ignoreInterview) {
      String talentsJSON = JSON.serialize(updatedTalents);

      TalentResponseHandler.saveLog(endpoint, talentsJSON);
    }
  }
}
