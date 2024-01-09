class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
uvm_analysis_imp #(sequence_item,scoreboard) score_mail ; 
int passed_test_cases     ;
int failed_test_cases     ;
static int golden_P_Data  ; 
static int golden_Start   ; 
static int golden_parity  ; 
static int golden_end     ; 
static int golden_counter ; 
function  new(string name = "SCOREBOARD", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("SCOREBOARD","WE Are Compiling The Scoreboard",UVM_NONE);
    score_mail = new("score_mail",this) ; 
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("SCOREBOARD","WE ARE RUNNING THE SCOREBOARD",UVM_NONE);

endtask 

task write (sequence_item t_score);
    //t_score.display_Sequence_item("SCOREBOARD") ; 
    golden_Start = 0 ; 
    golden_end   = 1 ;
    if (t_score.RST == 0) begin 
        if (t_score.TX_OUT == 0 )
            passed_test_cases += 1 ; 
    end 
    else if (t_score.Data_Valid == 1) begin 
        golden_P_Data = t_score.P_DATA ;  
    end 
    if (t_score.busy == 1 && golden_counter == 0) begin  
        if (t_score.TX_OUT == golden_Start) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            `uvm_info("SCOREBOARD","Failed",UVM_NONE);
        end
        golden_counter += 1 ; 
    end
    else if (t_score.busy == 1 && golden_counter == 1) begin  
        if (t_score.TX_OUT == golden_P_Data[0] ) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            `uvm_info("SCOREBOARD","Failed",UVM_NONE);
        end
        golden_counter += 1 ; 
    end
    else if (t_score.busy == 1 && golden_counter == 2) begin  
        if (t_score.TX_OUT == golden_P_Data[1] ) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            `uvm_info("SCOREBOARD","Failed",UVM_NONE);
        end
        golden_counter += 1 ; 
    end
    else if (t_score.busy == 1 && golden_counter == 3) begin  
        if (t_score.TX_OUT == golden_P_Data[2] ) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            `uvm_info("SCOREBOARD","Failed",UVM_NONE);
        end
        golden_counter += 1 ; 
    end
    else if (t_score.busy == 1 && golden_counter == 4) begin  
        if (t_score.TX_OUT == golden_P_Data[3] ) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            `uvm_info("SCOREBOARD","Failed",UVM_NONE);
        end
        golden_counter += 1 ; 
    end
    else if (t_score.busy == 1 && golden_counter == 5) begin  
        if (t_score.TX_OUT == golden_P_Data[4] ) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            `uvm_info("SCOREBOARD","Failed",UVM_NONE); 
        end
        golden_counter += 1 ; 
    end
    else if (t_score.busy == 1 && golden_counter == 6) begin  
        if (t_score.TX_OUT == golden_P_Data[5] ) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            `uvm_info("SCOREBOARD","Failed",UVM_NONE);
        end
        golden_counter += 1 ; 
    end
    else if (t_score.busy == 1 && golden_counter == 7) begin  
        if (t_score.TX_OUT == golden_P_Data[6] ) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            `uvm_info("SCOREBOARD","Failed",UVM_NONE); 
        end
        golden_counter += 1 ; 
    end
    else if (t_score.busy == 1 && golden_counter == 8) begin  
        if (t_score.TX_OUT == golden_P_Data[7] ) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            `uvm_info("SCOREBOARD","Failed",UVM_NONE); 
        end
        golden_counter += 1 ; 
    end
    else if (t_score.busy == 1 && t_score.parity_enable == 1 && golden_counter == 9 ) begin  
        if (t_score.parity_type == 0) 
            golden_parity = ^t_score.P_DATA      ;         // Even Parity
        else 
	        golden_parity = ~^t_score.P_DATA   ;         // Odd Parity

        if (t_score.TX_OUT == golden_parity  ) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            `uvm_info("SCOREBOARD","Failed",UVM_NONE); 
        end
        golden_counter += 1 ; 
    end
    else if (t_score.busy == 1 && t_score.parity_enable == 0 && golden_counter == 9 ) begin  

        if (t_score.TX_OUT == golden_end  ) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            `uvm_info("SCOREBOARD","Failed",UVM_NONE); 
        end
        golden_counter = 0 ; 
    end
    else if (t_score.busy == 1 && t_score.parity_enable == 1 && golden_counter == 10 ) begin  
        
        if (t_score.TX_OUT == golden_end  ) begin 
            passed_test_cases += 1 ;
        end else  begin
            failed_test_cases += 1  ;
            `uvm_info("SCOREBOARD","Failed",UVM_NONE); 
        end
        golden_counter = 0 ; 
    end

    /**************************************  Reset Test Case ********************************************/
endtask 

task display_test_cases_report () ;

    $display("The Number of Passed test cases is :%0P " , passed_test_cases ) ; 
    $display("The Number of Failed test cases is :%0P " , failed_test_cases ) ; 
  
endtask 
endclass