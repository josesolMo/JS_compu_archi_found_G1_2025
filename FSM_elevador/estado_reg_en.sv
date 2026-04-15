module estado_reg_en(
    input  logic       clk,
    input  logic       enable,
    input  logic [2:0] d,
    output logic [2:0] q
);

    logic [2:0] d_next;

    mux2_1bit M0(.a(q[0]), .b(d[0]), .sel(enable), .y(d_next[0]));
    mux2_1bit M1(.a(q[1]), .b(d[1]), .sel(enable), .y(d_next[1]));
    mux2_1bit M2(.a(q[2]), .b(d[2]), .sel(enable), .y(d_next[2]));

    dff1 FF0(.clk(clk), .d(d_next[0]), .q(q[0]));
    dff1 FF1(.clk(clk), .d(d_next[1]), .q(q[1]));
    dff1 FF2(.clk(clk), .d(d_next[2]), .q(q[2]));

endmodule