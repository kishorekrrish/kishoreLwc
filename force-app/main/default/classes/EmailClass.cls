/**
 * @description       : 
 * @author            : 
 * @group             : 
 * @last modified on  : 11-18-2021
 * @last modified by  : Kishore Bandanadam
**/
public with sharing class EmailClass {
    
    /**
    * @description 
    * @author Kishore Bandanadam | 11-18-2021 
    * @param searchString 
    * @return string 
    **/
    @AuraEnabled
    public static List<SObject> search(String searchString){
        List<SObject> searchList = new List<SObject>();
        try {
            String searchStr = '*'+searchString+'*';
            String searchquery='FIND\''+ searchStr + '\'IN ALL FIELDS RETURNING Contact(id, name, email where email != null), User(id, name, email where email != null) LIMIT 10'; 
            List<List<SObject>> searchResult = search.query(searchquery);  
            system.debug('searchResult:::'+searchResult.size());
            for(List<SObject> curList: searchResult) {
                searchList.addAll(curList);
            }
            system.debug('searchList:::'+searchList.size());
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return searchList;
    }
}
