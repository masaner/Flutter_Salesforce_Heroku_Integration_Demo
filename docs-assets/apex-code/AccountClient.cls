@RestResource(urlmapping='/Accounts/*')
global with sharing class AccountClient 
{
    @HttpGet
    global static List<Account> AccountClient()
    {
        List<Account> accounts = [  SELECT Id, Name, Phone, Email__c, Location__c, IsDemo__c 
                                    FROM Account 
                                    WHERE IsDemo__c = TRUE];
        return accounts;
    }
}