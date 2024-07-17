module DUT(
    // Input and output signals
    input logic CLK,
    input logic Reset,
    input logic[7:0] A,B,
    input logic[3:0] op_code,
    input bit C_in,
    output logic[15:0] Result,
    output bit C_out, Z_flag
);
    // Internal signals
    logic[15:0] Temp;
    logic C_out_t, Z_flag_t;
    typedef enum logic [3:0] {ADD=0,SUB=1,MULT=2,DIV=3,ANDD=4,XORR=5  } OP_CODE;
    OP_CODE operation;
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
        $cast(operation , op_code); 
        case(operation) 
            ADD: begin 
                Temp = A + B +C_in;
                C_out_t=Temp[8];
            end
            SUB: begin 
                Temp = A - B;
                C_out_t=Temp[8];
            end
            MULT: begin 
                Temp = A * B;
                C_out_t=0;
            end
            DIV: begin 
                Temp = A / B;
                C_out_t=0;
            end
            ANDD: begin 
                Temp = A & B;
                C_out_t = 0;
            end
            XORR: begin 
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
