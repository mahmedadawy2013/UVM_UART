interface  intf  () ;

    bit                    CLK               ;
    bit                    RST               ;
    bit [7:0]              P_DATA            ;
    bit                    Data_Valid        ;
    bit                    parity_enable     ;
    bit                    parity_type       ;
    bit                    TX_OUT            ;
    bit                    busy              ;
    
endinterface

