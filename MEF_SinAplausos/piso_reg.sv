module piso_reg (
    input  logic clk,
    input  logic en,
    input  logic SW,
    output logic P3,
    output logic P2,
    output logic P1,
    output logic P0
);

    logic next_P3, next_P2, next_P1, next_P0;

    assign next_P3 = (~en & P3) | (en & P2);
    assign next_P2 = (~en & P2) | (en & P1);
    assign next_P1 = (~en & P1) | (en & P0);
    assign next_P0 = (~en & P0) | (en & SW);

    bit1_reg reg_P3 (.clk(clk), .bit_in(next_P3), .bit_out(P3));
    bit1_reg reg_P2 (.clk(clk), .bit_in(next_P2), .bit_out(P2));
    bit1_reg reg_P1 (.clk(clk), .bit_in(next_P1), .bit_out(P1));
    bit1_reg reg_P0 (.clk(clk), .bit_in(next_P0), .bit_out(P0));

endmodule