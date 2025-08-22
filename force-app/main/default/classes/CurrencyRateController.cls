public with sharing class CurrencyRateController {
    @AuraEnabled(cacheable=true)
    public static Decimal convertUsdToInr(Decimal amount) {
        system.debug('@@4 USD value' + amount);
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        String endpoint = 'https://v6.exchangerate-api.com/v6/f983e42ebcbf7b5bd26f5633/latest/USD';
        req.setMethod('GET');
        req.setEndpoint(endpoint);
        system.debug('@@9 Payload +' +req);
        
        HttpResponse res = h.send(req);
        system.debug('@@12 response +' +res);

        if (res.getStatusCode() == 200) {
            Map<String, Object> body = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            Map<String, Object> rates = (Map<String, Object>) body.get('conversion_rates');
             system.debug('@@18 Payload +' +body);
             system.debug('@@19 Payload +' +rates);
            if (rates.containsKey('INR')) {
                Decimal rate = (Decimal) rates.get('INR');
                return amount * rate;
            } else {
                throw new AuraHandledException('INR rate not found');
            }
        } else {
            throw new AuraHandledException('Error fetching rate: ' + res.getStatus());
        }
    }
    @AuraEnabled
    public static void updateCollegeBudget(Id collegeId, Decimal totalBudget) {
        College__c collegeRecord = [SELECT Id, Total_Budget__c FROM College__c WHERE Id = :collegeId LIMIT 1];
        collegeRecord.Total_Budget__c = totalBudget;
        update collegeRecord;
    }
}