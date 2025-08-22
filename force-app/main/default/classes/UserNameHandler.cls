public with sharing class UserNameHandler {

    @InvocableMethod(label='Find User by Name' description='Searches for a User record based on the provided name.')
    public static List<UserResult> findUserByName(List<String> names) {
        List<UserResult> results = new List<UserResult>();

        for (String name : names) {
            List<User> users = [SELECT Name, Email FROM User WHERE Name = :name LIMIT 1];
            if (!users.isEmpty()) {
                UserResult result = new UserResult();
                result.userName = users[0].Name;
                result.userEmail = users[0].Email;
                results.add(result);
            }
        }

        return results;
    }

    public class UserResult {
        @InvocableVariable(label='User Name')
        public String userName;

        @InvocableVariable(label='User Email')
        public String userEmail;
    }
}