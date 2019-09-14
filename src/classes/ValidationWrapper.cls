public class ValidationWrapper {

	public class EntityDefinition {
        @AuraEnabled
		public Attributes attributes {get;set;} 
        @AuraEnabled
		public String DeveloperName {get;set;} 

		public EntityDefinition(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'attributes') {
							attributes = new Attributes(parser);
						} else if (text == 'DeveloperName') {
							DeveloperName = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'EntityDefinition consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	@AuraEnabled
	public Integer size {get;set;}
    @AuraEnabled
	public Integer totalSize {get;set;} 
    @AuraEnabled
	public Boolean done {get;set;} 
    @AuraEnabled
	public Object queryLocator {get;set;} 
    @AuraEnabled
	public String entityTypeName {get;set;} 
    @AuraEnabled
	public List<Records> records {get;set;} 

	public ValidationWrapper(JSONParser parser) {
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
						System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Attributes {
        @AuraEnabled
		public String type_Z {get;set;} // in json: type
        @AuraEnabled
		public String url {get;set;} 

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
							System.debug(LoggingLevel.WARN, 'Attributes consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Records {
        @AuraEnabled
		public Attributes attributes {get;set;} 
        @AuraEnabled
		public String Id {get;set;} 
        @AuraEnabled
		public Boolean Active {get;set;} 
        @AuraEnabled
		public String Description {get;set;} 
        @AuraEnabled
		public EntityDefinition EntityDefinition {get;set;} 
        @AuraEnabled
		public String ErrorDisplayField {get;set;} 
        @AuraEnabled
		public String ErrorMessage {get;set;} 

		public Records(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'attributes') {
							attributes = new Attributes(parser);
						} else if (text == 'Id') {
							Id = parser.getText();
						} else if (text == 'Active') {
							Active = parser.getBooleanValue();
						} else if (text == 'Description') {
							Description = parser.getText();
						} else if (text == 'EntityDefinition') {
							EntityDefinition = new EntityDefinition(parser);
						} else if (text == 'ErrorDisplayField') {
							ErrorDisplayField = parser.getText();
						} else if (text == 'ErrorMessage') {
							ErrorMessage = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Records consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	@auraenabled
	public static ValidationWrapper parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new ValidationWrapper(parser);
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
	




    private static List<Records> arrayOfRecords(System.JSONParser p) {
        List<Records> res = new List<Records>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Records(p));
        }
        return res;
    }






}