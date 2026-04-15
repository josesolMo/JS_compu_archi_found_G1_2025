module dir_reg(
    input  logic clk,
    input  logic enable,
    input  logic dir_in,
    output logic dir_out
);

    logic d_next;

    mux2_1bit U_MUX_DIR(
        .a  (dir_out),
        .b  (dir_in),
        .sel(enable),
        .y  (d_next)
    );

    dff1 U_FF_DIR(
        .clk(clk),
        .d(d_next),
        .q(dir_out)
    );

endmodule