trigger CollegeTrigger on College__c (before insert, before update, after insert, after update) {
    
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            for (College__c college : Trigger.new) {
                if (college.Total_Budget__c != null && college.Total_Budget__c < 10000) {
                    college.Location__c = 'Pune';
                } else {
                    college.Location__c = 'Delhi';
                }
            }
        } 
        
        if (Trigger.isUpdate) {
            for (College__c college : Trigger.new) {
                if (college.Total_Budget__c != null && college.Total_Budget__c > 10000) {
                    college.Location__c = 'Mumbai';
                } else {
                    college.Location__c = 'Chennai';
                }
            }
        }
    }
    
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            // Create a sample Student__c record for each new College__c
            List<Student__c> studentsToInsert = new List<Student__c>();
            
            for (College__c college : Trigger.new) {
                Student__c student = new Student__c();
                student.Name = 'Sample Student';
                student.College__c = college.Id; 
                //student.Age__c = 18;
                //student.Course__c = 'B Tech';
                studentsToInsert.add(student);
            }
            
            if (!studentsToInsert.isEmpty()) {
                insert studentsToInsert;
            }
            
            System.debug('After Insert logic triggered for College__c records.');
        }
        if (Trigger.isUpdate) {
            // Add after-update logic here
            // update related objects, etc.
            System.debug('After Update logic triggered for College__c records.');
        }
    }
}


/*
 
trigger CollegeTrigger on College__c (before insert, before update, after insert, after update) {
    
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            CollegeTriggerHandler.handleBeforeInsert(Trigger.new);
        } 
        if (Trigger.isUpdate) {
            CollegeTriggerHandler.handleBeforeUpdate(Trigger.new);
        }
    }

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            CollegeTriggerHandler.handleAfterInsert(Trigger.new);
        }
        if (Trigger.isUpdate) {
            CollegeTriggerHandler.handleAfterUpdate(Trigger.new);
        }
    }
}

*/