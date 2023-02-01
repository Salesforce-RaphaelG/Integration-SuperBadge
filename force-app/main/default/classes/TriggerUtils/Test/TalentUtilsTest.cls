@isTest
public class TalentUtilsTest {
  @isTest
  static void TalentFindTest() {
    //given
    List<Talent__c> mockTalents = MockTalent.insertMockTalents();

    //when
    List<Talent__c> result = TalentUtils.getTalentsMatchSkillsSet(mockTalents);

    //then
    List<Talent__c> expected = new List<Talent__c>{ mockTalents[0] };
    System.assertEquals(expected, result);
  }

  @isTest
  static void FilterTest() {
    //given
    List<Talent__c> mockTalents = MockTalent.insertMockTalents();

    //when
    mockTalents[0].Interview_Result__c = 'Fail';
    List<Talent__c> actual = TalentUtils.filterInterviewResult(mockTalents);

    //then
    List<Talent__c> expected = new List<Talent__c>{ mockTalents[1] };
    System.assertEquals(expected, actual);
  }
}
