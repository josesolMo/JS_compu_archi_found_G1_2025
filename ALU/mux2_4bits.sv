module mux2_4bits(
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic sel,
    output logic [3:0] y
);

    mux2_1bit M0(.a(a[0]), .b(b[0]), .sel(sel), .y(y[0]));
    mux2_1bit M1(.a(a[1]), .b(b[1]), .sel(sel), .y(y[1]));
    mux2_1bit M2(.a(a[2]), .b(b[2]), .sel(sel), .y(y[2]));
    mux2_1bit M3(.a(a[3]), .b(b[3]), .sel(sel), .y(y[3]));

endmodule