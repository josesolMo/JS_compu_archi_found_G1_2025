module estado_reg (
    input  logic clk,
    input  logic RESET,
    input  logic next_S1,
    input  logic next_S0,
    output logic S1,
    output logic S0
);

    logic in_S1, in_S0;

    assign in_S1 = (~RESET) & next_S1;
    assign in_S0 = (~RESET) & next_S0;

    bit1_reg reg_S1 (
        .clk(clk),
        .bit_in(in_S1),
        .bit_out(S1)
    );

    bit1_reg reg_S0 (
        .clk(clk),
        .bit_in(in_S0),
        .bit_out(S0)
    );

endmodule
