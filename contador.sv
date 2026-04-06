module contador (
    input  logic clk,
    input  logic en,
    output logic cont1,
    output logic cont0
);

    logic next_cont1;
    logic next_cont0;

    assign next_cont0 = (~en & cont0) |
                        ( en & (cont1 | ~cont0));

    assign next_cont1 = (~en & cont1) |
                        ( en & (cont1 | cont0));

    bit1_reg reg_cont1 (
        .clk(clk),
        .bit_in(next_cont1),
        .bit_out(cont1)
    );

    bit1_reg reg_cont0 (
        .clk(clk),
        .bit_in(next_cont0),
        .bit_out(cont0)
    );

endmodule