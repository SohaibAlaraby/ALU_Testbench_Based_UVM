class ALU_monitor extends uvm_monitor ;
`uvm_component_utils(ALU_monitor)

virtual ALU_interface intf;
uvm_analysis_port #(ALU_Sequence_Item) monitor_port;
   ALU_Sequence_Item  seq_item;
function new(string name = "ALU_monitor" , uvm_component parent = null);
    super.new(name,parent);
    `uvm_info(get_type_name(),"in ALU monitor constructor", UVM_LOW)
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    monitor_port=new("monitor_port",this);
    `uvm_info(get_type_name(),"in ALU monitor build_phase", UVM_LOW)
    if(!(uvm_config_db #(virtual ALU_interface)::get(this,"*","intf",intf))) begin
        `uvm_error(get_type_name(),"Error, DUT interface is not found")    
    end

endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"in ALU monitor connect_phase", UVM_LOW)
endfunction



task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(),"in ALU monitor run_phase", UVM_LOW)
 
    forever begin
        seq_item = ALU_Sequence_Item::type_id::create("seq_item");
        
        @(posedge intf.CLK)
        seq_item.A       = intf.A;
        seq_item.B       = intf.B;
        seq_item.C_in    = intf.C_in;
        seq_item.op_code = intf.op_code;
        seq_item.Reset   = intf.Reset;
        @(posedge intf.CLK)
        seq_item.Result = intf.Result;
        seq_item.C_out  = intf.C_out;
        seq_item.Z_flag = intf.Z_flag;

        monitor_port.write(seq_item);
    end
endtask


endclass:ALU_monitor
