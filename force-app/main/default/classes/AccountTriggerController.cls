/**
 * @description       : 
 * @author            : shubham jaurat
 * @group             : 
 * @last modified on  : 02-02-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountTriggerController {
    // 1. Write a trigger on the Account when the Account is updated check all opportunities related to the account. 
    // Update all Opportunities Stage to close lost if an opportunity created date is greater than 30 days from 
    // today and stage not equal to close won.
  
    public static void accountUpdated(List<Account> accountList ){
        try {
            Set<ID> acountIDs = new Set<ID>();

            for (Account acc : accountList) {
                acountIDs.add(acc.id);
            }

            Datetime dateBefore30Days = datetime.now().addDays(-30);

            List<Opportunity> opportunityList = [Select Id, AccountId, StageName, CreatedDate, CloseDate from Opportunity where AccountId in :acountIDs WITH SECURITY_ENFORCED];

            if(!opportunityList.isEmpty()){
                for (Opportunity opp : opportunityList) {
                    if(opp.CreatedDate > dateBefore30Days && opp.StageName !='Closed Won'){
                        opp.StageName = 'Closed Lost';
                    }
                }
            }
            if(!opportunityList.isEmpty()){
                
                update opportunityList;
            }
        
        } catch (Exception e) {
        System.debug(e);
        }
    }

       
}      
