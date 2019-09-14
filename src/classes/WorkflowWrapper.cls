public class WorkflowWrapper {
@AuraEnabled
 public Integer size {
  get;
  set;
 }
    @AuraEnabled
 public Integer totalSize {
  get;
  set;
 }
    @AuraEnabled
 public Boolean done {
  get;
  set;
 }
    @AuraEnabled
 public Object queryLocator {
  get;
  set;
 }
    @AuraEnabled
 public String entityTypeName {
  get;
  set;
 }
    @AuraEnabled
 public List < Records > records {
  get;
  set;
 }

 public WorkflowWrapper(JSONParser parser) {
  while (parser.nextToken() != System.JSONToken.END_OBJECT) {
   if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
    String text = parser.getText();
    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
     if (text == 'size') {
      size = parser.getIntegerValue();
     } else if (text == 'totalSize') {
      totalSize = parser.getIntegerValue();
     } else if (text == 'done') {
      done = parser.getBooleanValue();
     } else if (text == 'queryLocator') {
      queryLocator = parser.readValueAs(Object.class);
     } else if (text == 'entityTypeName') {
      entityTypeName = parser.getText();
     } else if (text == 'records') {
      records = arrayOfRecords(parser);
     } else {
      System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: ' + text);
      consumeObject(parser);
     }
    }
   }
  }
 }

 public class Attributes {
  public String type_Z {
   get;
   set;
  } // in json: type
     @AuraEnabled
  public String url {
   get;
   set;
  }

  public Attributes(JSONParser parser) {
   while (parser.nextToken() != System.JSONToken.END_OBJECT) {
    if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
     String text = parser.getText();
     if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
      if (text == 'type') {
       type_Z = parser.getText();
      } else if (text == 'url') {
       url = parser.getText();
      } else {
       System.debug(LoggingLevel.WARN, 'Attributes consuming unrecognized property: ' + text);
       consumeObject(parser);
      }
     }
    }
   }
  }
 }

 public class Records {
     @AuraEnabled
  public Attributes attributes {
   get;
   set;
  }
     @AuraEnabled
  public String Id {
   get;
   set;
  }
     @AuraEnabled
  public String Name {
   get;
   set;
  }
     @AuraEnabled
  public String TableEnumOrId {
   get;
   set;
  }

  public Records(JSONParser parser) {
   while (parser.nextToken() != System.JSONToken.END_OBJECT) {
    if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
     String text = parser.getText();
     if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
      if (text == 'attributes') {
       attributes = new Attributes(parser);
      } else if (text == 'Id') {
       Id = parser.getText();
      } else if (text == 'Name') {
       Name = parser.getText();
      } else if (text == 'TableEnumOrId') {
       TableEnumOrId = parser.getText();
      } else {
       System.debug(LoggingLevel.WARN, 'Records consuming unrecognized property: ' + text);
       consumeObject(parser);
      }
     }
    }
   }
  }
 }

@AuraEnabled
 public static WorkflowWrapper parse(String json) {
  System.JSONParser parser = System.JSON.createParser(json);
  return new WorkflowWrapper(parser);
 }
@AuraEnabled
 public static void consumeObject(System.JSONParser parser) {
  Integer depth = 0;
  do {
   System.JSONToken curr = parser.getCurrentToken();
   if (curr == System.JSONToken.START_OBJECT ||
    curr == System.JSONToken.START_ARRAY) {
    depth++;
   } else if (curr == System.JSONToken.END_OBJECT ||
    curr == System.JSONToken.END_ARRAY) {
    depth--;
   }
  } while (depth > 0 && parser.nextToken() != null);
 }





 private static List < Records > arrayOfRecords(System.JSONParser p) {
  List < Records > res = new List < Records > ();
  if (p.getCurrentToken() == null) p.nextToken();
  while (p.nextToken() != System.JSONToken.END_ARRAY) {
   res.add(new Records(p));
  }
  return res;
 }




}