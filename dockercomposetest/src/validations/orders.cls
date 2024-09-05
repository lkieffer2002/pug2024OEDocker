 
 /*------------------------------------------------------------------------
    File        : orders
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : rdroge
    Created     : Tue Jan 07 12:45:40 CET 2020
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.

block-level on error undo, throw.

class validations.orders: 
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    {entities/inc/orders.i}    
    constructor public orders (  ):
        super ().
        
    end constructor.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    
    method public character CheckMandatoryFields(input dataset dsOrder, output errMessage as character):
        
        define variable cFieldList  as character no-undo.
        define variable ii          as integer no-undo.
        define variable qBuf        as handle no-undo.
        
        cFieldList = "OrderNum,CustNum,OrderDate,SalesRep".
       
       
            for each ttOrder no-lock:
                 do ii=1 to num-entries(cFieldList):
                    define variable cFieldName as character no-undo.
            
                    cFieldName = entry(ii, cFieldList).
                    message cFieldName view-as alert-box.
                    if  (buffer ttOrder:buffer-field(cFieldName):data-type = "integer" or buffer ttorder:buffer-field(cFieldName):data-type = "decimal") then do:    
                        if  buffer ttOrder:buffer-field(cFieldName):buffer-value() = 0 then
                        errMessage = "mag niet 0 zijn".
                    end.
                    else do:
                        if (buffer ttOrder:buffer-field(cFieldName):buffer-value()="?" or buffer ttOrder:buffer-field(cFieldName):buffer-value() = "") then
                        errMessage = "mag niet leeg zijn".
                    end.
                  
                end.
            end.
       
        return errMessage.
        catch e as Progress.Lang.Error:

        end catch.

    end method.    
    

    destructor public orders ( ):

    end destructor.

end class.