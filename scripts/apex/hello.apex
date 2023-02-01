// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents



// 1. Sync

List<Talent__c> newTalents = new List<Talent__c>{
  new Talent__c(
    Name__c = 'Jack6',
    Phone__c = '88888888',
    Email__c = 'jack@1.com',
    Education__c = 'Master',
    Certification__c = 'dev1;admin',
    Project_Experience__c = 'no',
    Skill_Set__c = 'English;Salesforce;Java'
  ),
  new Talent__c(
    Name__c = 'Nina6',
    Phone__c = '7777777',
    Email__c = 'nina@1.com',
    Education__c = 'Bachelor',
    Certification__c = 'dev2;admin',
    Project_Experience__c = 'yes',
    Skill_Set__c = 'English;Java'
  )
};

insert newTalents;

// 2. Workbech

// Apex rest
/services/apexrest/accept/AcceptInterviewResult

{"interviewResults":
  [
    {"id":"a005g00003Bsy0yAAB",
"interviewResult":"Pass",
  "interviewDate":"2022-11-22"
    }
  ]
}
