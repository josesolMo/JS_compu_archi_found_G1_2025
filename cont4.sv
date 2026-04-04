/*
 * Autor       : José Solano
 * Módulo      : Contador Binario de 4 bits
 * Descripción : Contador módulo-16 con reset asíncrono activo en bajo.
 * Entradas    : clk (Reloj de sistema), rst_n (Reset maestro).
 * Salidas     : count[3:0] (Estado actual del contador).
 */

module cont4 (
    input  logic       clk,
    input  logic       rst_n,
    output logic [3:0] count
);

    // Registro secuencial con reset asíncrono
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 4'b0000;
        else
            count <= count + 4'b0001;
    end

endmodule: cont4