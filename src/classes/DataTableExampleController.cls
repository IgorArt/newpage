public class DataTableExampleController {
    public List<Product__c> productList {
        get {
            if (productList == null) {
                productList = [SELECT Product__c.Name,Price__c,Type__c, Amount__c, Date_Added__c,Release_Date__c,Available__c FROM Product__c  order by Name limit 20];
            }
            return productList;
        }
        set;
    }
}