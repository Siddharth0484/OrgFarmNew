public with sharing class UserSearchHandler {

    @InvocableMethod(label='Find User by Email' description='Searches for a User record based on the provided email address.')
    public static List<UserResult> findUserByEmail(List<String> emails) {
        List<UserResult> results = new List<UserResult>();

        for (String email : emails) {
            List<User> users = [SELECT Name, Email FROM User WHERE Email = :email LIMIT 1];
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