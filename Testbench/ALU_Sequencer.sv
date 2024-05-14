class ALU_Sequencer extends uvm_sequencer #(ALU_Sequence_Item);

    `uvm_component_utils(ALU_Sequencer)

    function new(string name = "ALU_Sequencer",uvm_component parent = null);
        super.new(name , parent);
        `uvm_info(get_type_name() ," in constructor of ALU_Sequencer ",UVM_HIGH)
    endfunction 

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name() ," in build_phase of ALU_Sequencer ",UVM_LOW)
    endfunction: build_phase

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name() ," in connect_phase of ALU_Sequencer ",UVM_LOW)
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name() ," in run_phase of ALU_Sequencer ",UVM_LOW)
    endtask: run_phase
endclass:ALU_Sequencer