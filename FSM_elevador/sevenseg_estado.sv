module sevenseg_estado(
    input  logic [2:0] state,
    output logic [6:0] hex
);

    always_comb begin
        case (state)
            3'b000: hex = 7'b1000000; // 0
            3'b001: hex = 7'b1111001; // 1
            3'b010: hex = 7'b0100100; // 2
            3'b011: hex = 7'b0110000; // 3
            3'b100: hex = 7'b0011001; // 4
            default: hex = 7'b1111111; // apagado
        endcase
    end

endmodule