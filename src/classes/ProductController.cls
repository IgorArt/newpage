public with sharing class ProductController {

public String SearchProductKeyword { get; set; }

public List<Product__c> Products { get{

String SearchQuery = SearchProductKeyword == null ? '%%' : '%'+SearchProductKeyword+'%';

List <Product__c> AvailableProduct = [SELECT Id, Name,Price__c,Type__c, Amount__c, Date_Added__c,Release_Date__c,Available__c  FROM Product__c WHERE Name  LIKE :SearchQuery  LIMIT 300];

return AvailableProduct;

} set; }
}