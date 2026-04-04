/*
 * Autor       : José Solano
 * Proyecto    : Comparador de Magnitud
 * Descripción : Compara dos valores de 4 bits para generar la señal PWM.
 * Entradas    : a[3:0] (Contador), b[3:0] (Umbral/Threshold).
 * Salidas     : lt (Señal en alto si a < b).
 */

module comparador4 (
    input  logic [3:0] a,
    input  logic [3:0] b,
    output logic       lt
);

    // Lógica combinacional para generar el pulso PWM
    assign lt = (a < b);

endmodule: comparador4