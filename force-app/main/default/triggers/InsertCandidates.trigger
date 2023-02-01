trigger InsertCandidates on Talent__c(after insert) {
  String endpoint = 'https://creative-wolf-wt4mrd-dev-ed.my.salesforce.com/services/apexrest/accept/AcceptTalentInfoService';

  List<Talent__c> updatedTalents = TalentUtils.getTalentsMatchSkillsSet(
    Trigger.new
  );

  if (updatedTalents.size() > 0) {
    String talentsJSON = JSON.serialize(updatedTalents);

    TalentResponseHandler.saveLog(endpoint, talentsJSON);
  }

}
