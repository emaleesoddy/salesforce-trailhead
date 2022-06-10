/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
 * https://trailhead.salesforce.com/en/content/learn/modules/asynchronous_apex/async_apex_future_methods
 *
 * This class is part of a trailhead module challenge. It contains a method that accepts a list of
 * Accounts and updates a field on the Account record with the total number of Contact records
 * that are associated with the Account.
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @author         Emalee Soddy   <hello@emaleesoddy.com>
 * @version        2.0
 * @created        7/18/2021
 * @modified       6/10/2022
 * @systemLayer    Test
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @changes
 * v2.0            hello@emaleesoddy.com
 * 6/10/2022       Created working test method.
 * 
 * v1.0            hello@emaleesoddy.com
 * 7/18/2021       Initial creation of the class.
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/
@IsTest
private class AccountProcessorTest {
    @IsTest
    private static void countContactsTest() {

        // setup test data
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<300; i++) {
            accounts.add(new Account(Name='Test Account ' + i));
        }
        insert accounts;

        List<Contact> contacts = new List<Contact>();
        List<Id> accountIds = new List<Id>();
        for (Account theAccount : accounts) {
            contacts.add(new Contact(FirstName=theAccount.Name, LastName='Test', AccountId=theAccount.Id));
            accountIds.add(theAccount.Id);
        }
        insert contacts;

        // perform the test, we need start and stop for asynchronous apex
        Test.startTest();
            AccountProcessor.countContacts(accountIds);
        Test.stopTest(); // forces the execution of the future method

        // validate result
        List<Account> updatedAccounts = [SELECT Id, Number_of_Contacts__c FROM Account];
        for (Account theAccount : updatedAccounts) {
            System.assertEquals(1, theAccount.Number_of_Contacts__c);
        }
    }
}