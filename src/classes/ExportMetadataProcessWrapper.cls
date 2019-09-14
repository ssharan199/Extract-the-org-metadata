public class ExportMetadataProcessWrapper {
    Public ProcessFlowWrapper pf{get;set;}
    Public List<ProcessFlowWrapper.Records> extractedRecords {get;set;}
    Public String metadataName{get;set;}
    
    public ExportMetadataProcessWrapper(){
     metadataName=ApexPages.currentPage().getParameters().get('radiodata');
        if(metadataName=='ProcessFlow'){        
            Http h = new Http();
       HttpRequest req = new HttpRequest();
       req.setEndpoint('callout:ToolingAPINamecred/services/data/v44.0/tooling/query?q=Select+Id,Description+From+Flow'); 
        req.setMethod('GET'); 
		req.setHeader('Content-Type', 'application/json');
		HttpResponse res = h.send(req);
		System.debug('res'+res.getbody());
        //convert string into object
        pf = (ProcessFlowWrapper)JSON.deserialize(res.getBody(), ProcessFlowWrapper.class);
    }
    }
}