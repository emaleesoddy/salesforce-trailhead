/** @description
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
 * https://trailhead.salesforce.com/content/learn/modules/apex_patterns_sl/apex_patterns_sl_apply_sl_principles
 *
 * This class was authored by Salesforce as part of a learning module.
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @author         Salesforce Trailhead
 * @systemLayer    Service
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @changes
 * v1.1            hello@emaleesoddy.com
 * 7/25/2021       Clean-up of provided class.
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/
public with sharing class OpportunitiesService {

    /** @description
     * ─────────────────────────────────────────────────────────────────────────────────────────────┐
     * Apply a given discount to a set of opportunities, and any present line-items.
     * ──────────────────────────────────────────────────────────────────────────────────────────────
     * @param    opportunityIds       the set of opportunityIds to apply the specified discount to
     * @param    discountPercentage   the percentage discount to apply to each specified opportunity
     * ─────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static void applyDiscounts(Set<Id> opportunityIds, Decimal discountPercentage) {
        // Unit of Work
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
                new List<SObjectType> { OpportunityLineItem.SObjectType, Opportunity.SObjectType  }
        );

        // Validate parameters
        if (opportunityIds == null || opportunityIds.size() == 0) {
            throw new OpportunityServiceException('Opportunities not specified.');
        }
        if (discountPercentage < 0 || discountPercentage > 100) {
            throw new OpportunityServiceException('Invalid discount to apply.');
        }
        // Query Opportunities and Lines (SOQL inlined for this example, see Selector pattern in later module)
        List<Opportunity> opportunities = [
                SELECT Amount, (SELECT UnitPrice FROM OpportunityLineItems)
                FROM Opportunity
                WHERE Id IN :opportunityIds
                WITH SECURITY_ENFORCED
        ];
        // Update Opportunities and Lines (if present)
        List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
        List<OpportunityLineItem> opportunityLinesToUpdate = new List<OpportunityLineItem>();
        Decimal factor = 1 - (discountPercentage == null ? 0 : discountPercentage / 100);
        for(Opportunity opportunity : opportunities) {
            // Apply to Opportunity Amount
            if(opportunity.OpportunityLineItems!=null && opportunity.OpportunityLineItems.size()>0) {
                for(OpportunityLineItem oppLineItem : opportunity.OpportunityLineItems) {
                    oppLineItem.UnitPrice = oppLineItem.UnitPrice * factor;
                    uow.registerDirty(oppLineItem);
                }
            } else {
                opportunity.Amount = opportunity.Amount * factor;
                uow.registerDirty(opportunity);
            }
        }
        // Commit Unit of Work
        uow.commitWork();
    }

    /** @description
     * ─────────────────────────────────────────────────────────────────────────────────────────────┐
     * Extend the Exception class to use in this service class.
     * ─────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public class OpportunityServiceException extends Exception {
    }
}