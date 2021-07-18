/**
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
 * https://trailhead.salesforce.com/en/content/learn/modules/apex_database/apex_database_intro
 *
 * This class contains a method that returns an array of formatted strings.
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @author         Emalee Soddy   <hello@emaleesoddy.com>
 * @version        1.0
 * @created        7/17/2021
 * @modified       7/17/2021
 * @systemLayer    Utility
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @changes
 * v1.0            hello@emaleesoddy.com
 * 7/17/2021       Initial creation of the class.
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/

public with sharing class StringArrayTest {

    /**
     * ─────────────────────────────────────────────────────────────────────────────────────────────┐
     * This method accepts an integer {n} and generates a list of {n} strings to return.
     * ──────────────────────────────────────────────────────────────────────────────────────────────
     * @param    numberToGenerate    the number of strings to generate
     * @return   List<String>        returns a list of strings
     * ─────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public static List<String> generateStringArray(Integer numberToGenerate) {

        List<String> generatedStrings = new List<String>(); // initialize the list to return

        // null check!
        if (numberToGenerate != null && numberToGenerate > 0) {

            for (Integer i=0; i < numberToGenerate; i++) {
                generatedStrings.add('Test ' + i);
            }

        } else {
            System.debug('No integer was passed to the method.');
        }

        return generatedStrings;
    }

}