trigger ColleTrigger on College__c (before insert, before update) {
    
    if (Trigger.isBefore) {
        
        // Before Insert//SIDDHARTH and SAMeer
         if (Trigger.isInsert) {
            for (College__c college : Trigger.new) {
                system.debug('@@Coll'+college.id);
                if (college.Total_Budget__c != null && college.Total_Budget__c < 10000) {
                    college.Location__c = 'Punex';
                } else {
                    college.Location__c = 'Delhix';
                }
            }
        }
        
        // Before Update
        if (Trigger.isUpdate) {
            for (College__c college : Trigger.new) {
                if (college.Total_Budget__c != null && college.Total_Budget__c < 10000) {
                    college.Location__c = 'Mumbai_ABC';
                } else {
                    college.Location__c = 'Chennai_ABC';
                }
            }
        }
    }
}