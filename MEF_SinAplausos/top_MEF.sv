module top_mef (
    input  logic clk,
    input  logic OK,
    input  logic DIR,
    input  logic SW,
    output logic E,
    output logic D,
    output logic V,
    output logic C,
    output logic P3,
    output logic P2,
    output logic P1,
    output logic P0
);

    logic S1, S0;
    logic next_S1, next_S0;
    logic cont1, cont0;
    logic dir;

    logic en_cont, en_piso, en_dir;
    logic C_int;

    assign en_cont = S1 & ~S0 & ~OK;
    assign en_piso = S1 & ~S0 & ~OK;
    assign en_dir  = ~S1 & S0 & ~OK;

    estado_reg u_estado_reg (
        .clk(clk),
        .next_S1(next_S1),
        .next_S0(next_S0),
        .S1(S1),
        .S0(S0)
    );

    contador u_contador (
        .clk(clk),
        .en(en_cont),
        .cont1(cont1),
        .cont0(cont0)
    );

    dir_reg u_dir_reg (
        .clk(clk),
        .en(en_dir),
        .DIR(DIR),
        .dir(dir)
    );

    piso_reg u_piso_reg (
        .clk(clk),
        .en(en_piso),
        .SW(SW),
        .P3(P3),
        .P2(P2),
        .P1(P1),
        .P0(P0)
    );

    salida u_salida (
        .S1(S1),
        .S0(S0),
        .dir(dir),
        .cont1(cont1),
        .cont0(cont0),
        .E(E),
        .D(D),
        .V(V),
        .C(C_int)
    );

    siguiente_estado u_next (
        .S1(S1),
        .S0(S0),
        .OK(~OK),
        .C(C_int),
        .next_S1(next_S1),
        .next_S0(next_S0)
    );

    assign C = C_int;

endmodule