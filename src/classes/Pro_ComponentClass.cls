public class Pro_ComponentClass {
  /*Inserting New Product*/
      
    public Product__c pr{get{    
        if(pr == null)     
            pr = new Product__c();
        return pr;
    } set;}
             
    public void savedata(){     
        try{            
            insert pr;         
    }catch(exception e){}
    finally{        
        pr = new Product__c();        
    }                        
  }
}