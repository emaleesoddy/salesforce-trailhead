/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
 * https://trailhead.salesforce.com/en/content/learn/modules/apex_database/apex_database_dml
 *
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @author         Emalee Soddy   <hello@emaleesoddy.com>
 * @version        1.0
 * @created        7/17/2021
 * @modified       7/17/2021
 * @systemLayer    Service
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @changes
 * v1.0            hello@emaleesoddy.com
 * 7/17/2021       Initial creation of the class.
 *
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/

public with sharing class AccountHandler {

    /**
     * ─────────────────────────────────────────────────────────────────────────────────────────────┐
     * Accept a string and attempt to insert a new Account using the string as its name.
     * ──────────────────────────────────────────────────────────────────────────────────────────────
     * @param    accountName    the name of the Account record to create
     * @return   Account        returns the newly created Account record
     * ─────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public static Account insertNewAccount(String accountName) {

        try {

            Account newAccount = new Account(Name = accountName);
            insert newAccount;
            return newAccount;

        } catch (DmlException error) {

            // throw an exception and return nothing if the insert fails
            System.debug('DML exception has occurred: ' + error.getMessage());
            return null;

        }
    }
}