/*
 * Autor       : José Solano
 * Módulo      : Detector de Forzado
 * Descripción : Detecta si SW >= 5 para forzar el encendido total (100% duty cycle).
 * Entradas    : sw[3:0] (Switches de entrada).
 * Salidas     : force_on (Activa el bypass del PWM).
 */

module force_det (
    input  logic [3:0] sw,
    output logic       force_on
);

    // Lógica combinacional para detectar valores mayores o iguales a 5
    assign force_on = sw[3] 
                    | (sw[2] & (sw[1] | sw[0]));

endmodule: force_det