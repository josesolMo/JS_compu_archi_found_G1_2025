/*
 * Autor       : José Solano
 * Módulo      : Contador Binario de 4 bits
 * Descripción : Contador módulo-16 con reset asíncrono activo en bajo.
 * Entradas    : clk (Reloj de sistema), rst_n (Reset maestro).
 * Salidas     : count[3:0] (Estado actual del contador).
 */

module cont4 (
    input  logic clk,
    input  logic rst_n,
    output logic [3:0] count
);
    logic [3:0] next_count;

    // (cuenta + 1) AND rst_n.
    assign next_count = (count + 4'b0001) & {4{rst_n}};

    // VARIABLES DE REGISTRO
    always_ff @(posedge clk) begin
        count <= next_count;
    end
endmodule: cont4