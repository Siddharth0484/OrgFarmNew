public class CollegeBudgetUpdaterWrapper {

    public class CollegeInput {
        @InvocableVariable(label='College Id')
        public Id collegeId;

        @InvocableVariable(label='Location')
        public String location;

        @InvocableVariable(label='Budget')
        public Decimal budget;
    }

    @InvocableMethod(label='Update Edited College Budget' description='Update Total_Budget__c based on Location and Budget')
    public static void updateBudgetForEditedRecords(List<CollegeInput> inputs) {
        if (inputs == null || inputs.isEmpty()) {
            return;
        }

        Map<Id, CollegeInput> inputMap = new Map<Id, CollegeInput>();
        for (CollegeInput input : inputs) {
            inputMap.put(input.collegeId, input);
        }

        List<College__c> collegesToUpdate = [SELECT Id, Location__c, Total_Budget__c FROM College__c WHERE Id IN :inputMap.keySet()];

        for (College__c college : collegesToUpdate) {
            CollegeInput input = inputMap.get(college.Id);
            if (input.location != null && input.location.equalsIgnoreCase('Mumbai')) {
                college.Total_Budget__c = input.budget;
            }
        }

        if (!collegesToUpdate.isEmpty()) {
            update collegesToUpdate;
        }
    }
}