module contador (
    input  logic clk,
    input  logic RESET,
    input  logic en,
    input  logic clr,
    output logic cont1,
    output logic cont0
);

    logic next_cont1, next_cont0;
    logic in_cont1, in_cont0;

    assign next_cont0 = (~clr & ~en &  cont0) |
                        (~clr &  en & (cont1 | ~cont0));

    assign next_cont1 = (~clr & ~en &  cont1) |
                        (~clr &  en & (cont1 |  cont0));

    assign in_cont0 = (~RESET) & next_cont0;
    assign in_cont1 = (~RESET) & next_cont1;

    bit1_reg reg_cont1 (
        .clk(clk),
        .bit_in(in_cont1),
        .bit_out(cont1)
    );

    bit1_reg reg_cont0 (
        .clk(clk),
        .bit_in(in_cont0),
        .bit_out(cont0)
    );

endmodule
