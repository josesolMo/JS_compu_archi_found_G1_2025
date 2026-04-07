module detector_flanco (
    input  logic clk,
    input  logic RESET,
    input  logic OK,
    output logic OK_pulse
);

    logic ok1, ok2;
    logic next_ok1, next_ok2;

    assign next_ok1 = (~RESET) & OK;
    assign next_ok2 = (~RESET) & ok1;

    bit1_reg reg_ok1 (
        .clk(clk),
        .bit_in(next_ok1),
        .bit_out(ok1)
    );

    bit1_reg reg_ok2 (
        .clk(clk),
        .bit_in(next_ok2),
        .bit_out(ok2)
    );

    assign OK_pulse = ok2 & ~ok1;

endmodule