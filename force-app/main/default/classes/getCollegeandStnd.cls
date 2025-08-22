@RestResource(urlMapping='/getcollegeWithStudents/*') //https://orgfarm-81509904ff-dev-ed.develop.my.salesforce.com/services/apexrest/getcollegeWithStudents

global with sharing class getCollegeandStnd {

    @HttpGet
    global static CollegeWithStudentsResponse getCollegeWithStudents() {
        RestRequest req = RestContext.request;
        String collegeId = req.requestURI.substringAfter('/getcollegeWithStudents/');

        if (String.isBlank(collegeId)) {
            throw new FunctionalException('College ID is required.');
        }

        // Fetch college with related students using nested SOQL
        College__c college = [
            SELECT Id, Name,
                (SELECT Id, Name  FROM Students__r)
            FROM College__c
            WHERE Name = :collegeId
            LIMIT 1
        ];

        // Build response
        CollegeWithStudentsResponse response = new CollegeWithStudentsResponse();
        response.Id = college.Id;
        response.CollName = college.Name;
        //response.Location__c = college.Location__c;
        response.Students = new List<StudentSummary>();

        for (Student__c s : college.Students__r) {
            StudentSummary summary = new StudentSummary();
            summary.Id = s.Id;
            summary.Name = s.Name;
            //summary.Email__c = s.Email__c;
            response.Students.add(summary);
        }

        return response;
    }

    // Wrapper classes for clean response
    global class CollegeWithStudentsResponse {
        public Id Id;
        public String CollName;
        //public String Location__c;
        public List<StudentSummary> Students;
    }

    global class StudentSummary {
        public Id Id;
        public String Name;
       // public String Email__c;
    }

    global class FunctionalException extends Exception {}
}