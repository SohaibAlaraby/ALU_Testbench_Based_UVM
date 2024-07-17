
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

initial begin

uvm_config_db #(virtual ALU_interface) ::set(null,"*","intf",intf);
run_test("ALU_Test");
end
endmodule
