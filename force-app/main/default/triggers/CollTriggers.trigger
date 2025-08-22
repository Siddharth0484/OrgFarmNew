trigger CollTriggers on College__c (before insert, before update, after insert, after update) {
    
    if (Trigger.isBefore) { //comparmentalized
        if (Trigger.isInsert) {
           // system.debug('@@5-isInsert'+);
            CollegeTriggerHandler.handleBeforeInsert(Trigger.new);
        } 
        if (Trigger.isUpdate) {
            CollegeTriggerHandler.handleBeforeUpdate(Trigger.new);
            CollegeTriggerHandler.handleBeforeUpdateNew(Trigger.new);//used or Adding XYZ functional 
        }
    }

    if (Trigger.isAfter) { 
        if (Trigger.isInsert) {
           
            CollegeTriggerHandler.handleAfterInsert(Trigger.new);
        }
        if (Trigger.isUpdate) {
            CollegeTriggerHandler.handleAfterUpdate(Trigger.new,Trigger.oldMap);
        }
    }
}





/*

public static void handleAfterUpdate(List<College__c> colleges, Map<Id, College__c> oldMap) {
    
    // Set to collect College Ids which meet the condition (Total_Budget changed & > 5000)
    Set<Id> collegeIdsToProcess = new Set<Id>();
    
    // First loop: check condition and update Location__c on the record in memory (if needed)
    for (College__c college : colleges) {
        College__c oldCollege = oldMap.get(college.Id);
        
        if (college.Total_Budget__c != oldCollege.Total_Budget__c && college.Total_Budget__c != null && college.Total_Budget__c > 5000) {
            
            // Update Location__c based on budget
            if (college.Total_Budget__c > 50000) {
                college.Location__c = 'Mumbai';
            } else {
                college.Location__c = 'Chennai';
            }
            
            collegeIdsToProcess.add(college.Id);
        }
    }
    
    // If no college meets the criteria, skip querying and updating students
    if (collegeIdsToProcess.isEmpty()) {
        System.debug('No colleges meet the criteria for processing after update.');
        return;
    }
    
    // Query related students for those colleges
    List<Student__c> studentsToUpdate = new List<Student__c>();
    for (Student__c student : [
        SELECT Id, Discount__c, College__c 
        FROM Student__c 
        WHERE College__c IN :collegeIdsToProcess
    ]) {
        if (student.Discount__c != null) {
            if (student.Discount__c > 100) {
                student.Discount__c = 500;
                studentsToUpdate.add(student);
            } else {
                student.Discount__c = 1000;
                studentsToUpdate.add(student);
            }
        }
    }
    
    // Bulk update students if any need changes
    if (!studentsToUpdate.isEmpty()) {
        update studentsToUpdate;
    }
    
    System.debug('After update triggered for colleges: ' + colleges);
}

*/