({
	doInit : function(component, event, helper) {
		helper.doInit(component, event, helper);
	},
    handleChange : function(component, event, helper) {
		helper.handleChange(component, event, helper);
	},
    downloadCsv : function (component, event, helper) {
     helper.downloadCsv(component,event,helper)
   },
    downloadCsvinVfpage:function(component,event,helper){
        helper.downloadCsvinVfpage(component,event,helper)
    },
    selectRadio:function(component,event,helper){
        helper.selectRadio(component,event,helper)        
    },
     downloadCsvForRadioInLightning:function(component,event,helper){
         var ComponentselectforRadio = component.get("v.value");
         if(ComponentselectforRadio === undefined)
         {
             alert('Please select one component');
         }
         else if(ComponentselectforRadio === 'ApexClass' ||
            ComponentselectforRadio === 'ApexTrigger'|| 
            ComponentselectforRadio === 'EmailTemplates'||
           ComponentselectforRadio === 'ApprovalProcess'){
             helper.downloadCsvForRadioList(component,event,helper);       
         }
         else if(ComponentselectforRadio === 'Workflow')
         {
        	helper.downloadCsvForRadioWorkflowWrapper(component,event,helper);       
         }
         else if(ComponentselectforRadio === 'ValidationRule')
         {
        	helper.downloadCsvForRadioValidationWrapper(component,event,helper);       
         }
          else if(ComponentselectforRadio === 'ProcessFlow')
         {
        	helper.downloadCsvForRadioProcessWrapper(component,event,helper);       
         }
    },
    downloadCsvinVfpageforRadio:function (component,event,helper){
    helper.downloadCsvinVfpageforRadio(component,event,helper);
	}    
})