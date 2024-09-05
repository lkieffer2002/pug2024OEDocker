 
 /*------------------------------------------------------------------------
    File        : ErrorHandler
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : rdroge
    Created     : Mon Jan 14 10:44:15 CET 2019
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
using Progress.Lang.AppError.

block-level on error undo, throw.

class errors.ErrorHandler inherits AppError serializable: 

    define variable lastmsg as integer no-undo.

    constructor public ErrorHandler( ):
        super().
    end constructor.

    constructor public  ErrorHandler(mymsg as character, mynum as integer):
        AddMessage(mymsg, mynum).
        message "In MyAppError2 Char & Int Constructor" mymsg mynum.    
    end constructor.

    constructor public ErrorHandler(mynum as integer):
      message "In MyAppError2 Integer Constructor" mynum.
    end.

    destructor public ErrorHandler():
      message "In MyAppError2 destructor" .
    end destructor.

end class.