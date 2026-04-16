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
    logic unused_cout;

    // INSTANCIACIÓN DEL INCREMENTADOR
    // Usamos el módulo del ALU pra count + 1
    addsub_4bits incrementador (
        .A(count),         // Valor actual 
        .B(4'b0001),      // Sumar 1 
        .op(1'b1),        // Configurado para sumar 
        .S(next_count),    // Resultado de la suma
        .Cout(unused_cout) // El acarreo final no lo usamos
    );

    // REGISTRO DE ESTADO
    always_ff @(posedge clk) begin
            count <= next_count;
    end

endmodule