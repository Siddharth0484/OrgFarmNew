public class CollegeBudgetUpdater {

    @InvocableMethod(label='Update Edited College Budget' description='Set Total_Budget__c=5555 if Location is Mumbai on edited record(s)')
    public static void updateBudgetForEditedRecords(List<Id> collegeIds) {
        if (collegeIds == null || collegeIds.isEmpty()) {
            return;///ffff
        }
        
        List<College__c> collegesToUpdate = [SELECT Id, Location__c, Total_Budget__c FROM College__c WHERE Id IN :collegeIds];
        
        for (College__c college : collegesToUpdate) {
            if (college.Location__c != null && college.Location__c.equalsIgnoreCase('Mumbai')) {
                college.Total_Budget__c = 5555;
            }
        }
        
        if (!collegesToUpdate.isEmpty()) {
            update collegesToUpdate;
        }
    }
}