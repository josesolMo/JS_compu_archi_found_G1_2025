module dir_reg (
    input  logic clk,
    input  logic en,
    input  logic DIR,
    output logic dir
);

    logic next_dir;

    assign next_dir = (~en & dir) |
                      ( en & DIR);

    bit1_reg reg_dir (
        .clk(clk),
        .bit_in(next_dir),
        .bit_out(dir)
    );

endmodule
