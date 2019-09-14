public class exportmetadatawrapper {
    
    //multiple fields
    @AuraEnabled
   Public List<exportmetadatainner> emd {get;set;}
    @AuraEnabled
    String sobjName {get;set;}//object name selected
 
    // Wrapper Class Construction
    public exportmetadatawrapper(List<exportmetadatainner> emdd, String objName){
     this.emd = emdd;   
     this.sobjName = objName;
    }

   //inner class holds map- string - field, object - fei
 
    public class exportmetadatainner{
        @AuraEnabled public Map<String,object> mapOfObject{get;set;}
        //innerclass constructor
        public exportmetadatainner(Map<String,object> mapObjects ){
          this.mapOfObject = mapObjects;
        }        
    }
    public class excelmetadatawrapper {
    
    //multiple fields
    @AuraEnabled
   Public object APIName {get;set;}
        
        Public object IsCustomizable {get;set;}
        Public object IsExternal {get;set;}
        Public object IsRequired {get;set;}
        Public object IsUnique {get;set;}
        Public object IsLabel {get;set;}
        Public object IsLength {get;set;}
        
    // Wrapper Class Construction
    public excelmetadatawrapper(object a,object b,object c, object d,object e,object f,object g){
     this.APIName = a;   
     this.IsCustomizable = b;
        this.IsCustomizable=c;
            this.IsCustomizable=d;
            this.IsCustomizable=e;
            this.IsCustomizable=f;
            this.IsCustomizable=g;
    }
    }
}