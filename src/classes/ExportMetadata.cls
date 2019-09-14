public class ExportMetadata {

 @AuraEnabled
    public static List <String> getPicklistValues() {
         List<String> plValues = new List<String>();
        //Schema.getGlobalDescribe()-It returns a map of all sObject names (keys) to sObject tokens (values) for the standard and custom objects 
         for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
             
           String name = objTyp.getDescribe().getName();
           
            // Exclude all the unwanted Sobjects e.g. History, Share etc.
            if(!name.containsignorecase('history') && !name.containsignorecase('tag')&&
             !name.containsignorecase('share') && !name.containsignorecase('feed'))
            {
                plvalues.add(name);
                plvalues.sort();
            }   
             
       }
        return plValues;
    }    
    @AuraEnabled
    public static List<exportmetadatawrapper> exportMetadata(List<String> sobjectName){
        List<exportmetadatawrapper> listWrapperClass = new List<exportmetadatawrapper>();
        for(String s:sobjectName){
            // Returns a map of all sObject names (keys) to sObject tokens (values) for the standard and custom objects defined in your organization.
            SObjectType sot = schema.getGlobalDescribe().get(s);
            //getDescribe().fields-This will return array of the fields associated with an object.
            Map<String,schema.SObjectField> mapField = sot.getDescribe().fields.getMap();
           
            //store in inner class
            List<exportmetadatawrapper.exportmetadatainner> listinnerClass = new List<exportmetadatawrapper.exportmetadatainner>();
           
            for(schema.SObjectField sof: mapField.values()){
                //DescribeFieldResult class: Contains methods for describing sObject fields.
             schema.DescribeFieldResult fieldResult = sof.getDescribe();
             Map<String,object> mapobject = new Map<String,object>();                                          
            //Returns the name of the field.
             mapobject.put('APIName',fieldResult.getName());   
            //Returns true if the field is a custom , false if it is a standard field.
             mapobject.put('IsCustomizable',fieldResult.isCustom());
               // Returns true if the field is used as an external ID, false otherwise.
             mapobject.put('IsExternal',fieldResult.isExternalID());  
           // To check if field is required or not
             mapobject.put('IsRequired', fieldResult.isCreateable() && !fieldResult.isNillable() && !fieldResult.isDefaultedOnCreate());     
           // Returns true if the value for the field must be unique, false otherwise
            mapobject.put('IsUnique',fieldResult.isUnique()); 
           //  Returns the field's label, which may or may not match the field name. 
             mapobject.put('IsLabel',fieldResult.getLabel());   
             mapobject.put('IsLength',fieldResult.getLength());   
             //mapobject.put('Is Type',fieldResult.getType());   
             //1 object and all its fields
             exportmetadatawrapper.exportmetadatainner metadataInner = new exportmetadatawrapper.exportmetadatainner(mapobject);
              //to save the map- having field and its properties- name, address
                listinnerClass.add(metadataInner);
            }
  
            //object level
            exportmetadatawrapper wrapperClass = new exportmetadatawrapper(listinnerClass,s);
            listWrapperClass.add(wrapperClass);
        }
     //String listWrapperClass1=JSON.serialize(listWrapperClass);
        return listWrapperClass;
    }
 @AuraEnabled
    public static list<sobject> exportMetadataList(String metadataName){
         list<sObject> obj=new list<sObject>();

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
                system.debug('obj return in apex');
system.debug('obj'+obj);
    return obj;
}

    @AuraEnabled
    public static WorkflowWrapper exportWorkflow() {
        Http h = new Http();
        //create connected app 
        //callout:ToolingAPINamecred
       HttpRequest req = new HttpRequest();
        //authorization is based on auth provider
       req.setEndpoint('callout:ToolingAPINamecred/services/data/v35.0/tooling/query/?q=select+id,name,TableEnumOrId+From+WorkflowRule'); 
        req.setMethod('GET'); 
req.setHeader('Content-Type', 'application/json');
HttpResponse res = h.send(req);
System.debug('res'+res.getbody());
        //convert string into object
      JSONParser parser = JSON.createParser(res.getBody());     
      //WorkflowWrapper wf = new WorkflowWrapper(parser);
        WorkflowWrapper wf = (WorkflowWrapper)JSON.deserialize(res.getBody(), WorkflowWrapper.class);
        return wf;
} 

    @AuraEnabled
public static ValidationWrapper exportValidation() {
        Http h = new Http();
       HttpRequest req = new HttpRequest();
       req.setEndpoint('callout:ToolingAPINamecred/services/data/v44.0/tooling/query?q=Select+Id,Active,Description,EntityDefinition.DeveloperName,ErrorDisplayField,+ErrorMessage+From+ValidationRule'); 
        req.setMethod('GET'); 
req.setHeader('Content-Type', 'application/json');
HttpResponse res = h.send(req);
System.debug('res'+res.getbody());
        //convert string into object
        ValidationWrapper vw = (ValidationWrapper)JSON.deserialize(res.getBody(), ValidationWrapper.class);
        return vw;
}
    
    @AuraEnabled
public static ProcessFlowWrapper processFlow() {
           Http h = new Http();
       HttpRequest req = new HttpRequest();
       req.setEndpoint('callout:ToolingAPINamecred/services/data/v44.0/tooling/query?q=Select+Id,Description+From+Flow'); 
        req.setMethod('GET'); 
req.setHeader('Content-Type', 'application/json');
HttpResponse res = h.send(req);
System.debug('res'+res.getbody());
        //convert string into object
        ProcessFlowWrapper pf = (ProcessFlowWrapper)JSON.deserialize(res.getBody(), ProcessFlowWrapper.class);
        return pf;
}
   public static List<VisualExcelmMetadataWrapper> visualeExcelMetadata(List<String> sobjectName){
        List<VisualExcelmMetadataWrapper> listWrapperClass = new List<VisualExcelmMetadataWrapper>();
        for(String s:sobjectName){
            // Returns a map of all sObject names (keys) to sObject tokens (values) for the standard and custom objects defined in your organization.
            SObjectType sot = schema.getGlobalDescribe().get(s);
            //String = account
            //schema.SObjectField - billingadd, zipcode
            Map<String,schema.SObjectField> mapField = sot.getDescribe().fields.getMap();
            //store in inner class
            List<VisualExcelmMetadataWrapper.ExcelMetadataInnerWrapper> listinnerClass = new List<VisualExcelmMetadataWrapper.ExcelMetadataInnerWrapper>();
           //propery related to field
            for(schema.SObjectField sof: mapField.values()){
            schema.DescribeFieldResult fieldResult = sof.getDescribe();
            object a = fieldResult.getName();
            object b = fieldResult.isCustom();
            object c = fieldResult.isExternalID();
            object d = fieldResult.isCreateable() && !fieldResult.isNillable() && !fieldResult.isDefaultedOnCreate();
            object e = fieldResult.isUnique();
            object f = fieldResult.getLabel();
            object g = fieldResult.getLength();
            VisualExcelmMetadataWrapper.ExcelMetadataInnerWrapper newwrapper=new VisualExcelmMetadataWrapper.ExcelMetadataInnerWrapper(a,b,c,d,e,f,g);
            listinnerClass.add(newwrapper);    
            } 
            VisualExcelmMetadataWrapper visualexcel = new VisualExcelmMetadataWrapper(s,listinnerClass);
            listWrapperClass.add(visualexcel);
        }
       system.debug('wf'+listWrapperClass);
        return listWrapperClass;
    }         
}