class monitor extends uvm_monitor;

/*Register To The Factory Using componenet utils */
`uvm_component_utils(monitor)
virtual intf moni_intf                      ;
sequence_item t_mon                         ; 
uvm_analysis_port #(sequence_item) mon_mail ;
int i ; 

function  new(string name = "MONITOR", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("MONITOR","WE Are Compiling The Monitor",UVM_NONE);
    /***************************************************************************
    * if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",moni_intf))
    * if the name isnt my_vif u will not recieve the interface 
    * the name must match the sent interface with the same name 
    ***************************************************************************/
    if(!uvm_config_db #(virtual intf)::get(this,"","my_vif",moni_intf))
        `uvm_info("MONITOR","ERROR INSIDE MONITOR",UVM_NONE);
    t_mon = sequence_item::type_id::create("t_mon")         ; 
    mon_mail = new("mon_mail",this)                         ; 
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("MONITOR","WE ARE RUNNING THE MONITOR",UVM_NONE)                    ;
    `uvm_info("MONITOR","Monitor Starting To Recieve Data From the DUT",UVM_NONE) ;
    forever  begin 
      $display("Monitor Is Waiting For Packet ......")    ;                                     
      @(posedge moni_intf.CLK)
      #1 
      t_mon.RST            = moni_intf.RST               ;    
      t_mon.P_DATA         = moni_intf.P_DATA            ; 
      t_mon.Data_Valid     = moni_intf.Data_Valid        ; 
      t_mon.parity_enable  = moni_intf.parity_enable     ;  
      t_mon.parity_type    = moni_intf.parity_type       ; 
      t_mon.TX_OUT         = moni_intf.TX_OUT            ; 
      t_mon.busy           = moni_intf.busy              ; 
      t_mon.display_Sequence_item("Monitor")             ; 
      if (t_mon.busy == 1) begin 
         i += 1 ; 
        $display("busy == : %0P",i);   
      end     
      `uvm_info("MONITOR","Monitor has Recieveed the data from the DUT",UVM_NONE) ;
      mon_mail.write(t_mon)                              ;  

    end 


endtask 


endclass