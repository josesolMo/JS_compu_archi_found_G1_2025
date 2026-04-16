module fsm_movimiento (
    input  logic clk,
    input  logic iniciar_viaje, // I
    input  logic dist_0,        // z
    output logic en_pwm,   
    output logic en_rest,  
    output logic stopped   
);

    // Cables internos para el estado y sus complementos
    logic q1, q0;  // Estado Actual
    logic d1, d0;  // Próximo Estado
    logic n_q1, n_q0;
	 
	 logic d1_and1, d1_and2;
    logic d0_and1, d0_and2;

    // Compuertas NOT
    not (n_q1, q1);
    not (n_q0, q0);

    // LÓGICA DE PRÓXIMO ESTADO (Compuertas)
    
    // Ecuación para D1: (~Q1 & Q0) | (Q1 & ~Q0 & Z)
    and (d1_and1, n_q1, q0);
    and (d1_and2, q1, n_q0, dist_0);
    or  (d1, d1_and1, d1_and2);

    // Ecuación para D0: (~Q1 & ~Q0 & I) | (Q1 & ~Q0)
    and (d0_and1, n_q1, n_q0, iniciar_viaje);
    and (d0_and2, q1, n_q0);
    or  (d0, d0_and1, d0_and2);


    // Instanciación de FF - Memoria de estado
    dff1 ff1 (
        .clk (clk), 
        .d   (d1), 
        .q   (q1)
    );
    
    dff1 ff0 (
        .clk (clk), 
        .d   (d0), 
        .q   (q0)
    );


    // LÓGICA DE SALIDAS (Compuertas)
    
    // en_pwm se activa en S1(01) y S2(10) -> XOR
    xor (en_pwm, q1, q0);

    // en_rest se activa en S1(01) -> AND
    and (en_rest, n_q1, q0);

    // stopped se activa en S0(00) y S3(11) -> XNOR
    xnor (stopped, q1, q0);

endmodule