module piso_reg (
    input  logic clk,
    input  logic RESET,
    input  logic en,
    input  logic clr,
    input  logic SW,
    output logic P3,
    output logic P2,
    output logic P1,
    output logic P0
);

    logic next_P3, next_P2, next_P1, next_P0;
    logic in_P3, in_P2, in_P1, in_P0;

    assign next_P3 = (~clr & ~en & P3) | (~clr & en & P2);
    assign next_P2 = (~clr & ~en & P2) | (~clr & en & P1);
    assign next_P1 = (~clr & ~en & P1) | (~clr & en & P0);
    assign next_P0 = (~clr & ~en & P0) | (~clr & en & SW);

    assign in_P3 = (~RESET) & next_P3;
    assign in_P2 = (~RESET) & next_P2;
    assign in_P1 = (~RESET) & next_P1;
    assign in_P0 = (~RESET) & next_P0;

    bit1_reg reg_P3 (.clk(clk), .bit_in(in_P3), .bit_out(P3));
    bit1_reg reg_P2 (.clk(clk), .bit_in(in_P2), .bit_out(P2));
    bit1_reg reg_P1 (.clk(clk), .bit_in(in_P1), .bit_out(P1));
    bit1_reg reg_P0 (.clk(clk), .bit_in(in_P0), .bit_out(P0));

endmodule