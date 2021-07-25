/** @description
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
 * https://trailhead.salesforce.com/content/learn/modules/apex_patterns_sl/apex_patterns_sl_apply_uow_principles
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @author         Emalee Soddy   <hello@emaleesoddy.com>
 * @version        1.0
 * @created        7/25/2021
 * @modified       7/25/2021
 * @systemLayer    Test
 * ──────────────────────────────────────────────────────────────────────────────────────────────────
 * @changes
 * v1.0             hello@emaleesoddy.com
 * 7/25/2021        Initial creation of test class.
 *
 * ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/
@IsTest
private class UnitOfWorkTest {

    /** @description
     * ───────────────────────────────────────────────────────────────────────────────────────────────┐
     * One or two sentence description of this Outer Method.
     * ────────────────────────────────────────────────────────────────────────────────────────────────
     * @param    NAME    DESCRIPTION (MENTION PARAMETER TYPE IN DESCRIPTION)
     * @param    NAME    DESCRIPTION (MENTION PARAMETER TYPE IN DESCRIPTION)
     * ───────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    @IsTest
    static void challengeComplete() {

        // create unit of work
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
                new Schema.SObjectType[] {
                        Account.SObjectType,
                        Contact.SObjectType,
                        Note.SObjectType
                }
        );

        // create 100 accounts
        for (Integer a = 0; a < 100; a++) {
            Account theAccount = new Account();
            theAccount.Name = 'Account ' + a;
            uow.registerNew(theAccount);
            // create 5 contacts
            for (Integer c = 0; c < 5; c++) {
                Contact theContact = new Contact();
                theContact.FirstName = 'Contact';
                theContact.LastName = String.valueOf(c);
                uow.registerNew(theContact, Contact.AccountId, theAccount);
                // create 1 note
                Note theNote = new Note();
                theNote.Title = 'Contact Note';
                theNote.Body = 'Here is a note.';
                uow.registerNew(theNote, Note.ParentId, theContact);
            }
        }

        // commit to the database
        uow.commitWork();

        // required asserts
        System.assertEquals(100, [SELECT Id FROM Account].size());
        System.assertEquals(500, [SELECT Id FROM Contact].size());
        System.assertEquals(500, [SELECT Id FROM Note].size());
    }
}