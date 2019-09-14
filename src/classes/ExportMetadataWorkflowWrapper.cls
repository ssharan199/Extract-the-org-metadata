public class ExportMetadataWorkflowWrapper {
    Public WorkflowWrapper wf{get;set;}
    Public List<WorkflowWrapper.Records> extractedRecords {get;set;}
     
    public ExportMetadataWorkflowWrapper(){
        String metadataName=ApexPages.currentPage().getParameters().get('radiodata');
        if(metadataName=='Workflow'){
        Http h = new Http();
        
       HttpRequest req = new HttpRequest();
       
       req.setEndpoint('callout:ToolingAPINamecred/services/data/v35.0/tooling/query/?q=select+id,name,TableEnumOrId+From+WorkflowRule'); 
        req.setMethod('GET'); 
req.setHeader('Content-Type', 'application/json');
HttpResponse res = h.send(req);
System.debug('res'+res.getbody());
        //convert string into object
      JSONParser parser = JSON.createParser(res.getBody());     
      wf = (WorkflowWrapper)JSON.deserialize(res.getBody(), WorkflowWrapper.class);
    }
    }
}