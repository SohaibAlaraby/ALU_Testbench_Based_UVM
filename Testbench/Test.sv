class ALU_Test extends uvm_test;
`uvm_component_utils(ALU_Test)

ALU_Env env;
rst_sequence rst_seq;
test_sequence tst_seq;
function new(string name="ALU_Test", uvm_component parent = null);
    super.new(name , parent);
    `uvm_info(get_type_name(),"in ALU_Test constructor",UVM_LOW)
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = ALU_Env::type_id::create("env",this);
    `uvm_info(get_type_name(),"in ALU_Test build phase",UVM_LOW)
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(),"in ALU_Test connect phase",UVM_LOW)
endfunction:connect_phase

task run_phase(uvm_phase phase);

    super.run_phase(phase);
    `uvm_info(get_type_name(),"in ALU_Test run phase",UVM_LOW)

    phase.raise_objection(this);
    /*
    virtual task start(
    uvm_sequencer_base sequencer,
    uvm_sequence_base parent_sequence = null,
    int this_priority = -1,
    bit call_pre_post = 1
    );
    1-sequencer: The sequencer on which the sequence will run.
    parent_sequence: Optional argument that controls 
    2-whether pre_do, mid_do, and post_do are called in the parent sequence.
    3-this_priority: Priority for the sequence (usually inherited from the parent sequence).
    call_pre_post: Determines whether to 
    4-call pre_body() and post_body() of the current sequence.
    */
    rst_seq = rst_sequence::type_id::create("rst_seq");
    rst_seq.start(env.alu_agt.alu_sequencer);
    /*
    rst_seq = base_sequence::type_id::create("rst_seq");
    rst_seq = base_sequence::type_id::create("rst_seq",this);
    The first line creates an isolated instance of the sequence.
    The second line associates the sequence with a specific context (parent component),
    allowing it to inherit properties or settings. 
    This context-awareness can be beneficial in complex testbenches.
    
    */
    repeat(10000) begin
        #20
        tst_seq= test_sequence::type_id::create("tst_seq");
        tst_seq.start(env.alu_agt.alu_sequencer);
    end

    phase.drop_objection(this);
endtask:run_phase

endclass:ALU_Test
