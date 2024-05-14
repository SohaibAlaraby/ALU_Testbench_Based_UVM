class base_sequence extends uvm_sequence #(ALU_Sequence_Item) ;
    `uvm_object_utils(base_sequence)

    // Constructor
    function new (string name= "Base_Sequence");
        super.new(name);
        `uvm_info(get_type_name()," in constructor of Base_Sequence ",UVM_HIGH)
    endfunction: new
endclass: base_sequence


class rst_sequence extends base_sequence ;

`uvm_object_utils(rst_sequence)

ALU_Sequence_Item reset_item;

function new(string name = "rst_sequence");
    super.new(name);
    `uvm_info(get_type_name() ," in constructor of rst_sequence ",UVM_HIGH)
endfunction

task body();
    reset_item = ALU_Sequence_Item::type_id::create("reset_item");
    start_item(reset_item);
    if(!(reset_item.randomize() with {Reset == 1;}))begin
        `uvm_error(get_type_name(),"fail to randomize");
    end
    finish_item(reset_item);


endtask:body


endclass:rst_sequence

class test_sequence extends base_sequence ;

`uvm_object_utils(test_sequence)

ALU_Sequence_Item test_item;

function new(string name = "test_sequence");
    super.new(name);
    `uvm_info(get_type_name() ," in constructor of test_sequence ",UVM_HIGH)
endfunction

task body();
    test_item = ALU_Sequence_Item::type_id::create("test_item");
    start_item(test_item);
    if(!(test_item.randomize() with {Reset == 0;}))begin
        `uvm_error(get_type_name(),"fail to randomize")
    end
    finish_item(test_item);


endtask:body


endclass:test_sequence