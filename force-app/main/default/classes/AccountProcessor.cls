/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
 * https://trailhead.salesforce.com/en/content/learn/modules/asynchronous_apex/async_apex_future_methods
 *
 * This class is part of a trailhead module challenge. It contains a method that accepts a list of
 * Accounts and updates a field on the Account record with the total number of Contact records
 * that are associated with the Account.
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @author         Emalee Soddy   <hello@emaleesoddy.com>
 * @version        1.0
 * @created        7/18/2021
 * @modified       6/10/2022
 * @systemLayer    Service
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @changes
 * v2.0            hello@emaleesoddy.com
 * 6/10/2022       Gettin' back to the trails. Created method.
 * 
 * v1.0            hello@emaleesoddy.com
 * 7/18/2021       Initial creation of the class.
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/
public with sharing class AccountProcessor {

    /**
     * ─────────────────────────────────────────────────────────────────────────────────────────────┐
     * Accept a list of Account Ids to calculate total number of Contact records per Account.
     * ──────────────────────────────────────────────────────────────────────────────────────────────
     * @param    accountIds     the list of Account Ids to calculate Contact records.
     * ─────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    @Future
    public static void countContacts(List<Id> accountIds) {
        List<Account> accounts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds];

        for (Account theAccount : accounts) {
            theAccount.Number_of_Contacts__c = theAccount.Contacts.size();
        }

        update accounts;
    }

}