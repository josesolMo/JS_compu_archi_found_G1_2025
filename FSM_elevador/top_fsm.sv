module top_fsm (
    input  logic clk,
    input  logic CLAP_MIC,
    output logic [9:0] LEDR,
    output logic [6:0] HEX0,
    output logic [6:0] HEX1,
    output logic buzzer,
    output logic dir_arriba,
    output logic dir_abajo,
    output logic pwm_motor
);
	 
	 // Pulsos de divisores de frecuencia
    logic tick_3s;
    logic tick_50ms;
	 logic tick_10khz;
	 
	 // Registro de estado actual y siguiente de la FSM
    logic [2:0] state_reg;
    logic [2:0] next_state;
	 
	 // Registro de dirección seleccionada y enable del registro
    logic dir_out;
    logic dir_load;
	 
	 // Registro de operador seleccionado y enable del registro
    logic op_out;
    logic op_load;
	 
	 // Registro de piso destino, enabledel registro, y corrimiento del piso
    logic [3:0] piso_destino_reg;
    logic piso_destino_load;
    logic [3:0] piso_shift;
	 
	 // Registro del piso actual y enable del registro
    logic [3:0] piso_actual_reg;
    logic piso_actual_load;
	 
	 // Contador de bits para registro de corrimiento, enable del contador, clear del contador
    logic [2:0] cont_bits;
    logic cont_enable;
    logic cont_clear;
    logic cont_fin; // Flag que indica cuando el se registran 4 bits
	 
	 // Registro de la distanca entre los pisos
    logic [3:0] distancia_reg;
    logic [3:0] alu_resultado; // Resultado de operación de la ALU
    logic alu_sat;
    logic alu_cout;
	 
	 // Registros del piso actual y destino para la ALU, dependen de alu_enable
    logic [3:0] piso_actual_alu;
    logic [3:0] piso_destino_alu;
    logic alu_enable; // Enable de la ALU
	 
	 // Indicadores de tick del reloj
    logic led_tick;
    logic led_next;
	 
	 // Señales para beep del buzzer
    logic beep_1, beep_2, beep_3; 
    logic [1:0] beep_code; // Almacena el código correspondiente a la cantidad de beeps
    logic start_beep; // Enable de beep

    // Señales para FSM Moviminento, PWM y calculo dinamico
    logic piso_destino_ready; // flag de piso listo
    logic iniciar_viaje; // flag de distancia lista para iniciar movimiento

    logic en_pwm; // Habilita PWM
    logic en_rest; // Habilita paso/resta
    logic stopped = 1'b1; // flag de en movimiento, pausa la obtención de pisos en bajo
    logic dist_0; // Señal que comprueba si distancia es 0
    logic internal_pwm; // Señal PWM para el motor
    logic [3:0] piso_dyn; // Piso actual en tiempo real
    logic [3:0] dist_dyn; // Distancia actual en tiempo real
	 
	 // Señales para detección del micrófono
    logic mic_d; 
    logic pulse;
    logic clap;
    logic clap_next;
	 
    assign piso_destino_ready = (~state_reg[2]) & ( state_reg[1]) & ( state_reg[0]); // Flag que indica que el registro exitoso del piso destino
    assign iniciar_viaje = (state_reg[2]) & (~state_reg[1]) & (~state_reg[0]); // Flag que indica el movimiento entre pisos

    assign cont_fin = cont_bits[2] & (~cont_bits[1]) & (~cont_bits[0]); // Flag que indica el final para el contador en el registro del piso

    assign alu_enable = (state_reg[2]) & (~state_reg[1]) & (~state_reg[0]); // Señal que permite que la ALU solo opere en el estado 100
	 
	 // Uso de flag alu_enable 
    assign piso_actual_alu[3] = alu_enable & piso_actual_reg[3];
    assign piso_actual_alu[2] = alu_enable & piso_actual_reg[2];
    assign piso_actual_alu[1] = alu_enable & piso_actual_reg[1];
    assign piso_actual_alu[0] = alu_enable & piso_actual_reg[0];

    assign piso_destino_alu[3] = alu_enable & piso_destino_reg[3];
    assign piso_destino_alu[2] = alu_enable & piso_destino_reg[2];
    assign piso_destino_alu[1] = alu_enable & piso_destino_reg[1];
    assign piso_destino_alu[0] = alu_enable & piso_destino_reg[0];
	 
	 // Siguiente valor del tick del reloj
    assign led_next = led_tick ^ tick_3s;
	 
	 // Asigna pulso detectado por el micrófono, y el siguiente valor
    assign pulse = CLAP_MIC & ~mic_d;
    assign clap_next = pulse | (clap & ~tick_3s);
	 
	 // Condición para enable el registro de dirección en estado 001
    assign dir_load = tick_3s &
                      (~state_reg[2]) &
                      (~state_reg[1]) &
                      ( state_reg[0]);
	 
	 // Condición del enable para el registro del piso destino en estado 010
    assign piso_destino_load = tick_3s &
                               (~state_reg[2]) &
                               ( state_reg[1]) &
                               (~state_reg[0]) &
                               (
                                   ((~cont_bits[2]) & (~cont_bits[1]) & ( cont_bits[0])) |
                                   ((~cont_bits[2]) & ( cont_bits[1]) & (~cont_bits[0])) |
                                   ((~cont_bits[2]) & ( cont_bits[1]) & ( cont_bits[0])) |
                                   (( cont_bits[2]) & (~cont_bits[1]) & (~cont_bits[0]))
                               );
	 
	 // Condición del enable para el contador
    assign cont_enable = tick_3s &
                         (~state_reg[2]) &
                         ( state_reg[1]) &
                         (~state_reg[0]) &
                         (~cont_fin);
	 
	 // Condición del clear del contador en estado 011
    assign cont_clear = tick_3s &
                        (~state_reg[2]) &
                        ( state_reg[1]) &
                        ( state_reg[0]);
	 
	 // Condición para enable del registro de la operación en estado 011
    assign op_load = tick_3s &
                     (~state_reg[2]) &
                     ( state_reg[1]) &
                     ( state_reg[0]);
	 
	 // Condición para actualizar el piso actual
    assign piso_actual_load = tick_3s &
                              (~state_reg[2]) &
                              (~state_reg[1]) &
                              (~state_reg[0]);
	 
	 // Condición para 1 beep, entre estado 000 y 001
    assign beep_1 = (~state_reg[2]) & (~state_reg[1]) & (~state_reg[0]) &
                    (~next_state[2]) & (~next_state[1]) & ( next_state[0]);
	 
	 // Condición para 2 beeps, entre estado 001 y 010
    assign beep_2 = (~state_reg[2]) & (~state_reg[1]) & ( state_reg[0]) &
                    (~next_state[2]) & ( next_state[1]) & (~next_state[0]);
	 
	 // Condición para 3 beeps, entre estado 010 y 011 y 100
    assign beep_3 = ((~state_reg[2]) & ( state_reg[1]) & (~state_reg[0]) &
                     (~next_state[2]) & ( next_state[1]) & ( next_state[0])) |
                    ((~state_reg[2]) & ( state_reg[1]) & ( state_reg[0]) &
                     ( next_state[2]) & (~next_state[1]) & (~next_state[0]));
	 
	 // Condición para código de beep
    assign beep_code[1] = beep_2 | beep_3;
    assign beep_code[0] = beep_1 | beep_3;
	 
	 // Condición para iniciar beeps
    assign start_beep = tick_3s & (beep_1 | beep_2 | beep_3);
	 
	 // Asignación de valores para el registro de corrimiento del piso destino
    assign piso_shift[3] = piso_destino_reg[2];
    assign piso_shift[2] = piso_destino_reg[1];
    assign piso_shift[1] = piso_destino_reg[0];
    assign piso_shift[0] = clap;

    assign LEDR[9] = piso_destino_reg[3];
    assign LEDR[8] = piso_destino_reg[2];
    assign LEDR[7] = piso_destino_reg[1];
    assign LEDR[6] = piso_destino_reg[0];

    assign LEDR[5] = piso_actual_reg[3];
    assign LEDR[4] = piso_actual_reg[2];
    assign LEDR[3] = piso_actual_reg[1];
    assign LEDR[2] = piso_actual_reg[0];

    assign LEDR[1] = state_reg[2] & (~state_reg[1]) & (~state_reg[0]);
    assign LEDR[0] = led_tick;
	 
	 // Asigna salidas para la dirección del motor
    assign dir_arriba = dir_out;
    assign dir_abajo  = (~dir_out);

    // LOGICA FSM Moviminento, PWM y calculo dinamico

    // El PWM solo sale al motor si la MEF activa 'en_pwm'
    and g2 (pwm_motor, internal_pwm, en_pwm);

    // Detector de Cero (NOR de 4 entradas): dist_0 es 1 solo si todos los bits son 0
    nor g3 (dist_0, dist_dyn[0], dist_dyn[1], dist_dyn[2], dist_dyn[3]);

    divisor_3s U_DIV_3 (
        .clk (clk),
        .tick_3s (tick_3s)
    );

    divisor_50ms U_DIV_1 (
        .clk (clk),
        .tick_50ms(tick_50ms)
    );
	 
	 divisor_10khz (
		  .clk (clk),
		  .tick_10khz(tick_10khz)
	 );

    dff1 U_MIC_DELAY (
        .clk (clk),
        .d   (CLAP_MIC),
        .q   (mic_d)
    );

    dff1 U_CLAP (
        .clk (clk),
        .d   (clap_next),
        .q   (clap)
    );

    next_state_logic U_NEXT (
        .state_reg  (state_reg),
        .SW         (clap),
        .cont_fin   (cont_fin),
		  .dist_0    (dist_0),
        .next_state (next_state)
    );

    estado_reg_en U_ESTADO (
        .clk    (clk),
        .enable (tick_3s),
        .d      (next_state),
        .q      (state_reg)
    );

    dir_reg U_DIR (
        .clk     (clk),
        .enable  (dir_load),
        .dir_in  (clap),
        .dir_out (dir_out)
    );

    dir_reg U_OP (
        .clk     (clk),
        .enable  (op_load),
        .dir_in  (clap),
        .dir_out (op_out)
    );

    dff1 U_LED (
        .clk (clk),
        .d   (led_next),
        .q   (led_tick)
    );

    registro_piso U_PISO_DESTINO (
        .clk        (clk),
        .enable     (piso_destino_load),
        .nuevo_piso (piso_shift),
        .piso_actual(piso_destino_reg)
    );

    registro_piso U_PISO_ACTUAL (
        .clk        (clk),
        .enable     (piso_actual_load),
        .nuevo_piso (piso_destino_reg),
        .piso_actual(piso_actual_reg)
    );

    calc_distancia U_DIST (
        .piso_actual  (piso_actual_reg),
        .piso_destino (piso_destino_reg),
        .distancia    (distancia_reg)
    );

    alu_core U_ALU (
        .piso_actual (piso_actual_alu),
        .cantidad    (distancia_reg),
        .op          (op_out),
        .resultado   (alu_resultado),
        .sat         (alu_sat),
        .c_out       (alu_cout)
    );

    contador_3bits U_CONT (
        .clk    (clk),
        .enable (cont_enable),
        .clear  (cont_clear),
        .q      (cont_bits)
    );

    buzzer_ctrl U_BUZZ (
        .clk    (clk),
        .tick   (tick_50ms),
        .start  (start_beep),
        .code   (beep_code),
        .buzzer (buzzer)
    );

    fsm_movimiento u_fsm (
        .clk           (tick_3s),
        .iniciar_viaje (iniciar_viaje),
        .dist_0        (dist_0),
        .en_pwm        (en_pwm),
        .en_rest       (en_rest),
        .stopped       (stopped)
    );

    pwm_mod u_pwm (
        .clk (tick_10khz),
        .sw  (dist_dyn), // Intensidad basada en distancia restante
        .pwm (internal_pwm)
    );

    calculo_dinamico u_core (
        .clk       (tick_3s),
        .load      (stopped),          // Carga valores iniciales en S0/S3
        .en_step   (en_rest),          // Ejecuta un paso de movimiento desde S1
        .dir       (dir_out),          // Dirección para saber si sumar o restar al piso
        .p_dest_in (piso_destino_reg),
        .p_act_in  (piso_actual_reg),
        .dist_in   (distancia_reg),
        .p_act_out (piso_dyn),         // Salida hacia el HEX
        .dist_out  (dist_dyn)          // Salida hacia el PWM y comparador dist_0
    );

    hex_dec u_hex0 (
        .bin (state_reg),
        .seg (HEX0)
    );

    hex_dec u_hex1 (
        .bin (piso_dyn),
        .seg (HEX1)
    );

	 /*
    hex_dec u_hex2 (
        .bin (piso_actual_reg),
        .seg (HEX2)
    );

    hex_dec u_hex3 (
        .bin (piso_destino_reg),
        .seg (HEX3)
    );

    hex_dec u_hex4 (
        .bin (distancia_reg),
        .seg (HEX4)
    );

    hex_dec u_hex5 (
        .bin (dist_dyn),
        .seg (HEX5)
    );
	*/
endmodule