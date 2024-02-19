/**
 * @description       : 
 * @author            : shubham Jaurat
 * * @group             : 
 * @last modified on  : 02-02-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger AccountTriggers on Account (after update) {
   if(trigger.isafter && trigger.isUpdate){
       AccountTriggerController.accountUpdated(trigger.new);
   }

}l