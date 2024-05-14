class ALU_Scoreboard extends uvm_scoreboard;
`uvm_component_utils(ALU_Scoreboard) // macro to register the class with UVM factory

uvm_analysis_imp #(ALU_Sequence_Item,ALU_Scoreboard) scb_port;

ALU_Sequence_Item FIFO[$];
function new(string name="ALU_Scoreboard", uvm_component parent=null);
    super.new(name,parent);
    `uvm_info(get_type_name(),"in ALU_Scoreboard constructor",UVM_LOW)
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),"in ALU_Scoreboard build_phase",UVM_LOW)
    scb_port=new("scb_port",this);
endfunction 
function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"in ALU_Scoreboard connect_phase",UVM_LOW)
endfunction 

task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(),"in ALU_Scoreboard run_phase",UVM_LOW)
    forever begin
        ALU_Sequence_Item item;
        wait(FIFO.size());
        item = FIFO.pop_front();
        compare(item);
    end
endtask 

function void write(ALU_Sequence_Item item);
    FIFO.push_back(item);
endfunction

function void compare(ALU_Sequence_Item item);
   
   
   logic[15:0] Result;
   bit         C_out, Z_flag;

   case (item.op_code)
    3'b000:begin 
        Result=item.A + item.B + item.C_in;
        C_out = Result[8];
    end
    3'b001: begin 
        Result=item.A - item.B;
        C_out = Result[8];
    end 
    3'b010: begin 
        Result=item.A * item.B;
        C_out = 0;
    end
    3'b011: begin 
        Result=item.A / item.B;
        C_out = 0;
    end
    3'b100: begin 
        Result=item.A & item.B;
        C_out = 0;
    end
    3'b101: begin 
        Result=item.A ^ item.B;
        C_out = 0;
    end
   endcase
    
    Z_flag = (Result==0)? 1'b1 : 1'b0;
    
    if(!((Z_flag == item.Z_flag) && (Result==item.Result)&&(C_out == item.C_out)) && (item.Reset != 1)) begin
        `uvm_error(get_type_name(),$sformatf("error,reset=%b cout=%b ,item.cout=%b A= %d, B=%d, opcode = %b Result %d expected %d ",item.Reset, C_out,item.C_out,item.A,item.B,item.op_code,item.Result,Result))
    end else begin
        `uvm_info(get_type_name(),"pass successfully",UVM_HIGH)
    end


endfunction 

endclass 
