global class CollegeSOAPServiceNew {

    // Wrapper class for College__c
    global class CollegeWrapper {
        webservice String Id;
        webservice String Name;
       // webservice Integer Total_Budget__c;
       // webservice String Location__c;
        webservice List<StudentWrapper> students;
        
        // Constructor from sObject
        public CollegeWrapper(College__c c) {
            this.Id = c.Id;
            this.Name = c.Name;
            //this.Total_Budget__c = c.Total_Budget__c;
            //this.Location__c = c.Location__c;
            this.students = new List<StudentWrapper>();
            
            if (c.Students__r != null) {
                for (Student__c s : c.Students__r) {
                    this.students.add(new StudentWrapper(s));
                }
            }
        }
    }
    
    // Wrapper class for Student__c (related object)
    global class StudentWrapper {
        webservice String Id;
        webservice String Name;
        
        public StudentWrapper(Student__c s) {
            this.Id = s.Id;
            this.Name = s.Name;
        }
    }

    // Now return List of wrapper classes instead of sObjects
    webservice static List<CollegeWrapper> getCollegesWithBudgetGreaterThan10000() {
        List<College__c> colleges = [
            SELECT Id, Name, Total_Budget__c, Location__c,
                   (SELECT Id, Name FROM Students__r)
            FROM College__c 
            WHERE Total_Budget__c > 10000 limit 10
        ];
        
        List<CollegeWrapper> result = new List<CollegeWrapper>();
        for (College__c c : colleges) {
            result.add(new CollegeWrapper(c));
        }
        return result;
    }

    // You can do the same wrapping for other methods similarly
}