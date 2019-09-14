public class exportMetadataforVf {
    Public String sObjname {get;set;}
    public user currentuser {get;set;}
    Public List<VisualExcelmMetadataWrapper> result1 {get;set;}
        Public object APIName {get;set;}
        Public object IsCustomizable {get;set;}
        Public object IsExternal {get;set;}
        Public object IsRequired {get;set;}
        Public object IsUnique {get;set;}
        Public object IsLabel {get;set;}
        Public object IsLength {get;set;}
    public String xlsHeader{
    get{
        //for dividing sheet
        String strHeader = '';
        strHeader += '<?xml version="1.0"?>';
        strHeader += '<?mso-application progid="Excel.Sheet"?>';
        return strHeader;
    }
}
    public exportMetadataforVf(){
        String startDate = ApexPages.currentPage().getParameters().get('startDate');
        currentuser = [select Id, Name,Email,UserType from User where Id =:UserInfo.getUserId()];
        List<String> objlist=new List<String>();
        string[] strARR =  startDate.split(';');
            objlist.addAll(strARR);
         result1 = exportmetadata.visualeExcelMetadata(objlist);
    }
}