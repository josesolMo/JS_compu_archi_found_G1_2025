module alu_top(
    input  logic       clk,
    input  logic       enable,
    input  logic       op,
    input  logic [3:0] cantidad,
    output logic [3:0] piso_actual,
    output logic [3:0] piso_destino,
    output logic [3:0] distancia,
    output logic       sat,
    output logic       c_out
);

    logic [3:0] resultado_int;

    registro_piso U_REG_PISO(
        .clk        (clk),
        .enable     (enable),
        .nuevo_piso (resultado_int),
        .piso_actual(piso_actual)
    );

    alu_core U_ALU(
        .piso_actual(piso_actual),
        .cantidad   (cantidad),
        .op         (op),
        .resultado  (resultado_int),
        .sat        (sat),
        .c_out      (c_out)
    );

    calc_distancia U_DIST(
        .piso_actual (piso_actual),
        .piso_destino(resultado_int),
        .distancia   (distancia)
    );

    assign piso_destino = resultado_int;

endmodule