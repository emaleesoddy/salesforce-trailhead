/** @description
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
 * https://trailhead.salesforce.com/content/learn/modules/apex_patterns_sl/apex_patterns_sl_apply_sl_principles
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @author         Emalee Soddy   <hello@emaleesoddy.com>
 * @version        1.0
 * @created        7/25/2021
 * @modified       7/25/2021
 * @systemLayer
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @changes
 * v1.0             hello@emaleesoddy.com
 * 7/25/2021        Initial creation of the class.
 *
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/

@RestResource(UrlMapping='/case/*/close')
global with sharing class CaseCloseResource {

    /** @description
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
     * POST method to close a case w/ reason.
     * ────────────────────────────────────────────────────────────────────────────────────────────────
     * @param    reason    A string containing the reason for closing a Case record.
     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    @HttpPost
    global static void closeCase(String reason) {
        RestRequest request = RestContext.request;

        String[] uriParts = request.requestURI.split('/');
        Id caseId = uriParts[2];

        CaseService.closeCases(new Set<Id> { caseId },reason);
    }

}