/*
 * Autor       : José Solano
 * Módulo      : Generador PWM Parametrizable
 * Descripción : Modulador por ancho de pulso que integra contador, encoder y comparador.
 * Entradas    : clk, rst_n, sw[3:0] (Control de ciclo de trabajo).
 * Salidas     : pwm (Señal modulada para el LED).
 */

module pwm_mod (
    input  logic       clk,
    input  logic       rst_n,
    input  logic [3:0] sw,
    output logic       pwm
);

    // Señales de interconexión interna
    logic [3:0] count;
    logic [3:0] th;
    logic       force_on;
    logic       cmp_lt;

    // --- Instancias de Submódulos ---

    // Contador de 4 bits
    cont4 u_cnt (
        .clk   (clk),
        .rst_n (rst_n),
        .count (count)
    );

    // Encoder de umbral basado en switches
    th_enc u_thr (
        .sw (sw),
        .th (th)
    );

    // Detector de condición "siempre encendido" (100% duty cycle)
    force_det u_frc (
        .sw       (sw),
        .force_on (force_on)
    );

    // Comparador de magnitud
    comparador4 u_cmp (
        .a  (count),
        .b  (th),
        .lt (cmp_lt)
    );

    // Lógica de salida: encendido si es menor al umbral o si se fuerza el 100%
    assign pwm = force_on | cmp_lt;

endmodule: pwm_mod