module buzzer_ctrl(
    input  logic clk,
    input  logic tick,
    input  logic start,
    input  logic [1:0] code,
    output logic buzzer
);

    logic q2, q1, q0;
    logic d2, d1, d0;

    logic m1, m0;
    logic md1, md0;

    logic idle;
    logic s1, s2, s3, s4, s5, s6;

    logic load_mode;
    logic adv;

    logic mode1, mode2, mode3;
    logic done;

    logic n2_run, n1_run, n0_run;

    assign idle = (~q2) & (~q1) & (~q0);

    assign s1 = (~q2) & (~q1) & ( q0);
    assign s2 = (~q2) & ( q1) & (~q0);
    assign s3 = (~q2) & ( q1) & ( q0);
    assign s4 = ( q2) & (~q1) & (~q0);
    assign s5 = ( q2) & (~q1) & ( q0);
    assign s6 = ( q2) & ( q1) & (~q0);

    assign load_mode = start & idle;
    assign adv = tick & (~idle);

    assign md1 = (load_mode & code[1]) | ((~load_mode) & m1);
    assign md0 = (load_mode & code[0]) | ((~load_mode) & m0);

    dff1 U_M1 (.clk(clk), .d(md1), .q(m1));
    dff1 U_M0 (.clk(clk), .d(md0), .q(m0));

    assign mode1 = (~m1) & m0;
    assign mode2 = m1 & (~m0);
    assign mode3 = m1 & m0;

    assign done = (mode1 & s2) |
                  (mode2 & s4) |
                  (mode3 & s6);

    assign n2_run = s3 | s4 | s5;
    assign n1_run = s1 | s2 | s5;
    assign n0_run = s2 | s4;

    assign d2 = (load_mode & 1'b0) |
                ((~load_mode) & ((adv & ((~done) & n2_run)) | ((~adv) & q2)));

    assign d1 = (load_mode & 1'b0) |
                ((~load_mode) & ((adv & ((~done) & n1_run)) | ((~adv) & q1)));

    assign d0 = (load_mode & 1'b1) |
                ((~load_mode) & ((adv & ((~done) & n0_run)) | ((~adv) & q0)));

    dff1 U_Q2 (.clk(clk), .d(d2), .q(q2));
    dff1 U_Q1 (.clk(clk), .d(d1), .q(q1));
    dff1 U_Q0 (.clk(clk), .d(d0), .q(q0));

    assign buzzer = s1 | s3 | s5;

endmodule