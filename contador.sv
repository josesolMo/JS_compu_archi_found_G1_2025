module contador (
    input  logic OK,
    input  logic RESET,
    input  logic en,
    input  logic clr,
    output logic cont1,
    output logic cont0
);

    logic next_cont1;
    logic next_cont0;

    assign next_cont0 = (~clr & ~en &  cont0) |
                        (~clr &  en & (cont1 | ~cont0));

    assign next_cont1 = (~clr & ~en &  cont1) |
                        (~clr &  en & (cont1 |  cont0));

    bit1_reg reg_cont1 (
        .clk(OK),
        .RESET(RESET),
        .bit_in(next_cont1),
        .bit_out(cont1)
    );

    bit1_reg reg_cont0 (
        .clk(OK),
        .RESET(RESET),
        .bit_in(next_cont0),
        .bit_out(cont0)
    );

endmodule
