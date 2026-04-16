module divisor_3s(
    input  logic clk,
    output logic tick_3s
);

    logic [27:0] cuenta_actual;
    logic [27:0] suma_uno;
    logic [27:0] siguiente_cuenta;

    logic c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14;
    logic c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27;

    logic eq0, eq1, eq2, eq3, eq4, eq5, eq6, eq7, eq8, eq9, eq10, eq11, eq12, eq13;
    logic eq14, eq15, eq16, eq17, eq18, eq19, eq20, eq21, eq22, eq23, eq24, eq25, eq26, eq27;

    logic a01, a02, a03, a04, a05, a06, a07, a08, a09, a10, a11, a12, a13;
    logic a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26;

    logic reset_contador;

    dff1 R0  (.clk(clk), .d(siguiente_cuenta[0]),  .q(cuenta_actual[0]));
    dff1 R1  (.clk(clk), .d(siguiente_cuenta[1]),  .q(cuenta_actual[1]));
    dff1 R2  (.clk(clk), .d(siguiente_cuenta[2]),  .q(cuenta_actual[2]));
    dff1 R3  (.clk(clk), .d(siguiente_cuenta[3]),  .q(cuenta_actual[3]));
    dff1 R4  (.clk(clk), .d(siguiente_cuenta[4]),  .q(cuenta_actual[4]));
    dff1 R5  (.clk(clk), .d(siguiente_cuenta[5]),  .q(cuenta_actual[5]));
    dff1 R6  (.clk(clk), .d(siguiente_cuenta[6]),  .q(cuenta_actual[6]));
    dff1 R7  (.clk(clk), .d(siguiente_cuenta[7]),  .q(cuenta_actual[7]));
    dff1 R8  (.clk(clk), .d(siguiente_cuenta[8]),  .q(cuenta_actual[8]));
    dff1 R9  (.clk(clk), .d(siguiente_cuenta[9]),  .q(cuenta_actual[9]));
    dff1 R10 (.clk(clk), .d(siguiente_cuenta[10]), .q(cuenta_actual[10]));
    dff1 R11 (.clk(clk), .d(siguiente_cuenta[11]), .q(cuenta_actual[11]));
    dff1 R12 (.clk(clk), .d(siguiente_cuenta[12]), .q(cuenta_actual[12]));
    dff1 R13 (.clk(clk), .d(siguiente_cuenta[13]), .q(cuenta_actual[13]));
    dff1 R14 (.clk(clk), .d(siguiente_cuenta[14]), .q(cuenta_actual[14]));
    dff1 R15 (.clk(clk), .d(siguiente_cuenta[15]), .q(cuenta_actual[15]));
    dff1 R16 (.clk(clk), .d(siguiente_cuenta[16]), .q(cuenta_actual[16]));
    dff1 R17 (.clk(clk), .d(siguiente_cuenta[17]), .q(cuenta_actual[17]));
    dff1 R18 (.clk(clk), .d(siguiente_cuenta[18]), .q(cuenta_actual[18]));
    dff1 R19 (.clk(clk), .d(siguiente_cuenta[19]), .q(cuenta_actual[19]));
    dff1 R20 (.clk(clk), .d(siguiente_cuenta[20]), .q(cuenta_actual[20]));
    dff1 R21 (.clk(clk), .d(siguiente_cuenta[21]), .q(cuenta_actual[21]));
    dff1 R22 (.clk(clk), .d(siguiente_cuenta[22]), .q(cuenta_actual[22]));
    dff1 R23 (.clk(clk), .d(siguiente_cuenta[23]), .q(cuenta_actual[23]));
    dff1 R24 (.clk(clk), .d(siguiente_cuenta[24]), .q(cuenta_actual[24]));
    dff1 R25 (.clk(clk), .d(siguiente_cuenta[25]), .q(cuenta_actual[25]));
    dff1 R26 (.clk(clk), .d(siguiente_cuenta[26]), .q(cuenta_actual[26]));
    dff1 R27 (.clk(clk), .d(siguiente_cuenta[27]), .q(cuenta_actual[27]));

    full_adder FA0  (.A(cuenta_actual[0]),  .B(1'b1), .Cin(1'b0), .S(suma_uno[0]),  .Cout(c1));
    full_adder FA1  (.A(cuenta_actual[1]),  .B(1'b0), .Cin(c1),   .S(suma_uno[1]),  .Cout(c2));
    full_adder FA2  (.A(cuenta_actual[2]),  .B(1'b0), .Cin(c2),   .S(suma_uno[2]),  .Cout(c3));
    full_adder FA3  (.A(cuenta_actual[3]),  .B(1'b0), .Cin(c3),   .S(suma_uno[3]),  .Cout(c4));
    full_adder FA4  (.A(cuenta_actual[4]),  .B(1'b0), .Cin(c4),   .S(suma_uno[4]),  .Cout(c5));
    full_adder FA5  (.A(cuenta_actual[5]),  .B(1'b0), .Cin(c5),   .S(suma_uno[5]),  .Cout(c6));
    full_adder FA6  (.A(cuenta_actual[6]),  .B(1'b0), .Cin(c6),   .S(suma_uno[6]),  .Cout(c7));
    full_adder FA7  (.A(cuenta_actual[7]),  .B(1'b0), .Cin(c7),   .S(suma_uno[7]),  .Cout(c8));
    full_adder FA8  (.A(cuenta_actual[8]),  .B(1'b0), .Cin(c8),   .S(suma_uno[8]),  .Cout(c9));
    full_adder FA9  (.A(cuenta_actual[9]),  .B(1'b0), .Cin(c9),   .S(suma_uno[9]),  .Cout(c10));
    full_adder FA10 (.A(cuenta_actual[10]), .B(1'b0), .Cin(c10),  .S(suma_uno[10]), .Cout(c11));
    full_adder FA11 (.A(cuenta_actual[11]), .B(1'b0), .Cin(c11),  .S(suma_uno[11]), .Cout(c12));
    full_adder FA12 (.A(cuenta_actual[12]), .B(1'b0), .Cin(c12),  .S(suma_uno[12]), .Cout(c13));
    full_adder FA13 (.A(cuenta_actual[13]), .B(1'b0), .Cin(c13),  .S(suma_uno[13]), .Cout(c14));
    full_adder FA14 (.A(cuenta_actual[14]), .B(1'b0), .Cin(c14),  .S(suma_uno[14]), .Cout(c15));
    full_adder FA15 (.A(cuenta_actual[15]), .B(1'b0), .Cin(c15),  .S(suma_uno[15]), .Cout(c16));
    full_adder FA16 (.A(cuenta_actual[16]), .B(1'b0), .Cin(c16),  .S(suma_uno[16]), .Cout(c17));
    full_adder FA17 (.A(cuenta_actual[17]), .B(1'b0), .Cin(c17),  .S(suma_uno[17]), .Cout(c18));
    full_adder FA18 (.A(cuenta_actual[18]), .B(1'b0), .Cin(c18),  .S(suma_uno[18]), .Cout(c19));
    full_adder FA19 (.A(cuenta_actual[19]), .B(1'b0), .Cin(c19),  .S(suma_uno[19]), .Cout(c20));
    full_adder FA20 (.A(cuenta_actual[20]), .B(1'b0), .Cin(c20),  .S(suma_uno[20]), .Cout(c21));
    full_adder FA21 (.A(cuenta_actual[21]), .B(1'b0), .Cin(c21),  .S(suma_uno[21]), .Cout(c22));
    full_adder FA22 (.A(cuenta_actual[22]), .B(1'b0), .Cin(c22),  .S(suma_uno[22]), .Cout(c23));
    full_adder FA23 (.A(cuenta_actual[23]), .B(1'b0), .Cin(c23),  .S(suma_uno[23]), .Cout(c24));
    full_adder FA24 (.A(cuenta_actual[24]), .B(1'b0), .Cin(c24),  .S(suma_uno[24]), .Cout(c25));
    full_adder FA25 (.A(cuenta_actual[25]), .B(1'b0), .Cin(c25),  .S(suma_uno[25]), .Cout(c26));
    full_adder FA26 (.A(cuenta_actual[26]), .B(1'b0), .Cin(c26),  .S(suma_uno[26]), .Cout(c27));
    full_adder FA27 (.A(cuenta_actual[27]), .B(1'b0), .Cin(c27),  .S(suma_uno[27]), .Cout());

    xnor X0  (eq0,  cuenta_actual[0],  1'b1);
    xnor X1  (eq1,  cuenta_actual[1],  1'b1);
    xnor X2  (eq2,  cuenta_actual[2],  1'b1);
    xnor X3  (eq3,  cuenta_actual[3],  1'b1);
    xnor X4  (eq4,  cuenta_actual[4],  1'b1);
    xnor X5  (eq5,  cuenta_actual[5],  1'b1);
    xnor X6  (eq6,  cuenta_actual[6],  1'b1);
    xnor X7  (eq7,  cuenta_actual[7],  1'b1);
    xnor X8  (eq8,  cuenta_actual[8],  1'b0);
    xnor X9  (eq9,  cuenta_actual[9],  1'b0);
    xnor X10 (eq10, cuenta_actual[10], 1'b1);
    xnor X11 (eq11, cuenta_actual[11], 1'b1);
    xnor X12 (eq12, cuenta_actual[12], 1'b0);
    xnor X13 (eq13, cuenta_actual[13], 1'b0);
    xnor X14 (eq14, cuenta_actual[14], 1'b1);
    xnor X15 (eq15, cuenta_actual[15], 1'b0);
    xnor X16 (eq16, cuenta_actual[16], 1'b1);
    xnor X17 (eq17, cuenta_actual[17], 1'b1);
    xnor X18 (eq18, cuenta_actual[18], 1'b0);
    xnor X19 (eq19, cuenta_actual[19], 1'b0);
    xnor X20 (eq20, cuenta_actual[20], 1'b1);
    xnor X21 (eq21, cuenta_actual[21], 1'b1);
    xnor X22 (eq22, cuenta_actual[22], 1'b1);
    xnor X23 (eq23, cuenta_actual[23], 1'b1);
    xnor X24 (eq24, cuenta_actual[24], 1'b0);
    xnor X25 (eq25, cuenta_actual[25], 1'b0);
    xnor X26 (eq26, cuenta_actual[26], 1'b0);
    xnor X27 (eq27, cuenta_actual[27], 1'b1);

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
    and A20 (a21, a20,  eq21);
    and A21 (a22, a21,  eq22);
    and A22 (a23, a22,  eq23);
    and A23 (a24, a23,  eq24);
    and A24 (a25, a24,  eq25);
    and A25 (a26, a25,  eq26);
    and A26 (reset_contador, a26, eq27);

    mux2_1bit M0  (.a(suma_uno[0]),  .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[0]));
    mux2_1bit M1  (.a(suma_uno[1]),  .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[1]));
    mux2_1bit M2  (.a(suma_uno[2]),  .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[2]));
    mux2_1bit M3  (.a(suma_uno[3]),  .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[3]));
    mux2_1bit M4  (.a(suma_uno[4]),  .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[4]));
    mux2_1bit M5  (.a(suma_uno[5]),  .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[5]));
    mux2_1bit M6  (.a(suma_uno[6]),  .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[6]));
    mux2_1bit M7  (.a(suma_uno[7]),  .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[7]));
    mux2_1bit M8  (.a(suma_uno[8]),  .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[8]));
    mux2_1bit M9  (.a(suma_uno[9]),  .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[9]));
    mux2_1bit M10 (.a(suma_uno[10]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[10]));
    mux2_1bit M11 (.a(suma_uno[11]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[11]));
    mux2_1bit M12 (.a(suma_uno[12]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[12]));
    mux2_1bit M13 (.a(suma_uno[13]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[13]));
    mux2_1bit M14 (.a(suma_uno[14]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[14]));
    mux2_1bit M15 (.a(suma_uno[15]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[15]));
    mux2_1bit M16 (.a(suma_uno[16]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[16]));
    mux2_1bit M17 (.a(suma_uno[17]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[17]));
    mux2_1bit M18 (.a(suma_uno[18]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[18]));
    mux2_1bit M19 (.a(suma_uno[19]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[19]));
    mux2_1bit M20 (.a(suma_uno[20]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[20]));
    mux2_1bit M21 (.a(suma_uno[21]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[21]));
    mux2_1bit M22 (.a(suma_uno[22]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[22]));
    mux2_1bit M23 (.a(suma_uno[23]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[23]));
    mux2_1bit M24 (.a(suma_uno[24]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[24]));
    mux2_1bit M25 (.a(suma_uno[25]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[25]));
    mux2_1bit M26 (.a(suma_uno[26]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[26]));
    mux2_1bit M27 (.a(suma_uno[27]), .b(1'b0), .sel(reset_contador), .y(siguiente_cuenta[27]));

    assign tick_3s = reset_contador;

endmodule