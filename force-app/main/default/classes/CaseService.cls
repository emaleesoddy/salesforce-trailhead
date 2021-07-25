/** @description
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
 * https://trailhead.salesforce.com/content/learn/modules/apex_patterns_sl/apex_patterns_sl_apply_sl_principles
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @author         Emalee Soddy   <hello@emaleesoddy.com>
 * @version        1.0
 * @created        7/25/2021
 * @modified       7/25/2021
 * @systemLayer    Service
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @changes
 * v1.0             hello@emaleesoddy.com
 * 7/25/2021        Initial creation of the class.
 *
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/
public with sharing class CaseService {

    /** @description
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
     * This closes and sets the reason for one or more specified Case records.
     * ────────────────────────────────────────────────────────────────────────────────────────────────
     * @param    caseIds        A set of Case record Ids to close.
     * @param    closeReason    A string containing the close message for the specified Case records.
     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static void closeCases(Set<Id> caseIds, String closeReason) {

        // null check & error handling
        if (caseIds == null || caseIds.size() == 0) {
            throw new CaseServiceException('Case(s) not specified.');
        }
        if (String.isEmpty(closeReason) || String.isBlank(closeReason)) {
            throw new CaseServiceException('Close reason cannot be blank.');
        }

        // query the cases, set up list for CaseComments
        List<Case> closedCases = [SELECT Id,Status,Reason FROM Case WHERE Id IN :caseIds];

        // set up lists for updated records
        List<Case> closeReasons = new List<Case>();

        // close the case and add reason
        for (Case thisCase : closedCases) {
            thisCase.Status = 'Closed';
            thisCase.Reason = closeReason;
            closeReasons.add(thisCase);
        }

        // update the database
        Savepoint savepoint = Database.setSavepoint();
        try {
            update closeReasons;
        } catch (Exception error) {
            Database.rollback(savepoint);
            throw error;
        }

    }

    /** @description
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
     * Extend the Exception class for handling errors in this service.
     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public class CaseServiceException extends Exception {
    }

}