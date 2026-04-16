/*
 * Autor       : José Solano
 * Módulo      : Decodificador Hexadecimal
 * Descripción : Convierte binario de 4 bits a 7-segmentos (Ánodo Común).
 * Entradas    : bin[3:0] (Valor de 0 a F).
 * Salidas     : seg[6:0] (Patrón para encender segmentos g-f-e-d-c-b-a).
 */

module hex_dec (
    input  logic [3:0] bin,
    output logic [6:0] seg
);
    // Señales individuales
    logic A, B, C, D;
    logic nA, nB, nC, nD;

    // Separar el bus en cables individuales
    buf (A, bin[3]);
    buf (B, bin[2]);
    buf (C, bin[1]);
    buf (D, bin[0]);

    // Inversores
    not (nA, A);
    not (nB, B);
    not (nC, C);
    not (nD, D);

    // Minitérminos
    logic w_a1, w_a2, w_a3, w_a4;
    logic w_b1, w_b2, w_b3, w_b4, w_b5, w_b6;
    logic w_c1, w_c2, w_c3, w_c4;
    logic w_d1, w_d2, w_d3, w_d4, w_d5, w_d6;
    logic w_e1, w_e2, w_e3, w_e4, w_e5, w_e6;
    logic w_f1, w_f2, w_f3, w_f4, w_f5;
    logic w_g1, w_g2, w_g3, w_g4;


    // Lógica de compuertas

    // Segmento A (seg[0])
    and (w_a1, nA, nB, nC, D);
    and (w_a2, nA, B, nC, nD);
    and (w_a3, A, nB, C, D);
    and (w_a4, A, B, nC, D);
    or  (seg[0], w_a1, w_a2, w_a3, w_a4);

    // Segmento B (seg[1])
    and (w_b1, nA, B, nC, D);
    and (w_b2, nA, B, C, nD);
    and (w_b3, A, nB, C, D);
    and (w_b4, A, B, nC, nD);
    and (w_b5, A, B, C, nD);
    and (w_b6, A, B, C, D);
    or  (seg[1], w_b1, w_b2, w_b3, w_b4, w_b5, w_b6);

    // Segmento C (seg[2])
    and (w_c1, nA, nB, C, nD);
    and (w_c2, A, B, nC, nD);
    and (w_c3, A, B, C, nD);
    and (w_c4, A, B, C, D);
    or  (seg[2], w_c1, w_c2, w_c3, w_c4);

    // Segmento D (seg[3])
    and (w_d1, nA, nB, nC, D);
    and (w_d2, nA, B, nC, nD);
    and (w_d3, nA, B, C, D);
    and (w_d4, A, nB, nC, D);
    and (w_d5, A, nB, C, nD);
    and (w_d6, A, B, C, D);
    or  (seg[3], w_d1, w_d2, w_d3, w_d4, w_d5, w_d6);

    // Segmento E (seg[4])
    and (w_e1, nA, nB, nC, D);
    and (w_e2, nA, nB, C, D);
    and (w_e3, nA, B, nC, nD);
    and (w_e4, nA, B, nC, D);
    and (w_e5, nA, B, C, D);
    and (w_e6, A, nB, nC, D);
    or  (seg[4], w_e1, w_e2, w_e3, w_e4, w_e5, w_e6);

    // Segmento F (seg[5])
    and (w_f1, nA, nB, nC, D);
    and (w_f2, nA, nB, C, nD);
    and (w_f3, nA, nB, C, D);
    and (w_f4, nA, B, C, D);
    and (w_f5, A, B, nC, D);
    or  (seg[5], w_f1, w_f2, w_f3, w_f4, w_f5);

    // Segmento G (seg[6])
    and (w_g1, nA, nB, nC, nD);
    and (w_g2, nA, nB, nC, D);
    and (w_g3, nA, B, C, D);
    and (w_g4, A, B, nC, nD);
    or  (seg[6], w_g1, w_g2, w_g3, w_g4);

endmodule: hex_dec