module estado_reg (
    input  logic OK,
    input  logic RESET,
    input  logic next_S1,
    input  logic next_S0,
    output logic S1,
    output logic S0
);

    bit1_reg reg_S1 (
        .clk(OK),
        .RESET(RESET),
        .bit_in(next_S1),
        .bit_out(S1)
    );

    bit1_reg reg_S0 (
        .clk(OK),
        .RESET(RESET),
        .bit_in(next_S0),
        .bit_out(S0)
    );

endmodule
