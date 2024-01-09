class sequence_item  extends uvm_sequence_item  ;
/*Register To The Factory Using object utils */
`uvm_object_utils(sequence_item)

/* declaration of the input output signals */
// This is the base transaction object Container that will be used 
// in the environment to initiate new transactions and // capture transactions at DUT interface
rand  bit                    RST               ;
randc bit [7:0]              P_DATA            ;
rand  bit                    Data_Valid        ;
rand  bit                    parity_enable     ;
rand  bit                    parity_type       ;
      bit                    TX_OUT            ;
      bit                    busy              ;

/* declaration of the Constraints for input output signals */
 
function  new(string name = "SEQUENCE_ITEM ");
    super.new(name) ; 
endfunction

/* Function to display the transaction at any time*/

function void display_Sequence_item(input string name = "SEQUENCE ITEM" ); 

    $display ("********************** This is the %0P *************************",name)  ;  
    $display (" RST           = %0d    P_DATA          =   %0d  ", RST          , P_DATA         ) ; 
    $display (" Data_Valid    = %0d    parity_enable   =   %0d  ", Data_Valid   , parity_enable  ) ; 
    $display (" parity_type   = %0d    TX_OUT          =   %0d  ", parity_type  , TX_OUT         ) ; 
    $display (" busy          = %0d                             ", busy                          ) ; 
    $display ("****************************************************************")   ;
    
endfunction   

endclass
    

	  