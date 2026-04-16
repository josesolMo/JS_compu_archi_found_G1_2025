/*
 * Autor       : José Solano
 * Módulo      : Comparador de Magnitud
 * Descripción : Compara dos valores de 4 bits para generar la señal PWM.
 * Entradas    : a[3:0] (Contador), b[3:0] (Umbral/Threshold).
 * Salidas     : lt (Señal en alto si a < b).
 */

module comparador4 (
    input  logic [3:0] a,
    input  logic [3:0] b,
    output logic       lt
);
    logic [3:0] suma_interna;
    logic carry_out;

    // Instanciaciar el restador
    addsub_4bits restador (
        .A(a),
        .B(b),
        .op(1'b0),        // Configurado en resta
        .S(suma_interna),
        .Cout(carry_out) 
    );

    // Si no hay acarreo en la resta, a es menor que b
    assign lt = ~carry_out;

endmodule: comparador4