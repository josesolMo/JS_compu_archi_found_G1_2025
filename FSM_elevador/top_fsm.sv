module top_fsm(
    input  logic       clk,
    input  logic       SW,
    output logic [9:0] LEDR,
	 output logic [6:0] HEX0,
	 output logic buzzer
);

    logic tick_3s;
	 logic tick_50ms;

    logic [2:0] state_reg;
    logic [2:0] next_state;

    logic dir_out;
    logic dir_load;

    logic op_out;
    logic op_load;

    logic [3:0] piso_destino_reg;
    logic piso_destino_load;
    logic [3:0] piso_shift;

    logic [3:0] piso_actual_reg;
    logic piso_actual_load;

    logic [2:0] cont_bits;
    logic cont_enable;
    logic cont_clear;
    logic cont_fin;

    logic [3:0] distancia_reg;
    logic [3:0] alu_resultado;
    logic alu_sat;
    logic alu_cout;

    logic led_tick;
    logic led_next;
	 
	 logic beep_1, beep_2, beep_3;
	 logic [1:0] beep_code;
	 logic start_beep;

    divisor_3s U_DIV_3 (
        .clk(clk),
        .tick_3s(tick_3s)
    );
	 
	 divisor_50ms U_DIV_1 (
        .clk(clk),
        .tick_50ms(tick_50ms)
    );

    assign cont_fin = cont_bits[2] & (~cont_bits[1]) & (~cont_bits[0]);

    assign led_next = led_tick ^ tick_3s;

    assign dir_load = tick_3s &
                      (~state_reg[2]) &
                      (~state_reg[1]) &
                      ( state_reg[0]);

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

    assign cont_enable = tick_3s &
                         (~state_reg[2]) &
                         ( state_reg[1]) &
                         (~state_reg[0]) &
                         (~cont_fin);

    assign cont_clear = tick_3s &
                        (~state_reg[2]) &
                        ( state_reg[1]) &
                        ( state_reg[0]);

    assign op_load = tick_3s &
                     (~state_reg[2]) &
                     ( state_reg[1]) &
                     ( state_reg[0]);

    assign piso_actual_load = tick_3s &
                          ( state_reg[2]) &
                          (~state_reg[1]) &
                          (~state_reg[0]) &
                          SW;
								  
	 assign beep_1 = (~state_reg[2]) & (~state_reg[1]) & (~state_reg[0]) &
                (~next_state[2]) & (~next_state[1]) & ( next_state[0]);

	 assign beep_2 = (~state_reg[2]) & (~state_reg[1]) & ( state_reg[0]) &
                (~next_state[2]) & ( next_state[1]) & (~next_state[0]);

	 assign beep_3 = ((~state_reg[2]) & ( state_reg[1]) & (~state_reg[0]) &
                 (~next_state[2]) & ( next_state[1]) & ( next_state[0])) |
                ((~state_reg[2]) & ( state_reg[1]) & ( state_reg[0]) &
                 ( next_state[2]) & (~next_state[1]) & (~next_state[0]));
					  
	 assign beep_code[1] = beep_2 | beep_3;
	 assign beep_code[0] = beep_1 | beep_3;
	 
	 assign start_beep = tick_3s & (beep_1 | beep_2 | beep_3);
	 
	 buzzer_ctrl U_BUZZ (
    .clk(clk),
    .tick(tick_50ms),
    .start(start_beep),
    .code(beep_code),
    .buzzer(buzzer)
	);

    next_state_logic U_NEXT (
        .state_reg(state_reg),
        .SW(SW),
        .cont_fin(cont_fin),
        .next_state(next_state)
    );

    estado_reg_en U_ESTADO (
        .clk(clk),
        .enable(tick_3s),
        .d(next_state),
        .q(state_reg)
    );

    dir_reg U_DIR (
        .clk(clk),
        .enable(dir_load),
        .dir_in(SW),
        .dir_out(dir_out)
    );

    dir_reg U_OP (
        .clk(clk),
        .enable(op_load),
        .dir_in(SW),
        .dir_out(op_out)
    );

    dff1 U_LED (
        .clk(clk),
        .d(led_next),
        .q(led_tick)
    );

    assign piso_shift[3] = piso_destino_reg[2];
    assign piso_shift[2] = piso_destino_reg[1];
    assign piso_shift[1] = piso_destino_reg[0];
    assign piso_shift[0] = SW;

    registro_piso U_PISO_DESTINO (
        .clk(clk),
        .enable(piso_destino_load),
        .nuevo_piso(piso_shift),
        .piso_actual(piso_destino_reg)
    );

    registro_piso U_PISO_ACTUAL (
        .clk(clk),
        .enable(piso_actual_load),
        .nuevo_piso(piso_destino_reg),
        .piso_actual(piso_actual_reg)
    );

    calc_distancia U_DIST (
        .piso_actual (piso_actual_reg),
        .piso_destino(piso_destino_reg),
        .distancia   (distancia_reg)
    );

    alu_core U_ALU (
        .piso_actual(piso_actual_reg),
        .cantidad   (distancia_reg),
        .op         (op_out),
        .resultado  (alu_resultado),
        .sat        (alu_sat),
        .c_out      (alu_cout)
    );

    contador_3bits U_CONT (
        .clk(clk),
        .enable(cont_enable),
        .clear(cont_clear),
        .q(cont_bits)
    );
	 
	 sevenseg_estado U_HEX0 (
    .state(state_reg),
    .hex(HEX0)
	 );

    assign LEDR[9] = piso_destino_reg[3];
    assign LEDR[8] = piso_destino_reg[2];
    assign LEDR[7] = piso_destino_reg[1];
    assign LEDR[6] = piso_destino_reg[0];

    assign LEDR[5] = piso_actual_reg[3];
    assign LEDR[4] = piso_actual_reg[2];
    assign LEDR[3] = piso_actual_reg[1];
    assign LEDR[2] = piso_actual_reg[0];

    assign LEDR[1] = op_out;
    assign LEDR[0] = led_tick;

endmodule