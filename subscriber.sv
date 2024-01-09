class subscriber extends uvm_component ;
`uvm_component_utils(subscriber)
uvm_analysis_imp #(sequence_item,subscriber) subs_mail ; 
sequence_item t_sub    ; 
int covered            ;
int total              ; 


covergroup groub1 ; 
    coverpoint t_sub.TX_OUT           {bins All[] = { 0,1 }   ; }
    coverpoint t_sub.busy             {bins All[] = { 0,1 }   ; }
    coverpoint t_sub.P_DATA           {bins All[] = { [0:$] } ; } 
    coverpoint t_sub.parity_enable    {bins All[] = { 0,1 }   ; }
    coverpoint t_sub.parity_type      {bins All[] = { 0,1 }   ; }
endgroup  


function  new(string name = "SUBSCRIBER", uvm_component parent = null);
    super.new(name,parent) ; 
    groub1 = new()         ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("SUBSCRIBER","WE Are Compiling The Subscriber",UVM_NONE);
    subs_mail = new("subs_mail",this) ; 

endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("SUBSCRIBER","WE ARE RUNNING THE SUBSCRIBER",UVM_NONE);

endtask 

task write (sequence_item t_subs);
    t_subs.display_Sequence_item("SUBSCRIBER") ; 
    t_sub = t_subs                             ; 
    groub1.sample()                            ;
endtask


task display_coverage_percentage() ; 
    $display("The Coverage is :%0P ",groub1.get_coverage(covered,total));
    $display("The covered  is :%0P ",covered);
    $display("The total    is :%0P ",total);
endtask

endclass