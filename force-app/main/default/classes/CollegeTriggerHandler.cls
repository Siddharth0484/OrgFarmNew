public class CollegeTriggerHandler {
    
    //NEW UPDATE
    
    public static void handleBeforeInsert(List<College__c> colleges) {
        for (College__c college : colleges) {
            system.debug('@@7DATA'+college);
            if (college.Total_Budget__c != null && college.Total_Budget__c > 10000) {
                college.Location__c = 'Pune';
            } else {
                college.Location__c = 'Delhi';
            }
        }
    } //stubs methods. functions
    
    public static void handleBeforeUpdate(List<College__c> colleges) {
        for (College__c college : colleges) {
            system.debug('@@18-CDATA'+college);
            if (college.Total_Budget__c != null && college.Total_Budget__c > 50000) {
                college.Location__c = 'Mumbai';
            } else {
                college.Location__c = 'Chennai';
            }
        }
        //aslknlkn
    }
    
    public static void handleBeforeUpdateNew(List<College__c> colleges) {
        
        //some other code
        //college.Location__c 
        //
        //Outbound message !!
        
    }
    
    
    
    public static void handleAfterInsert(List<College__c> colleges) {
        // some code REST outbund
        System.debug('After insert triggered for colleges: ' + colleges);
    }
    
    public static void handleAfterUpdate(List<College__c> colleges, Map<Id, College__c> oldMap) {
        
        // Collect College Ids only where Total_Budget__c changed AND is > 50000
        Set<Id> collegeIds = new Set<Id>();
        
        for (College__c college : colleges) {
            College__c oldCollege = oldMap.get(college.Id);
            if (college.Total_Budget__c != oldCollege.Total_Budget__c && 
                college.Total_Budget__c != null && 
                college.Total_Budget__c > 5000) {
                    
                    collegeIds.add(college.Id);
                }
        }
        
        if (collegeIds.isEmpty()) {
            // No relevant colleges changed, so exit early
            return;
        }
        
        // Query related students of those colleges
        List<Student__c> studentsToUpdate = new List<Student__c>();
        //bulk Update - Bulkify trigger
        
        for (Student__c student : [SELECT Id, Discount__c, College__c FROM Student__c WHERE College__c IN :collegeIds]) {
            if (student.Discount__c != null) {
                if (student.Discount__c > 100) {
                    student.Discount__c = 1111;
                } else {
                    student.Discount__c = 2222;
                }
                studentsToUpdate.add(student);
            }
        }
        
        if (!studentsToUpdate.isEmpty()) {
            update studentsToUpdate;
        }
        
        System.debug('After update triggered for colleges with updated budgets > 50000: ' + collegeIds);
    }
    
    
    
    
}