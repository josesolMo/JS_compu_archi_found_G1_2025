/*
 * Autor       : José Solano
 * Módulo      : Codificador de Umbral
 * Descripción : Genera el umbral del PWM basado en ecuaciones de mapas de Karnaugh.
 * Entradas    : sw[3:0] (Switches de entrada).
 * Salidas     : th[3:0] (Umbral calculado para el comparador).
 */

module th_enc (
    input  logic [3:0] sw,
    output logic [3:0] th
);

    // Ecuaciones de diseño para los bits del umbral
    assign th[3] = sw[2] | sw[1];
    assign th[2] = sw[2] | sw[0];
    
    // Bits constantes (según requerimiento de diseño)
    assign th[1] = 1'b0;
    assign th[0] = 1'b0;

endmodule: th_enc