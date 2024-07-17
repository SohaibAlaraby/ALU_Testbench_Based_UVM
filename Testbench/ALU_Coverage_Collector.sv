class ALU_Coverage_Collector extends uvm_subscriber #(ALU_Sequence_Item);
`uvm_component_utils(ALU_Coverage_Collector)


ALU_Sequence_Item item;
uvm_analysis_imp #(ALU_Sequence_Item,ALU_Coverage_Collector) analysis_export;
covergroup ALU_cg;
    option.per_instance=1;
    Reset:coverpoint item.Reset;
    A:coverpoint item.A{
        bins All_Ones={8'hFF};
        bins All_Zeros={8'h0};
        bins random_stimulus = default;
    }
    B:coverpoint item.B{
        bins All_Ones={8'hFF};
        bins All_Zeros={8'h0};
        bins random_stimulus = default;
    }
    op_code:coverpoint item.op_code{
        bins add={4'b 0000};
        bins sub={4'b 0001};
        bins mul={4'b 0010};
        bins div={4'b 0011};
        bins anding={4'b 0100};
        bins xoring = {4'b 0101};
    }
    C_in:coverpoint item.C_in;

    corner_cases: cross A,B,op_code {
        //ADD
        bins Add_cross1 = binsof(A.All_Ones) && binsof(B.All_Ones) && binsof(op_code.add);
        bins Add_cross2 = binsof(A.All_Zeros) && binsof(B.All_Zeros) && binsof(op_code.add);
        //SUB
        bins Sub_cross1 = binsof(A.All_Ones) && binsof(B.All_Ones) && binsof(op_code.sub);
        bins Sub_cross2 = binsof(A.All_Zeros) && binsof(B.All_Zeros) && binsof(op_code.sub);
        //MUL
        bins Mul_cross1 = binsof(A.All_Ones) && binsof(B.All_Ones) && binsof(op_code.mul);
        bins Mul_cross2 = binsof(A.All_Zeros) && binsof(B.All_Zeros) && binsof(op_code.mul);
        //DIV
        bins Div_cross1 = binsof(A.All_Ones) && binsof(B.All_Ones) && binsof(op_code.div);
        bins Div_cross2 = binsof(A.All_Zeros) && binsof(B.All_Zeros) && binsof(op_code.div);
        //AND
        bins And_cross1 = binsof(A.All_Ones) && binsof(B.All_Ones) && binsof(op_code.anding);
        bins And_cross2 = binsof(A.All_Zeros) && binsof(B.All_Zeros) && binsof(op_code.anding);
        //XOR
        bins Xor_cross1 = binsof(A.All_Ones) && binsof(B.All_Ones) && binsof(op_code.xoring);
        bins Xor_cross2 = binsof(A.All_Zeros) && binsof(B.All_Zeros) && binsof(op_code.xoring);


    }

endgroup:ALU_cg
function new(string name="ALU_Coverage_Collector" , uvm_component parent = null);
    super.new(name,parent);
    `uvm_info(get_type_name(),"in ALU_Coverage_Collector constructor", UVM_LOW)
    analysis_export= new("analysis_export",this);
    ALU_cg=new();
    
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),"in ALU_Coverage_Collector build_phase", UVM_LOW)
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"in ALU_Coverage_Collector connect_phase", UVM_LOW)
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(),"in ALU_Coverage_Collector run_phase", UVM_LOW)
endtask

function void write(ALU_Sequence_Item t);
    item = ALU_Sequence_Item::type_id::create("item");
    $cast(item,t);
    ALU_cg.sample();


endfunction

endclass
