module tb ()  ;

    import uvm_pkg::*   ;  
    import pack1::*     ;
    intf intf1()        ; 
       

    UART_TX UART_TX_INSTANCE (
        .CLK           (intf1.CLK)           ,
        .RST           (intf1.RST)           ,
        .P_DATA        (intf1.P_DATA)        ,
        .Data_Valid    (intf1.Data_Valid)    ,
        .parity_enable (intf1.parity_enable) ,
        .parity_type   (intf1.parity_type)   ,
        .TX_OUT        (intf1.TX_OUT)        ,
        .busy          (intf1.busy)          
    ); 

    initial begin 
        intf1.CLK = 1 ; 
    end  

    always  begin
       #5 intf1.CLK= ~ intf1.CLK; 
    end

    initial begin
        uvm_config_db #(virtual intf)::set(null,"*","my_vif",intf1) ; 
        run_test("test") ; 
    end 
endmodule