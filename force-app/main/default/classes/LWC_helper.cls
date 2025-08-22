public with sharing class LWC_helper {
    
    
    // Fetch a list of Contacts based on a partial account name
    @AuraEnabled(cacheable=true)
    public static List<Contact> getListOfContact(String accName) {
        if (accName != null && String.isNotEmpty(accName)) {
            return [
                SELECT Id, Name, Phone, Description, Email
                FROM Contact
                WHERE Name LIKE :('%' + accName + '%')
                LIMIT 10
            ];
        } else {
            return new List<Contact>();
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<College__c> getListofCollege() {
        return [
            SELECT Id, Name, Total_Budget__c
            FROM College__c
            WHERE Total_Budget__c != null
            ORDER BY Total_Budget__c DESC
            LIMIT 4
        ];
    }
}