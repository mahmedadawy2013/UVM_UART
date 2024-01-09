class driver extends uvm_driver #(sequence_item);
/**************************************************************************
* Dont Forget To make the Class parametrized with th sequence Item 
* to avoid the error at TLM Synchornization 
**************************************************************************/
/*Register To The Factory Using componenet utils */

`uvm_component_utils(driver)

virtual intf driv_intf   ;
sequence_item t_drive    ; 

function  new(string name = "DRIVER ", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("DRIVER","WE Are Compiling The Driver",UVM_NONE);
    /***************************************************************************
    * if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",driv_intf))
    * if the name isnt my_vif u will not recieve the interface 
    * the name must match the sent interface with the same name 
    ***************************************************************************/
    if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",driv_intf))
        `uvm_info("DRIVER","ERROR INSIDE DRIVER",UVM_NONE);
    t_drive = sequence_item::type_id::create("t_drive");
    
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 
    `uvm_info("DRIVER","WE ARE RUNNING THE DRIVER",UVM_NONE);
    forever begin 
    seq_item_port.get_next_item(t_drive)             ; 
    @(negedge driv_intf.CLK)
    t_drive.display_Sequence_item("DRIVER")           ;
    `uvm_info("DRIVER","Drive has insert the data into the DUT ",UVM_NONE) ;
    driv_intf.RST            = t_drive.RST                ; 
    driv_intf.P_DATA         = t_drive.P_DATA             ;
    driv_intf.Data_Valid     = t_drive.Data_Valid         ;  
    driv_intf.parity_enable  = t_drive.parity_enable      ; 
    driv_intf.parity_type    = t_drive.parity_type        ; 
    if (t_drive.RST == 1 && t_drive.Data_Valid == 1 ) begin 
        for (int i = 0; i < 12; i++) begin
            if (i == 2 ) begin 
               driv_intf.Data_Valid     = 0         ;  
            end 
            $display("WAITING FOR 12 CYCLE ") ; 
            @ (posedge driv_intf.CLK);
        end
    end 
    seq_item_port.item_done()              ; 
    end 
endtask 


endclass
