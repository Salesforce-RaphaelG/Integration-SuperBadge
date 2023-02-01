public with sharing class RequestBody {
  public static String formatSyncTalentBody(List<Talent__c> TalentSync) {
    // TalentUtils talentUtils = new TalentUtils();
    // List<Talent__c> newTalents = talentUtils.getTalentsMatchSkillsSet(
    //   TalentSync
    // );

    List<Map<String, Object>> talentList = new List<Map<String, Object>>();

    for (Talent__c talent : TalentSync) {
      Map<String, Object> talentMap = new Map<String, Object>{};
      talentMap.put('External_ID__c', talent.Id);
      talentMap.put('LastName', talent.Name__c);
      talentMap.put('Phone', talent.Phone__c);
      talentMap.put('Email', talent.Email__c);
      talentMap.put('Education__c', talent.Education__c);
      talentMap.put('Certification__c', talent.Certification__c);
      talentMap.put('Project_Experience__c', talent.Project_Experience__c);
      talentMap.put('Skill_Set__c', talent.Skill_Set__c);

      talentList.add(talentMap);
    }

    Map<String, Object> talentInfo = new Map<String, Object>{};
    talentInfo.put('talentSource', '猎头公司');
    talentInfo.put('talentList', talentList);

    Map<String, Object> talentBody = new Map<String, Object>{};
    talentBody.put('talentInfo', talentInfo);

    String body = JSON.serialize(talentBody);
    System.debug('body:' + body);
    return body;
  }
}
