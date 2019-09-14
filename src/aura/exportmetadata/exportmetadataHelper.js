({
      doInit: function(component, event, helper) {
        var action = component.get("c.getPicklistValues");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                var plValues = [];
                for (var i = 0; i < result.length; i++) {
                    plValues.push({
                        label: result[i],
                        value: result[i]
                    });
                }
                component.set("v.listOptions", plValues);
            }
        });
        $A.enqueueAction(action);
    },
    handleChange: function (component, event) {
       
        var selectedOptionsList = event.getParam("value");
       component.set("v.defaultOptions",selectedOptionsList);
    },  
       downloadCsv : function (component, event, helper) {
       var metadataselect = component.get("v.defaultOptions");
        if (metadataselect.length==0)
        {
         alert('Please select one object');
        }
      else if(metadataselect.length>1)
       {
           alert('Please select only one object');
       }
      else{
       var action = component.get("c.exportMetadata");
       action.setParams({  sobjectName : metadataselect });
       action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('result is'+ state);
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                component.set("v.wrapperList",result);
                var listoffield = component.get("v.wrapperList");
                console.log('result is'+ result);
                  var lstPositions=JSON.stringify(listoffield);
               var lstPositions1= JSON.stringify(listoffield[0].emd[0].mapOfObject.APIName);
                var lstPositions2=JSON.stringify(lstPositions1);
                console.log('listoffields'+ lstPositions1);
                console.log('listoffields'+ lstPositions2);
        var data = [];
        var headerArray = [];
        var csvContentArray = [];
       
     var CSV = '\r\nSelected Metadata\r\n';

        
        
        headerArray.push('S.No');
        headerArray.push('API Name');
        headerArray.push('Is Customizable');
		headerArray.push('Is External');
        headerArray.push('Is Required');
        headerArray.push('Is Unique');
        headerArray.push('Is Label');
        headerArray.push('Is Length');
        data.push(headerArray);
                

        var sno = 0;
        for(var i=0;i<listoffield[0].emd.length;i++){
            
            
           
            if(listoffield[0].emd){
                
                var tempArray = [];
                
                sno = parseInt(sno) + parseInt(1);
                tempArray.push('"'+sno+'"');
                console.log('listoffields'+ lstPositions1[i]);
                
                tempArray.push('"'+listoffield[0].emd[i].mapOfObject.APIName+'"');
                tempArray.push('"'+listoffield[0].emd[i].mapOfObject.IsCustomizable+'"');
                  tempArray.push('"'+listoffield[0].emd[i].mapOfObject.IsExternal+'"');
                  tempArray.push('"'+listoffield[0].emd[i].mapOfObject.IsRequired+'"');
                 tempArray.push('"'+listoffield[0].emd[i].mapOfObject.IsUnique+'"');
                tempArray.push('"'+listoffield[0].emd[i].mapOfObject.IsLabel+'"');
                tempArray.push('"'+listoffield[0].emd[i].mapOfObject.IsLength+'"');

                data.push(tempArray);
            }
            
        }
        
        for(var j=0;j<data.length;j++){
            var dataString = data[j].join(",");
            csvContentArray.push(dataString);
        }
        var csvContent = CSV + csvContentArray.join("\r\n");
        //Generate a file name
        var fileName = listoffield[0].sobjName;        
        fileName += ".csv";
        //Initialize file format you want csv or xls
        var uri = 'data:text/csv;charset=utf-8,' + encodeURIComponent(csvContent);
        
        if (navigator.msSaveBlob) { // IE 10+
            var blob = new Blob([csvContent],{type: "text/csv;charset=utf-8;"});
        	navigator.msSaveBlob(blob, 'objectname');
        }
        else{
               
            var link = document.createElement("a");
            link.setAttribute('download',fileName);
            
            link.href = uri;
                       
            link.style = "visibility:hidden";
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);     
    	}
    }
       });
       $A.enqueueAction(action);
           }
      },
    downloadCsvinVfpage: function(component, event, helper){
        var data =component.get("v.defaultOptions");
        if(data == '')
        {
         alert('select one or more objects');   
        }
        else{
        var strData ='';
        for(var i in data){
            strData+= data[i]+';';
        }       
        window.open("/apex/myvf?startDate="+strData, '_blank');
        }
    },
    selectRadio:function(component,event,helper){
        
        var selectedRadio = event.getParam("value");
       component.set("v.value",selectedRadio);
    },
    downloadCsvForRadioList:function(component,event,helper){
         var ComponentselectforRadio = component.get("v.value");
       var action = component.get("c.exportMetadataList");
       action.setParams({  metadataName : ComponentselectforRadio });
       action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('result is'+ state);
            if (state === "SUCCESS"){
                var result = response.getReturnValue();                
       var PositionTitle = 'Selected Contact';
        var data = [];
        var headerArray = [];
        var csvContentArray = [];
        //Provide the title 
     var CSV = '\r\nSelected Position\r\n';
        headerArray.push('S.no');
        headerArray.push('Id');
        headerArray.push('Name');
        data.push(headerArray);
        var sno = 0;
        for(var i=0;i<result.length;i++){  
            
            if(result){
                console.log('id'+ result[0].Id);
                
                var tempArray = [];
                
                sno = parseInt(sno) + parseInt(1);
                tempArray.push('"'+sno+'"');                
                tempArray.push('"'+result[i].Id+'"');
                tempArray.push('"'+result[i].Name+'"');
                data.push(tempArray);
                console.log('tempArray'+ tempArray);
            }
        }
        for(var j=0;j<data.length;j++){
            var dataString = data[j].join(",");
            csvContentArray.push(dataString);
        }
        var csvContent = CSV + csvContentArray.join("\r\n");
        
       
        var fileName = ComponentselectforRadio;        
        fileName += ".csv";
        var uri = 'data:text/csv;charset=utf-8,' + encodeURIComponent(csvContent);
        
        if (navigator.msSaveBlob) { // IE 10+
            console.log('----------------if-----------');
            var blob = new Blob([csvContent],{type: "text/csv;charset=utf-8;"});
            console.log('----------------if-----------'+blob);
        	navigator.msSaveBlob(blob, fileName);
        }
        else{
            // Download file
            // you can use either>> window.open(uri);
            // but this will not work in some browsers
            // or you will not get the correct file extension    
            var link = document.createElement("a");

            //link.download to give filename with extension
            //link.download = fileName;
            link.setAttribute('download',fileName);
            //To set the content of the file
            link.href = uri;
            
            //set the visibility hidden so it will not effect on your web-layout
            link.style = "visibility:hidden";
            
            //this part will append the anchor tag and remove it after automatic click
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);     
    	}
    }
       });
       $A.enqueueAction(action);
    },
        downloadCsvForRadioWorkflowWrapper:function(component,event,helper){
               
            var ComponentselectforRadio = component.get("v.value");
       var action = component.get("c.exportWorkflow");
       action.setParams({  metadataName : ComponentselectforRadio });
       action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('result is'+ state);
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                component.set("v.wrapperListvaildation",result);
                var result1 = component.get("v.wrapperListvaildation");
                console.log('result in helper '+ result1);
               console.log('result in helper '+ JSON.stringify(result1));
                console.log('result in helper '+ JSON.stringify(result1.records));
                //wrapper contains list which contains records
                console.log('result in helper '+ result1.records);
       // var lstPositions = component.get("v.ListOfContact");
       var PositionTitle = 'Selected Contact';
        var data = [];
        var headerArray = [];
        var csvContentArray = [];
        //Provide the title 
     var CSV = '\r\nSelected Position\r\n';

        headerArray.push('Id');
        headerArray.push('Name');
        data.push(headerArray);                

        var sno = 0;
        for(var i=0;i<result.records.length;i++){
            
            
            //Check for records selected by the user
            if(result.records){
                //Initialize the temperory array
                var tempArray = [];
                //use parseInt to perform math operation
                sno = parseInt(sno) + parseInt(1);
                tempArray.push('"'+sno+'"');                
                tempArray.push('"'+result.records[i].Id+'"');
                tempArray.push('"'+result.records[i].Name+'"');
                data.push(tempArray);
                console.log('tempArray'+tempArray);
            }
        }
        
        for(var j=0;j<data.length;j++){
            var dataString = data[j].join(",");
            csvContentArray.push(dataString);
        }
        var csvContent = CSV + csvContentArray.join("\r\n");
        
        //Generate a file name
        var fileName = ComponentselectforRadio;        
        //this will remove the blank-spaces from the title and replace it with an underscore
       // fileName += PositionTitle.replace(/ /g,"_");   
        fileName += ".csv";
        //Initialize file format you want csv or xls
        var uri = 'data:text/csv;charset=utf-8,' + encodeURIComponent(csvContent);
        
        if (navigator.msSaveBlob) { // IE 10+
            var blob = new Blob([csvContent],{type: "text/csv;charset=utf-8;"});
        	navigator.msSaveBlob(blob, fileName);
        }
        else{
            // Download file
            // you can use either>> window.open(uri);
            // but this will not work in some browsers
            // or you will not get the correct file extension    
            var link = document.createElement("a");

            //link.download to give filename with extension
            //link.download = fileName;
            link.setAttribute('download',fileName);
            //To set the content of the file
            link.href = uri;
            
            //set the visibility hidden so it will not effect on your web-layout
            link.style = "visibility:hidden";
            
            //this part will append the anchor tag and remove it after automatic click
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);     
    	}
    }
       });
       $A.enqueueAction(action);
    },
      downloadCsvForRadioValidationWrapper:function(component,event,helper){
         var ComponentselectforRadio = component.get("v.value");
       var action = component.get("c.exportValidation");
       action.setParams({  metadataName : ComponentselectforRadio });
       action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('result is'+ state); 
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                console.log('result'+JSON.stringify(result));
                //setting datatype
                component.set("v.validationList",result);
                var result1 = component.get("v.validationList");
                console.log('result in helper '+ result1);
               console.log('result in helper '+ JSON.stringify(result1));
                console.log('result in helper '+ JSON.stringify(result1.records));
                console.log('result in helper '+ result1.records);
       // var lstPositions = component.get("v.ListOfContact");
       var PositionTitle = 'Selected Contact';
        var data = [];
        var headerArray = [];
        var csvContentArray = [];
        //Provide the title 
     var CSV = '\r\nSelected Position\r\n';
        headerArray.push('Sno');
        headerArray.push('Id');
        headerArray.push('Description');
        data.push(headerArray);                

        var sno = 0;
        for(var i=0;i<result.records.length;i++){
            
            
            //Check for records selected by the user
            if(result.records){
                //Initialize the temperory array
                var tempArray = [];
                //use parseInt to perform math operation
                sno = parseInt(sno) + parseInt(1);
                tempArray.push('"'+sno+'"');                
                tempArray.push('"'+result.records[i].Id+'"');
                tempArray.push('"'+result.records[i].Description+'"');
                data.push(tempArray);
            }
        }
        
        for(var j=0;j<data.length;j++){
            var dataString = data[j].join(",");
            csvContentArray.push(dataString);
        }
        var csvContent = CSV + csvContentArray.join("\r\n");
        
        //Generate a file name
        var fileName = ComponentselectforRadio;        
        //this will remove the blank-spaces from the title and replace it with an underscore
       // fileName += PositionTitle.replace(/ /g,"_");   
        fileName += ".csv";
        //Initialize file format you want csv or xls
        var uri = 'data:text/csv;charset=utf-8,' + encodeURIComponent(csvContent);
        
        if (navigator.msSaveBlob) { // IE 10+
            console.log('----------------if-----------');
            var blob = new Blob([csvContent],{type: "text/csv;charset=utf-8;"});
            console.log('----------------if-----------'+blob);
        	navigator.msSaveBlob(blob, fileName);
        }
        else{
            // Download file
            // you can use either>> window.open(uri);
            // but this will not work in some browsers
            // or you will not get the correct file extension    
            var link = document.createElement("a");

            //link.download to give filename with extension
            //link.download = fileName;
            link.setAttribute('download',fileName);
            //To set the content of the file
            link.href = uri;
            
            //set the visibility hidden so it will not effect on your web-layout
            link.style = "visibility:hidden";
            
            //this part will append the anchor tag and remove it after automatic click
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);     
    	}
    }
       });
       $A.enqueueAction(action);
    },
         downloadCsvForRadioProcessWrapper:function(component,event,helper){
         var ComponentselectforRadio = component.get("v.value");
       var action = component.get("c.processFlow");
       action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                console.log('result'+result);
                //setting datatype
                component.set("v.processList",result);                
       var PositionTitle = 'Selected Contact';
        var data = [];
        var headerArray = [];
        var csvContentArray = [];
        //Provide the title 
     var CSV = '\r\nSelected Position\r\n';
        headerArray.push('Sno');
        headerArray.push('Id');
        headerArray.push('Name');
        data.push(headerArray);                
        var sno = 0;
                console.log('result :'+JSON.stringify(result));
        for(var i=0;i<result.records.length;i++){
            //Check for records selected by the user
            if(result.records){
                //Initialize the temperory array
                var tempArray = [];
                //use parseInt to perform math operation
                sno = parseInt(sno) + parseInt(1);
                tempArray.push('"'+sno+'"');                
                tempArray.push('"'+result.records[i].Id+'"');
                tempArray.push('"'+result.records[i].Description+'"');
                data.push(tempArray);
            }
        }
        
        for(var j=0;j<data.length;j++){
            var dataString = data[j].join(",");
            csvContentArray.push(dataString);
        }
        var csvContent = CSV + csvContentArray.join("\r\n");
        
        //Generate a file name
        var fileName = ComponentselectforRadio;        
        //this will remove the blank-spaces from the title and replace it with an underscore
       // fileName += PositionTitle.replace(/ /g,"_");   
        fileName += ".csv";
        //Initialize file format you want csv or xls
        var uri = 'data:text/csv;charset=utf-8,' + encodeURIComponent(csvContent);
        
        if (navigator.msSaveBlob) { // IE 10+
            console.log('----------------if-----------');
            var blob = new Blob([csvContent],{type: "text/csv;charset=utf-8;"});
            console.log('----------------if-----------'+blob);
        	navigator.msSaveBlob(blob, fileName);
        }
        else{
            // Download file
            // you can use either>> window.open(uri);
            // but this will not work in some browsers
            // or you will not get the correct file extension    
            var link = document.createElement("a");

            //link.download to give filename with extension
            //link.download = fileName;
            link.setAttribute('download',fileName);
            //To set the content of the file
            link.href = uri;
            
            //set the visibility hidden so it will not effect on your web-layout
            link.style = "visibility:hidden";
            
            //this part will append the anchor tag and remove it after automatic click
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);     
    	}
    }
       });
       $A.enqueueAction(action);
    },
       downloadCsvinVfpageforRadio:function (component,event,helper){
  	    var data =component.get("v.value");
             if (data == undefined)
                {
                 alert('Please select one component');
                }
              else if(data == 'ApexClass' || data == 'ApexTrigger' ||
                  data == 'EmailTemplates' || data == 'ApprovalProcess'){
                //for opening vf page from lightning
        		window.open("/apex/VFExportMetadataRadio?radiodata="+data, '_blank');
               }
               else if(data=='Workflow'){
               window.open("/apex/exportmetadatainexcel?radiodata="+data, '_blank');
               }
               else if(data=='ValidationRule')
               {
               window.open("/apex/exportmetadatavfvalidation?radiodata="+data, '_blank');
               }
               else if(data == 'ProcessFlow')
               {
               window.open("/apex/exportmetdatavfprocess?radiodata="+data, '_blank');                   
               }
       }
})