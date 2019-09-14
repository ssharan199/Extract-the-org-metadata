public class ExportMetadataRadioVf {
    Public List<sobject> obj {get;set;}
    Public Id id {get;set;}
    Public String Name {get; set;}
    Public WorkflowWrapper wf {get; set;} 
    
    public ExportMetadataRadioVf(){
        String metadataName=ApexPages.currentPage().getParameters().get('radiodata');
         if(metadataName == 'ApprovalProcess')
         {
         List<ProcessDefinition> appprocess = [select id,name from processdefinition];
           obj=appprocess;
         }
         else if(metadataName == 'ApexClass')
         {
          List<ApexClass> apxclass = [Select id, name from ApexClass];      
           obj=apxclass;
         }
           else if(metadataName == 'ApexTrigger')
         {
          List<ApexTrigger> atrig = [Select id, name,status from ApexTrigger];   
   
           obj=atrig;
       
         }
          else if(metadataName == 'EmailTemplates')         
          {
            List<EmailTemplate> emtemp  = [select id,name from EmailTemplate];
           
            obj=emtemp;
          }
    }
   
}