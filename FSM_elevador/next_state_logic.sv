module next_state_logic(
    input  logic [2:0] state_reg,
    input  logic       SW,
    input  logic       cont_fin,
    output logic [2:0] next_state
);

    logic s2, s1, s0;
    logic s2_n, s1_n, s0_n;
    logic sw_n;

    logic is_s0, is_s1, is_s2, is_s3, is_s4;

    logic n2_s0, n1_s0, n0_s0;
    logic n2_s1, n1_s1, n0_s1;
    logic n2_s2, n1_s2, n0_s2;
    logic n2_s3, n1_s3, n0_s3;
    logic n2_s4, n1_s4, n0_s4;

    logic t20, t21, t22, t23, t24;
    logic t10, t11, t12, t13, t14;
    logic t00, t01, t02, t03, t04;

    assign s2 = state_reg[2];
    assign s1 = state_reg[1];
    assign s0 = state_reg[0];

    not U0(s2_n, s2);
    not U1(s1_n, s1);
    not U2(s0_n, s0);
    not U3(sw_n, SW);

    and A0(is_s0, s2_n, s1_n, s0_n); // 000
    and A1(is_s1, s2_n, s1_n, s0);   // 001
    and A2(is_s2, s2_n, s1,   s0_n); // 010
    and A3(is_s3, s2_n, s1,   s0);   // 011
    and A4(is_s4, s2,   s1_n, s0_n); // 100

    // 000 -> 000 / 001
    assign n2_s0 = 1'b0;
    assign n1_s0 = 1'b0;
    assign n0_s0 = SW;

    // 001 -> 010
    assign n2_s1 = 1'b0;
    assign n1_s1 = 1'b1;
    assign n0_s1 = 1'b0;

    // 010 -> 010 / 011
    assign n2_s2 = 1'b0;
    assign n1_s2 = 1'b1;
    assign n0_s2 = cont_fin;

    // 011 -> 100 
    assign n2_s3 = 1'b1;
    assign n1_s3 = 1'b0;
    assign n0_s3 = 1'b0;

    // 100 -> 100 / 000
    assign n2_s4 = sw_n;
    assign n1_s4 = 1'b0;
    assign n0_s4 = 1'b0;

    and B20(t20, is_s0, n2_s0);
    and B21(t21, is_s1, n2_s1);
    and B22(t22, is_s2, n2_s2);
    and B23(t23, is_s3, n2_s3);
    and B24(t24, is_s4, n2_s4);
    or  B25(next_state[2], t20, t21, t22, t23, t24);

    and B10(t10, is_s0, n1_s0);
    and B11(t11, is_s1, n1_s1);
    and B12(t12, is_s2, n1_s2);
    and B13(t13, is_s3, n1_s3);
    and B14(t14, is_s4, n1_s4);
    or  B15(next_state[1], t10, t11, t12, t13, t14);

    and B00(t00, is_s0, n0_s0);
    and B01(t01, is_s1, n0_s1);
    and B02(t02, is_s2, n0_s2);
    and B03(t03, is_s3, n0_s3);
    and B04(t04, is_s4, n0_s4);
    or  B05(next_state[0], t00, t01, t02, t03, t04);

endmodule