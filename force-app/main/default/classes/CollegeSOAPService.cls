global class CollegeSOAPService { //SF custom SOAP WEBSERVICE

    webservice static List<College__c> getCollegesWithBudgetGreaterThan10000() {
        return [
            SELECT Id, Name, Total_Budget__c, Location__c,
                   (SELECT Id, Name  FROM Students__r)
            FROM College__c 
            WHERE Total_Budget__c > 10000
        ];
    }
    
     webservice static List<College__c> getColleges() {
        return [
            SELECT Id, Name, Total_Budget__c, Location__c FROM College__c 
            WHERE Total_Budget__c < 1000 limit 10
        ];
    }

        
    

    webservice static List<College__c> getCollegesWithBudgetGreaterThan50000() {
        return [
            SELECT Id, Name, Total_Budget__c, Location__c,
                   (SELECT Id, Name FROM Students__r)
            FROM College__c 
            WHERE Total_Budget__c > 50000
        ];
    }

    webservice static List<College__c> getCollegesWithBudgetGreaterThan90000() {
        return [
            SELECT Id, Name, Total_Budget__c, Location__c,
                   (SELECT Id, Name  FROM Students__r)
            FROM College__c 
            WHERE Total_Budget__c > 90000
        ];
    }
}