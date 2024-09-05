 
 /*------------------------------------------------------------------------
    File        : OrderValidationTest
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : rdroge
    Created     : Tue Jan 07 13:41:25 CET 2020
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
using OpenEdge.Core.Assert.
using validations.orders.*.
block-level on error undo, throw.


class tests.OrderValidationTest:

{entities/inc/orders.i}    
       /*------------------------------------------------------------------------------
            Purpose:                                                                        
            Notes:                                                                        
    ------------------------------------------------------------------------------*/

    @Before.
    method public void setUpBeforeClass(  ):
        
        return.

    end method.
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                        
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
   
    @Setup.
    method public void setUp(  ):
        
        create ttOrder.
            assign 
                ttOrder.BillToID = 2
                ttOrder.Carrier = "DPD"
                ttOrder.CustNum  = 3000
                ttOrder.OrderDate = date("1-1-2020")
                ttOrder.SalesRep = "RUBEN".
                

    end method.
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                        
            Notes:                                                                        
    ------------------------------------------------------------------------------*/

    @TearDown.
    method public void tearDown(  ):
        
        return.

    end method.
     
       /*------------------------------------------------------------------------------
            Purpose:                                                                        
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
   
    @After.
    method public void tearDownAfterClass(  ):
        delete ttOrder.
        return.

    end method.
     
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                        
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @Test. 
    method public void testCheckMandatoryFields(  ):
        define variable obj as validations.orders no-undo.
        define variable errMessage as character no-undo.
        
        
        obj = new validations.orders().
        
        
        obj:CheckMandatoryFields(dataset dsOrder, errMessage).
        
        Assert:equals ("mag niet 0 zijn", errMessage).
        

    end method.
    
end class.