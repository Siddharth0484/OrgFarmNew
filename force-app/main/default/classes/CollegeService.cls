global with sharing class CollegeService {
    
    // Inner class to represent College details
    global class CollegeInfo {
        webservice String Id;
        webservice String Name;
    }
    
    // SOAP webservice method to get colleges with Total_Budget__c > 10000
    webservice static List<CollegeInfo> getCollegesByBudget() {
        List<CollegeInfo> colleges = new List<CollegeInfo>();
        
        // Query Id and Name of colleges matching the condition
        for (College__c col : [SELECT Id, Name FROM College__c WHERE Total_Budget__c > 10000]) {
            CollegeInfo info = new CollegeInfo();
            info.Id = col.Id;
            info.Name = col.Name;
            colleges.add(info);
        }
        
        return colleges;
    }
}