@RestResource(urlMapping='/getStudentsAPI') //https://https://orgfarm-81509904ff-dev-ed.develop.lightning.force.com/services/apexrest/getStudentsAPI
global with sharing class getStudentsAPI {

    @HttpGet
    global static List<Student__c> getStudents() {
        // You can add filters or limits as needed
      //  return [SELECT Id, Name FROM Student__c LIMIT 100];
        
        return [SELECT Id, Email__c, DOB__c, Phone__c, College__c FROM Student__c limit 5];
    }
}