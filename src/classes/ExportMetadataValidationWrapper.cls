public class ExportMetadataValidationWrapper {
    Public ValidationWrapper vw{get;set;}
      Public List<ValidationWrapper.Records> extractedRecords {get;set;}
   
    Public ExportMetadataValidationWrapper(){
           String metadataName=ApexPages.currentPage().getParameters().get('radiodata');
        if(metadataName=='ValidationRule'){
        Http h = new Http();
       HttpRequest req = new HttpRequest();
       req.setEndpoint('callout:ToolingAPINamecred/services/data/v44.0/tooling/query?q=Select+Id,Active,Description,EntityDefinition.DeveloperName,ErrorDisplayField,+ErrorMessage+From+ValidationRule'); 
        req.setMethod('GET'); 
req.setHeader('Content-Type', 'application/json');
HttpResponse res = h.send(req);
        //convert string into object
         vw = (ValidationWrapper)JSON.deserialize(res.getBody(), ValidationWrapper.class);
}
    }
}