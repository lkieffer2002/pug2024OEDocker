 
 /*------------------------------------------------------------------------
    File        : xmlhandler
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : rdroge
    Created     : Thu Nov 11 14:53:30 CET 2021
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
using OpenEdge.Web.WebResponseWriter.
using OpenEdge.Net.HTTP.StatusCodeEnum.
using OpenEdge.Web.WebHandler.

block-level on error undo, throw.

class webhandlers.xmlhandler inherits WebHandler: 

	
		
	/*------------------------------------------------------------------------------
            Purpose: Handler for unsupported methods. The request being serviced and
            		 an optional status code is returned. A zero or null value means 
            		 this method will deal with all errors.                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
	method override protected integer HandleNotAllowedMethod( input poRequest as OpenEdge.Web.IWebRequest ):
	
		/* Throwing an error from this method results in a 500/Internal Server Error response. 
        The web handler will attempt to log this exception.
 	    
        See the HandleGet method's comments on choosing a value to return from this method. */
        	
		undo, throw new Progress.Lang.AppError("METHOD NOT IMPLEMENTED").
	end method.


	/*------------------------------------------------------------------------------
            Purpose: Handler for unknown methods. The request being serviced and an 
                     optional status code is returned. A zero or null value means 
                     this method will deal with all errors.                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
	method override protected integer HandleNotImplemented( input poRequest as OpenEdge.Web.IWebRequest ):
	
		/* Throwing an error from this method results in a 500/Internal Server Error response. 
        The web handler will attempt to log this exception.
 	    
        See the HandleGet method's comments on choosing a value to return from this method. */	
		undo, throw new Progress.Lang.AppError("METHOD NOT IMPLEMENTED").
   	end method.
 	
	
	/*------------------------------------------------------------------------------
            Purpose: Default handler for the HTTP GET method. The request being 
                     serviced and an optional status code is returned. A zero or 
                     null value means this method will deal with all errors.                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
 	method override protected integer HandlePost( input poRequest as OpenEdge.Web.IWebRequest ):
 	
	
		define variable oResponse as OpenEdge.Net.HTTP.IHttpResponse no-undo.
        define variable oWriter   as OpenEdge.Web.WebResponseWriter  no-undo.
        define variable body    as OpenEdge.Core.WidgetHandle          no-undo.
        define variable oBody as OpenEdge.Core.String no-undo.    
        define variable lOk as logical no-undo.
        define variable mblaat as memptr no-undo.
        define variable hDataSet as handle no-undo.
        define variable lcData as longchar no-undo.
        /* The WebResponse body is a wrapper around an entire HTTP response message.
           It contains a status code and reason; headers; cookies and a message body.
           
           API-level doc for this and related classes can be found at
           https://documentation.progress.com/output/oehttpclient/      */
        
        //cast(poRequest:Entity, OpenEdge.Core.WidgetHandle):Value:save('longchar', lcData).
        message string(lcData).
        create dataset hDataset.
        lOk = hDataSet:read-xml("LONGCHAR", lcData, "EMPTY", ?, true).
        message lOk.
        assign 
            oResponse            = new OpenEdge.Web.WebResponse()
            oResponse:StatusCode = integer(StatusCodeEnum:OK)
            .
        /* This body object can be a string or something else (JsonObject for instance) */               
        assign 
            oBody = new OpenEdge.Core.String(
                             'Hello rdroge'
                           + '~r~n':u   /*CRLF */
                           + 'This message was returned by HandleGet in xmlhandler.'
                           ).
        
        assign 
            oResponse:Entity        = oBody
            /* HTTP messages require a content type */
            oResponse:ContentType   = 'text/plain':u
            /* ContentLength is good too */
            oResponse:ContentLength = oBody:Size
            .
        
        /* The WebResponseWriter ensures that the status line and
           all headers are writted out before the message body/entity. */
        assign 
            oWriter = new WebResponseWriter(oResponse).
        oWriter:Open().
        
        /* Finish writing the response message */
        oWriter:Close().
        
        /* A response of 0 means that this handler will build the entire response;
           a non-zero value is mapped to a static handler in the webapp's /static/error folder.
           The mappings are maintained in the webapps's WEB-INF/web.xml 
           A predefined set of HTTP status codes is provided in the OpenEdge.Net.HTTP.StatusCodeEnum 
           enumeration */
        return 0.
		
 	end method. 
 	
 	
   	
	
end class.