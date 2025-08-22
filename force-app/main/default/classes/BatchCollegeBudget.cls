global class BatchCollegeBudget implements Database.Batchable<SObject> { //Database.executeBatch(new BatchCollegeBudget(), 200);

    global Database.QueryLocator start(Database.BatchableContext bc) {
        // Return a QueryLocator to handle large volumes newew
         return Database.getQueryLocator(
            'SELECT Id, Total_Budget__c FROM College__c WHERE Total_Budget__c >= 320000'
        );
    }

    global void execute(Database.BatchableContext bc, List<College__c> scope) {
        for (College__c college : scope) {
            college.Total_Budget__c = 0;
        }
        database.update (scope,false);
    }

    global void finish(Database.BatchableContext bc) {
        System.debug(' Batch complete: Total_Budget__c set to 1 for all colleges.');
    }
}