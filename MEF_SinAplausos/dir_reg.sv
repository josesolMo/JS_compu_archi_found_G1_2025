module dir_reg (
    input  logic clk,
    input  logic RESET,
    input  logic en,
    input  logic DIR,
    output logic dir
);

    logic next_dir, in_dir;

    assign next_dir = (~en & dir) | (en & DIR);
    assign in_dir   = (~RESET) & next_dir;

    bit1_reg reg_dir (
        .clk(clk),
        .bit_in(in_dir),
        .bit_out(dir)
    );

endmodule
