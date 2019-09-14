public class VisualExcelmMetadataWrapper {
    Public String sObjname {get;set;}
    public List<excelmetadatainnerwrapper> innerwrapper {get;set;}
    
    public VisualExcelmMetadataWrapper(String sname, List<ExcelMetadataInnerWrapper> innerwrapper){
        this.sObjname= sname;
        this.innerwrapper = innerwrapper;
    }
    public class ExcelMetadataInnerWrapper{
        Public object APIName {get;set;}      
        Public object IsCustomizable {get;set;}
        Public object IsExternal {get;set;}
        Public object IsRequired {get;set;}
        Public object IsUnique {get;set;}
        Public object IsLabel {get;set;}
        Public object IsLength {get;set;}
        
    // Wrapper Class Construction
    public ExcelMetadataInnerWrapper(object a,object b,object c, object d,object e,object f,object g){
     this.APIName = a;   
     this.IsCustomizable = b;
        this.IsExternal=c;
            this.IsRequired=d;
            this.IsUnique=e;
            this.IsLabel=f;
            this.IsLength=g;
    }
    }
    }