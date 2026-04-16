module calc_distancia(
    input  logic [3:0] piso_actual,
    input  logic [3:0] piso_destino,
    output logic [3:0] distancia
);

    logic ge;
    logic [3:0] diff1;
    logic [3:0] diff2;
    logic cout1, cout2;

    comparador_ge_4bits U_COMP(
        .A (piso_destino),
        .B (piso_actual),
        .ge(ge)
    );

    addsub_4bits U_SUB1(
        .A   (piso_destino),
        .B   (piso_actual),
        .op  (1'b0),
        .S   (diff1),
        .Cout(cout1)
    );

    addsub_4bits U_SUB2(
        .A   (piso_actual),
        .B   (piso_destino),
        .op  (1'b0),
        .S   (diff2),
        .Cout(cout2)
    );

    mux2_4bits U_MUX_DIST(
        .a  (diff2),
        .b  (diff1),
        .sel(ge),
        .y  (distancia)
    );

endmodule