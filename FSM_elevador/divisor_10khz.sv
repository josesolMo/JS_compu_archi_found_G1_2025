module divisor_10khz(
    input  logic clk,
    output logic tick_10khz
);

    logic [12:0] q;
    logic [12:0] sum1;
    logic [12:0] d;

    logic c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12;

    logic eq0, eq1, eq2, eq3, eq4, eq5, eq6, eq7, eq8, eq9, eq10, eq11, eq12;
    logic a01, a02, a03, a04, a05, a06, a07, a08, a09, a10, a11;

    logic reset_contador;

    dff1 R0  (.clk(clk), .d(d[0]),  .q(q[0]));
    dff1 R1  (.clk(clk), .d(d[1]),  .q(q[1]));
    dff1 R2  (.clk(clk), .d(d[2]),  .q(q[2]));
    dff1 R3  (.clk(clk), .d(d[3]),  .q(q[3]));
    dff1 R4  (.clk(clk), .d(d[4]),  .q(q[4]));
    dff1 R5  (.clk(clk), .d(d[5]),  .q(q[5]));
    dff1 R6  (.clk(clk), .d(d[6]),  .q(q[6]));
    dff1 R7  (.clk(clk), .d(d[7]),  .q(q[7]));
    dff1 R8  (.clk(clk), .d(d[8]),  .q(q[8]));
    dff1 R9  (.clk(clk), .d(d[9]),  .q(q[9]));
    dff1 R10 (.clk(clk), .d(d[10]), .q(q[10]));
    dff1 R11 (.clk(clk), .d(d[11]), .q(q[11]));
    dff1 R12 (.clk(clk), .d(d[12]), .q(q[12]));

    full_adder FA0  (.A(q[0]),  .B(1'b1), .Cin(1'b0), .S(sum1[0]),  .Cout(c1));
    full_adder FA1  (.A(q[1]),  .B(1'b0), .Cin(c1),   .S(sum1[1]),  .Cout(c2));
    full_adder FA2  (.A(q[2]),  .B(1'b0), .Cin(c2),   .S(sum1[2]),  .Cout(c3));
    full_adder FA3  (.A(q[3]),  .B(1'b0), .Cin(c3),   .S(sum1[3]),  .Cout(c4));
    full_adder FA4  (.A(q[4]),  .B(1'b0), .Cin(c4),   .S(sum1[4]),  .Cout(c5));
    full_adder FA5  (.A(q[5]),  .B(1'b0), .Cin(c5),   .S(sum1[5]),  .Cout(c6));
    full_adder FA6  (.A(q[6]),  .B(1'b0), .Cin(c6),   .S(sum1[6]),  .Cout(c7));
    full_adder FA7  (.A(q[7]),  .B(1'b0), .Cin(c7),   .S(sum1[7]),  .Cout(c8));
    full_adder FA8  (.A(q[8]),  .B(1'b0), .Cin(c8),   .S(sum1[8]),  .Cout(c9));
    full_adder FA9  (.A(q[9]),  .B(1'b0), .Cin(c9),   .S(sum1[9]),  .Cout(c10));
    full_adder FA10 (.A(q[10]), .B(1'b0), .Cin(c10),  .S(sum1[10]), .Cout(c11));
    full_adder FA11 (.A(q[11]), .B(1'b0), .Cin(c11),  .S(sum1[11]), .Cout(c12));
    full_adder FA12 (.A(q[12]), .B(1'b0), .Cin(c12),  .S(sum1[12]), .Cout());

    // 4,999 = 13'b1_0011_1000_0111
    xnor X0  (eq0,  q[0],  1'b1);
    xnor X1  (eq1,  q[1],  1'b1);
    xnor X2  (eq2,  q[2],  1'b1);
    xnor X3  (eq3,  q[3],  1'b0);
    xnor X4  (eq4,  q[4],  1'b0);
    xnor X5  (eq5,  q[5],  1'b0);
    xnor X6  (eq6,  q[6],  1'b0);
    xnor X7  (eq7,  q[7],  1'b1);
    xnor X8  (eq8,  q[8],  1'b1);
    xnor X9  (eq9,  q[9],  1'b1);
    xnor X10 (eq10, q[10], 1'b0);
    xnor X11 (eq11, q[11], 1'b0);
    xnor X12 (eq12, q[12], 1'b1);

    and A0  (a01, eq0,  eq1);
    and A1  (a02, a01,  eq2);
    and A2  (a03, a02,  eq3);
    and A3  (a04, a03,  eq4);
    and A4  (a05, a04,  eq5);
    and A5  (a06, a05,  eq6);
    and A6  (a07, a06,  eq7);
    and A7  (a08, a07,  eq8);
    and A8  (a09, a08,  eq9);
    and A9  (a10, a09,  eq10);
    and A10 (a11, a10,  eq11);
    and A11 (reset_contador, a11, eq12);

    mux2_1bit M0  (.a(sum1[0]),  .b(1'b0), .sel(reset_contador), .y(d[0]));
    mux2_1bit M1  (.a(sum1[1]),  .b(1'b0), .sel(reset_contador), .y(d[1]));
    mux2_1bit M2  (.a(sum1[2]),  .b(1'b0), .sel(reset_contador), .y(d[2]));
    mux2_1bit M3  (.a(sum1[3]),  .b(1'b0), .sel(reset_contador), .y(d[3]));
    mux2_1bit M4  (.a(sum1[4]),  .b(1'b0), .sel(reset_contador), .y(d[4]));
    mux2_1bit M5  (.a(sum1[5]),  .b(1'b0), .sel(reset_contador), .y(d[5]));
    mux2_1bit M6  (.a(sum1[6]),  .b(1'b0), .sel(reset_contador), .y(d[6]));
    mux2_1bit M7  (.a(sum1[7]),  .b(1'b0), .sel(reset_contador), .y(d[7]));
    mux2_1bit M8  (.a(sum1[8]),  .b(1'b0), .sel(reset_contador), .y(d[8]));
    mux2_1bit M9  (.a(sum1[9]),  .b(1'b0), .sel(reset_contador), .y(d[9]));
    mux2_1bit M10 (.a(sum1[10]), .b(1'b0), .sel(reset_contador), .y(d[10]));
    mux2_1bit M11 (.a(sum1[11]), .b(1'b0), .sel(reset_contador), .y(d[11]));
    mux2_1bit M12 (.a(sum1[12]), .b(1'b0), .sel(reset_contador), .y(d[12]));

    assign tick_10khz = reset_contador;

endmodule