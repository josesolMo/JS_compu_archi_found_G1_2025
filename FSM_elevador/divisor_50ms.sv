module divisor_50ms(
    input  logic clk,
    output logic tick_50ms
);

    logic [21:0] q;
    logic [21:0] sum1;
    logic [21:0] d;

    logic c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11;
    logic c12, c13, c14, c15, c16, c17, c18, c19, c20, c21;

    logic eq0, eq1, eq2, eq3, eq4, eq5, eq6, eq7, eq8, eq9, eq10;
    logic eq11, eq12, eq13, eq14, eq15, eq16, eq17, eq18, eq19, eq20, eq21;

    logic a01, a02, a03, a04, a05, a06, a07, a08, a09, a10, a11;
    logic a12, a13, a14, a15, a16, a17, a18, a19, a20;

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
    dff1 R13 (.clk(clk), .d(d[13]), .q(q[13]));
    dff1 R14 (.clk(clk), .d(d[14]), .q(q[14]));
    dff1 R15 (.clk(clk), .d(d[15]), .q(q[15]));
    dff1 R16 (.clk(clk), .d(d[16]), .q(q[16]));
    dff1 R17 (.clk(clk), .d(d[17]), .q(q[17]));
    dff1 R18 (.clk(clk), .d(d[18]), .q(q[18]));
    dff1 R19 (.clk(clk), .d(d[19]), .q(q[19]));
    dff1 R20 (.clk(clk), .d(d[20]), .q(q[20]));
    dff1 R21 (.clk(clk), .d(d[21]), .q(q[21]));

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
    full_adder FA12 (.A(q[12]), .B(1'b0), .Cin(c12),  .S(sum1[12]), .Cout(c13));
    full_adder FA13 (.A(q[13]), .B(1'b0), .Cin(c13),  .S(sum1[13]), .Cout(c14));
    full_adder FA14 (.A(q[14]), .B(1'b0), .Cin(c14),  .S(sum1[14]), .Cout(c15));
    full_adder FA15 (.A(q[15]), .B(1'b0), .Cin(c15),  .S(sum1[15]), .Cout(c16));
    full_adder FA16 (.A(q[16]), .B(1'b0), .Cin(c16),  .S(sum1[16]), .Cout(c17));
    full_adder FA17 (.A(q[17]), .B(1'b0), .Cin(c17),  .S(sum1[17]), .Cout(c18));
    full_adder FA18 (.A(q[18]), .B(1'b0), .Cin(c18),  .S(sum1[18]), .Cout(c19));
    full_adder FA19 (.A(q[19]), .B(1'b0), .Cin(c19),  .S(sum1[19]), .Cout(c20));
    full_adder FA20 (.A(q[20]), .B(1'b0), .Cin(c20),  .S(sum1[20]), .Cout(c21));
    full_adder FA21 (.A(q[21]), .B(1'b0), .Cin(c21),  .S(sum1[21]), .Cout());

    xnor X0  (eq0,  q[0],  1'b1);
    xnor X1  (eq1,  q[1],  1'b1);
    xnor X2  (eq2,  q[2],  1'b1);
    xnor X3  (eq3,  q[3],  1'b1);
    xnor X4  (eq4,  q[4],  1'b1);
    xnor X5  (eq5,  q[5],  1'b1);
    xnor X6  (eq6,  q[6],  1'b0);
    xnor X7  (eq7,  q[7],  1'b1);
    xnor X8  (eq8,  q[8],  1'b1);
    xnor X9  (eq9,  q[9],  1'b0);
    xnor X10 (eq10, q[10], 1'b1);
    xnor X11 (eq11, q[11], 1'b0);
    xnor X12 (eq12, q[12], 1'b0);
    xnor X13 (eq13, q[13], 1'b1);
    xnor X14 (eq14, q[14], 1'b0);
    xnor X15 (eq15, q[15], 1'b0);
    xnor X16 (eq16, q[16], 1'b0);
    xnor X17 (eq17, q[17], 1'b1);
    xnor X18 (eq18, q[18], 1'b1);
    xnor X19 (eq19, q[19], 1'b0);
    xnor X20 (eq20, q[20], 1'b0);
    xnor X21 (eq21, q[21], 1'b1);

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
    and A11 (a12, a11,  eq12);
    and A12 (a13, a12,  eq13);
    and A13 (a14, a13,  eq14);
    and A14 (a15, a14,  eq15);
    and A15 (a16, a15,  eq16);
    and A16 (a17, a16,  eq17);
    and A17 (a18, a17,  eq18);
    and A18 (a19, a18,  eq19);
    and A19 (a20, a19,  eq20);
    and A20 (reset_contador, a20, eq21);

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
    mux2_1bit M13 (.a(sum1[13]), .b(1'b0), .sel(reset_contador), .y(d[13]));
    mux2_1bit M14 (.a(sum1[14]), .b(1'b0), .sel(reset_contador), .y(d[14]));
    mux2_1bit M15 (.a(sum1[15]), .b(1'b0), .sel(reset_contador), .y(d[15]));
    mux2_1bit M16 (.a(sum1[16]), .b(1'b0), .sel(reset_contador), .y(d[16]));
    mux2_1bit M17 (.a(sum1[17]), .b(1'b0), .sel(reset_contador), .y(d[17]));
    mux2_1bit M18 (.a(sum1[18]), .b(1'b0), .sel(reset_contador), .y(d[18]));
    mux2_1bit M19 (.a(sum1[19]), .b(1'b0), .sel(reset_contador), .y(d[19]));
    mux2_1bit M20 (.a(sum1[20]), .b(1'b0), .sel(reset_contador), .y(d[20]));
    mux2_1bit M21 (.a(sum1[21]), .b(1'b0), .sel(reset_contador), .y(d[21]));

    assign tick_50ms = reset_contador;

endmodule