module contador_2bits(
    input  logic       clk,
    input  logic       enable,
    input  logic       clear,
    output logic [1:0] q
);

    logic [1:0] q_inc;
    logic [1:0] q_sel;
    logic [1:0] d_next;
    logic c1, c2;

    full_adder FA0(
        .A   (q[0]),
        .B   (1'b1),
        .Cin (1'b0),
        .S   (q_inc[0]),
        .Cout(c1)
    );

    full_adder FA1(
        .A   (q[1]),
        .B   (1'b0),
        .Cin (c1),
        .S   (q_inc[1]),
        .Cout(c2)
    );

    mux2_1bit M0(
        .a  (q[0]),
        .b  (q_inc[0]),
        .sel(enable),
        .y  (q_sel[0])
    );

    mux2_1bit M1(
        .a  (q[1]),
        .b  (q_inc[1]),
        .sel(enable),
        .y  (q_sel[1])
    );

    mux2_1bit M2(
        .a  (q_sel[0]),
        .b  (1'b0),
        .sel(clear),
        .y  (d_next[0])
    );

    mux2_1bit M3(
        .a  (q_sel[1]),
        .b  (1'b0),
        .sel(clear),
        .y  (d_next[1])
    );

    dff1 FF0(.clk(clk), .d(d_next[0]), .q(q[0]));
    dff1 FF1(.clk(clk), .d(d_next[1]), .q(q[1]));

endmodule