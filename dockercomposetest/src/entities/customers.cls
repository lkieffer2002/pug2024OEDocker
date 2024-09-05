 
 /*------------------------------------------------------------------------
 Syntax      : 
    Author(s)   : rdroge
    Created     : Thu Dec 13 12:49:18 CET 2018
    File        : customers
    Notes       : 
  ----------------------------------------------------------------------*/


using Progress.Lang.*.
using Progress.Json.ObjectModel.*.
using data.DataAccess.*.
using OpenEdge.BusinessLogic.*.
using OpenEdge.Logging.*.


block-level on error undo, throw.

class entities.customers inherits OpenEdge.BusinessLogic.BusinessEntity implements interfaces.CRUD:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    
    {"entities/inc/customers.i"}
  
    
    define data-source srcCustomer for sports2020.Customer.
    define variable iSeq as integer no-undo.
    define variable daO as data.DataAccess.
    define public property ttName as character no-undo initial "ttcustomer" get. set. 
    define public property piName as character no-undo initial "custnum" get. set.
    define public property dbName as character no-undo initial "customer" get. set.
    define variable logger as ILogWriter no-undo.
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    constructor public customers():
        
        
        super (dataset dsCustomer:HANDLE).
        
    end constructor.
    
    method public void Read(input filter as generics.FilterParams, output dataset-handle hDataSet):
        this-object:GetCustomers(filter, output dataset dsCustomer by-reference).
        hDataSet = dataset dsCustomer:handle. 
         
    end method.
    
    method public void Create(input jsonObject as JsonObject, output dataset-handle hDataSet):
        dao = new data.DataAccess().
        dao:attachSource("ttcustomer", "CustNum", "Customer", "CustNum", "", ?, input-output dataset dsCustomer by-reference).
        dataset dscustomer:get-buffer-handle (1):table-handle:tracking-changes = true.
        dataset dsCustomer:read-json('JsonObject', jsonObject).
        dataset dscustomer:get-buffer-handle (1):table-handle:tracking-changes = false.
        
        dao:CommitChanges(piName, dataset dsCustomer by-reference).
        hDataSet = dataset dsCustomer:handle.
    
    end method.
    
    method public void Update(input filter as generics.FilterParams, input jsonObject as JsonObject, output dataset-handle hDataSet):
        this-object:Updatecustomers(filter, input-output dataset dsCustomer by-reference).
        hDataSet = dataset dsCustomer:handle.
        
    
    end method.
    
    method public void Delete(input filter as generics.FilterParams, output dataset-handle hDataSet):
        
        dao = new data.DataAccess().
        dao:attachSource("ttcustomer", "custnum", "customer", "custnum", filter:id1, filter, input-output dataset dsCustomer by-reference).
        this-object:Deletecustomer(input-output dataset dsCustomer by-reference).
        hDataSet = dataset dsCustomer:handle.
        dao:detachSource(dataset dsCustomer by-reference).
    
    end method.
        
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    method private void GetCustomers( input filter as generics.FilterParams, output DATASET dsCustomer ):
        
        daO = new data.DataAccess().
        daO:attachSource(this-object:ttName, this-object:piName, this-object:dbName, this-object:piName, filter:id1, filter, input-output dataset dsCustomer by-reference).
        daO:detachSource(dataset dsCustomer by-reference).    
            
    end method.
    
    {entities/inc/metadata.i &entity=customer}
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    method public void Updatecustomers(input filter as generics.FilterParams, input-output DATASET dsCustomer):            
    
        dao = new data.DataAccess().
        dao:attachSource("ttcustomer", "CustNum", "Customer", "CustNum", filter:id1, filter, input-output dataset dsCustomer by-reference).
        dao:CommitChanges(piName, input-output dataset dsCustomer by-reference).
        dao:detachSource(dataset dsCustomer by-reference).
              
    end method.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    method public void Deletecustomer(input-output DATASET dsCustomer):                    
    
        
    end method.
     
    
end class.
