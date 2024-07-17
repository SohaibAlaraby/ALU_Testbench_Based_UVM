
import uvm_pkg::*;
`include "ALU_interface.sv"

`include "uvm_macros.svh"
import ALU_pkg::*;

module Top;
bit CLK;

ALU_interface intf(.CLK(CLK));

DUT  dut(.CLK(CLK),
    .Reset(intf.Reset),
    .A(intf.A),
    .B(intf.B),
    .op_code(intf.op_code),
    .C_in(intf.C_in),
    .Result(intf.Result),
    .C_out(intf.C_out),
    .Z_flag(intf.Z_flag)
);

always begin
    #5 CLK = ~CLK;
end

// initial begin

// #500000
// $finish;

// end
initial begin
/*static function void uvm_config_db#(type T)::set(
    uvm_component cntxt,
    string inst_name,
    string field_name,
    T value
);
T: The type of element being configured (e.g., int, string, custom class, etc.).
cntxt: The context (usually a component) where the configuration setting is made.
inst_name: The instance name (within the context) for which the setting applies.
field_name: The target field (configuration parameter) you want to set.
value: The value to associate with the specified field.

cntxt       --> null    ----> which means the setting is accessible globally.
inst_name   --> "*"     ----> The asterisk (*) is a wildcard, indicating that 
the setting applies to all instances.
field_name  --> "intf"  ----> The target field (configuration parameter) we want to set.
In this case, it’s named “intf.”
value       --> intf    ----> The value to associate with the specified field. 
Presumably, intf is an instance of the ALU_interface
*/
uvm_config_db #(virtual ALU_interface) ::set(null,"*","intf",intf);
run_test("ALU_Test");
end
endmodule
