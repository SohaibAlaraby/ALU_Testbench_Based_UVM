module DUT(CLK,Reset,A,B,op_code,C_in,Result,C_out,Z_flag);
    // Input and output signals
    input logic CLK;
    input logic Reset;
    input logic[7:0] A,B;
    input logic[3:0] op_code;
    input bit C_in;
    output logic[15:0] Result;
    output bit C_out, Z_flag;

    // Internal signals
    logic[15:0] Temp;
    logic C_out_t, Z_flag_t;

    // ALU logic
    always_ff @(posedge CLK)
    begin 
        if(Reset) begin
            Result= 0;
            C_out= 0;
            Z_flag =1;
        end
        else begin 
            Result= Temp;
            C_out= C_out_t;
            Z_flag = Z_flag_t;  
        end
    end

    always_comb 
    begin 
        case(op_code) 
            3'b000: begin 
                Temp = A + B +C_in;
                C_out_t=Temp[8];
            end
            3'b001: begin 
                Temp = A - B;
                C_out_t=Temp[8];
            end
            3'b010: begin 
                Temp = A * B;
                C_out_t=0;
            end
            3'b011: begin 
                Temp = A / B;
                C_out_t=0;
            end
            3'b100: begin 
                Temp = A & B;
                C_out_t = 0;
            end
            3'b101: begin 
                Temp = A ^ B;
                C_out_t=0;
            end
        endcase
       
        if(Temp==0)
            Z_flag_t= 1;
        else 
            Z_flag_t= 0;
    end
endmodule 
