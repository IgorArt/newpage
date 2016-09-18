public with sharing class Pro_Controller {

     
       
    public integer lt = 8;
    public integer os = 0;
    public integer i = 0;
    public integer sz =[select count() from Product__c];
    public string searchstr {get; set;}
    public list<Product__c> pr;   
     
    
    public list<productwrapper> productList = new list<productwrapper>();
     
   
            
    public void delSelected(){ //Mass Delete        
        pr.clear();        
        for(productwrapper ev: productlist){          
            if(ev.selected == true)             
                pr.add(ev.prw);           
        }
        if(pr!=null && !pr.isempty())         
            delete pr; 
    }
     
    
    public list<productwrapper> getaccountlist(){ //Getting All Records         
        if(i==0){
            productlist.clear();
            pr = [select Id, Name,Price__c,Type__c, Amount__c, Date_Added__c,Release_Date__c,Available__c from Product__c order by Date_Added__c desc limit : lt offset : os];
            for(Product__c p:pr){         
                productlist.add(new productwrapper (p));          
            }   
        }       
        if(pr!=null && !pr.isempty())     
            return productlist;     
        else       
            return new list<productwrapper>();
    }
      
    
     public list<selectoption> getprSource(){    //Fetching Name Source SelectList        
        list<selectoption> opt = new list<selectoption>();      
        schema.DescribeFieldResult fd = Product__c.Name.getdescribe();
        list<schema.picklistentry> pc = fd.getpicklistvalues();       
        for(schema.picklistentry f: pc){        
            opt.add(new selectoption(f.getlabel(),f.getvalue()));       
        }   
        return opt;
    }
     
    
    public list<selectoption> getpr(){ //Fetching Active SelectList      
        list<selectoption> opt = new list<selectoption>();      
        schema.DescribeFieldResult fd = Product__c.Type__c.getdescribe();
        list<schema.picklistentry> pc = fd.getpicklistvalues();       
        for(schema.picklistentry f: pc){        
            opt.add(new selectoption(f.getlabel(),f.getvalue()));       
        }   
        return opt;
    }
  
    public list<productwrapper> setproductlist(){ //Setting Records
        productlist.clear();
        for(productwrapper li: productlist){      
            for(integer j=0; j<sz;j++){          
                li.prw = [select Id, Name,Price__c,Type__c, Amount__c, Date_Added__c,Release_Date__c,Available__c from Product__c where Id = :pr[j].Id];            
            }       
        }       
        if(productlist!=null && !productlist.isempty())     
            return productlist;     
        else
            return new list<productwrapper>();    
    }
     
   
     public void searchdata(){ //Searching
        i = 1;
        productlist.clear();
        pr = [select Id, Name,Price__c,Type__c, Amount__c, Date_Added__c,Release_Date__c,Available__c from Product__c where name like :'%'+searchstr+'%' order by Date_Added__c desc limit : lt offset :os ];      
        for(Product__c p: pr){        
            productlist.add(new productwrapper(p));   
        }       
        sz =[select count() from Product__c where name like :'%'+searchstr+'%'];   
    }
     
    //--------Pagination ----------//
    public void next(){     
        os+=8;
        searchdata();   
    }
     
    public void previous(){     
        os-=8;
        searchdata();   
    }
     
    public Boolean getDisableNext(){      
       if (os + lt < sz)
            return false;
        else
           return true;     
    }
     
    public Boolean getDisablePrevious(){        
         if(os>0)
             return false;
         else
             return true;         
    }
     
    public integer total_pg{get{    
          if(math.mod(sz,lt)==0)
            return sz/lt;         
          else
            return sz/lt +1;    
    } set;}
     
     
    public integer current_pg{get{      
        return os/lt +1;                
    } set;}
     
    //----------Mass Update----------//
     
    public boolean pg_input{get{    
        if(pg_input==null){     
            pg_input = false;       
        }
        return pg_input;    
    } set;}
     
    public boolean pg_output{get{    
        if(pg_output==null){        
            pg_output = true;       
        }
        return pg_output;    
    } set;}
     
    public void retriveInput(){    
        pg_input = true;
        pg_output = false;                 
    }
     
    public void retrieveOutput(){    
        pg_input = false;
        pg_output = true;       
        if(pr!=null && !pr.isempty()){        
            update pr;     
        }   
    }       
}