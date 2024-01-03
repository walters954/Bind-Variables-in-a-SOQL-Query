public with sharing class QueryBinds {
    static Decimal oppAmount = 10000;
    static String oppStageName = 'Closed Won';
    static String accountIndustry = 'Banking';

    public static void queryOpportunityWithoutBinds(){
        List<Opportunity> opps = [SELECT Id, Name, Amount, StageName, Account.Name, Account.Industry
                                    FROM Opportunity
                                    WHERE Amount > :oppAmount
                                    AND StageName = :oppStageName];
        System.debug(opps);
        System.debug(opps.size());
    }

    public static void dynamicQueryOpportunity(){
        String query = 'SELECT Id, Name, Amount, StageName, Account.Name, Account.Industry ' +
                        'FROM Opportunity ' +
                        'WHERE Amount > :oppAmount ' +
                        'AND StageName = :oppStageName';
        query += ' AND Account.Industry = ' + accountIndustry;
        List<Opportunity> opps = Database.query(query);
        System.debug(opps);
        System.debug(opps.size());
    }

    public static void queryOpportunityWithBinds(){
        Map<String, Object> queryBinds = new Map<String, Object>();
        queryBinds.put('oppAmount', oppAmount);
        queryBinds.put('oppStageName', oppStageName);
        queryBinds.put('accountIndustry', accountIndustry);

        String query = 'SELECT Id, Name, Amount, StageName, Account.Name, Account.Industry ' +
                        'FROM Opportunity ' +
                        'WHERE Amount > :oppAmount ' +
                        'AND StageName = :oppStageName';
        query += ' AND Account.Industry = :accountIndustry';
        query += ' AND Account.Industry = :test';
        List<Opportunity> opps = Database.queryWithBinds(query, queryBinds, AccessLevel.USER_MODE);
        System.debug(opps);
        System.debug(opps.size());
    }

    public static void countQueryOpportunityWithBinds(){
        Map<String, Object> queryBinds = new Map<String, Object>();
        queryBinds.put('oppAmount', oppAmount);
        queryBinds.put('oppStageName', oppStageName);

        String query = 'SELECT COUNT() ' +
                        'FROM Opportunity ' +
                        'WHERE Amount > :oppAmount ' +
                        'AND StageName = :oppStageName';
        Integer oppCount = Database.countQueryWithBinds(query, queryBinds, AccessLevel.USER_MODE);
        System.debug(oppCount);
    }
}