/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
 * https://trailhead.salesforce.com/en/content/learn/modules/apex_database/apex_database_soql
 *
 * This class is part of a trailhead module challenge. It contains a method that searches for
 * contacts that have a last name matching the first parameter, and a mailing postal code matching
 * the second parameter. It retrieves the ID and Name of the contact records and returns them.
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @author         Emalee Soddy   <hello@emaleesoddy.com>
 * @version        1.0
 * @created        7/18/2021
 * @modified       7/18/2021
 * @systemLayer    Service
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @changes
 * v1.0            hello@emaleesoddy.com
 * 7/18/2021       Initial creation of the class.
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/
public with sharing class ContactSearch {

    /**
     * ─────────────────────────────────────────────────────────────────────────────────────────────┐
     * Accept two strings and perform a SOQL query to retrieve and return matching contacts.
     * ──────────────────────────────────────────────────────────────────────────────────────────────
     * @param    lastName       the string to search for matches in Contact.LastName
     * @param    postalCode     the string to search for matches in Contact.MailingPostalCode
     * @return   List<Contact>  returns the list of contacts matching the criteria
     * ─────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public static List<Contact> searchForContacts(String lastName, String postalCode) {

        List<Contact> listOfContacts = new List<Contact>();

        // null checks!
        if (!String.isEmpty(lastName) && !String.isEmpty(postalCode)) {
            listOfContacts = [  SELECT Id,Name
                                FROM Contact
                                WHERE LastName = :lastName
                                AND MailingPostalCode = :postalCode
                             ];
            if (listOfContacts.isEmpty()) { listOfContacts = null; }
        }

        return listOfContacts;

    }

}