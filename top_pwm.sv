/*
 * Autor       : José Solano
 * Módulo      : Control PWM y Visualización HEX
 * Descripción : Modula la intensidad de LEDR[0] y muestra el valor de SW[3:0] en HEX0.
 * Entradas    : CLOCK_50 (50MHz), KEY0 (rst_n), SW[3:0] (Control/Datos).
 * Salidas     : LEDR0 (Señal PWM), HEX0 (7-Segmentos).
 */
module top_pwm (
    input  logic        CLOCK_50, // Reloj de 50 MHz
    input  logic        KEY0,     // Reset (activo bajo)
    input  logic [3:0]  SW,       // Pisos restantes
    output logic        LEDR0,    // Señal PWM → LED
    output logic [6:0]  HEX0      // Display 7 segmentos (activo bajo)
);

    // --- Instancia del Módulo PWM ---
    // Controla la intensidad del LEDR[0] basado en los switches
    pwm_mod u_pwm (
        .clk   (CLOCK_50),
        .rst_n (KEY0),
        .sw    (SW),
        .pwm   (LEDR0)
    );

    // --- Instancia del Decodificador de 7 Segmentos ---
    // Muestra el valor binario de los switches en el display HEX0
    hex_dec u_hex (
        .sw      (SW),
        .hex_seg (HEX0)
    );

endmodule: top_pwm