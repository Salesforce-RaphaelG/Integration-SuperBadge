@SuppressWarnings('PMD.ApexCRUDViolation')
@RestResource(urlMapping='/accept/AcceptInterviewResult')
global without sharing class InterviewResultController {
  global class InterviewResult {
    public String id;
    public String interviewResult;
    public Date interviewDate;
  }

  @HttpPatch
  global static Map<String, String> updateTalentInterviewResult(
    List<InterviewResult> interviewResults
  ) {
    List<Talent__c> newTalents = new List<Talent__c>();

    // ====

    Map<String, InterviewResult> mapResults = new Map<String, interviewResult>{};
    for (InterviewResult result : interviewResults) {
      mapResults.put(result.id, result);
    }

    List<Talent__c> oldTalents = [
      SELECT Id, Interview_Result__c, Interview_Date__c
      FROM Talent__c
      WHERE Id IN :mapResults.keyset()
    ];

    for (Talent__c talent : oldTalents) {
      talent.Interview_Date__c = Date.valueOf(
        mapResults.get(talent.Id).interviewDate
      );
      talent.Interview_Result__c = mapResults.get(talent.Id).interviewResult;

      newTalents.add(talent);
    }

    update newTalents;
    // ====

    // for (InterviewResult result : interviewResults) {
    //   String leadId = result.Id;
    //   Talent__c talent = [
    //     SELECT Id, Interview_Result__c, Interview_Date__c
    //     FROM Talent__c
    //     WHERE Id = :leadId
    //   ];
    //   talent.Interview_Date__c = Date.valueOf(result.interviewDate);
    //   talent.Interview_Result__c = (String) result.interviewResult;

    //   newTalents.add(talent);
    // }

    //update newTalents;

    // return success msg
    Map<String, String> reponseMsg = new Map<String, String>{};
    reponseMsg.put('statusMsg', '面试结果和时间已更新到猎头系统');

    return reponseMsg;
  }
}
