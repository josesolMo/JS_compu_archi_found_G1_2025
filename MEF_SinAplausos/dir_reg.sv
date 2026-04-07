module dir_reg (
    input  logic OK,
    input  logic RESET,
    input  logic en,
    input  logic DIR,
    output logic dir
);

    logic next_dir;

    assign next_dir = (~en & dir) | (en & DIR);

    bit1_reg reg_dir (
        .clk(OK),
        .RESET(RESET),
        .bit_in(next_dir),
        .bit_out(dir)
    );

endmodule
