public with sharing class P_Controller {
public String SearchProductKeyword { get; set; }
public Integer noOfRecords{get; set;}
public List<Product__c> Books { get{
return (List<Product__c>)setCon.getRecords();
} set; }
public Integer size{get;set;}

/*public List<Product__c> Products { get{

String SearchQuery = SearchProductKeyword == null ? '%%' : '%'+SearchProductKeyword+'%';

List <Product__c> AvailableProduct = [SELECT Id, Name,Price__c,Type__c, Amount__c, Date_Added__c,Release_Date__c,Available__c  FROM Product__c WHERE Name  LIKE :SearchQuery  LIMIT 300];

return AvailableProduct;

} set; }*/	
public ApexPages.StandardSetController setCon {

 get{

    if(setCon == null){
    size = 10;
    string SearchProductKeywordCreteria = '%'+(SearchProductKeyword == null ? '' : SearchProductKeyword)+'%';
    List<Product__c> ProductList = [SELECT Id, Name,Price__c,Type__c, Amount__c, Date_Added__c,Release_Date__c,Available__c  FROM Product__c WHERE Name  LIKE :SearchBookKeywordCreteria LIMIT 10000]; 
    setCon = new ApexPages.StandardSetController(ProductList);
    setCon.setPageSize(size);
    noOfRecords = setCon.getResultSize();
}

 return setCon;

 }set;

}
public void SearchPtoducts() {

setCon = null;

setCon.setPageNumber(1);

}

}


