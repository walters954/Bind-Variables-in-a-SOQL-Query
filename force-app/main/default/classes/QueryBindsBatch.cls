public with sharing class QueryBindsBatch implements Database.Batchable<sObject> {
    

    public Database.QueryLocator start(Database.BatchableContext BC) {
        Map<String, Object> bindMap = new Map<String, Object>{'oppName' => 'Acme%'};
        String query = 'SELECT Id, Name FROM Account WHERE Name LIKE :oppName';
        return Database.getQueryLocatorWithBinds(query, bindMap, AccessLevel.USER_MODE);
    }

    public void execute(Database.BatchableContext BC, List<Account> scope) {
        // Process each batch of records
    }

    public void finish(Database.BatchableContext BC) {
        // Execute any post-processing operations
    }
}