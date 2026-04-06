/*
 * Autor       : José Solano
 * Módulo      : Decodificador Hexadecimal
 * Descripción : Convierte binario de 4 bits a 7-segmentos (Ánodo Común).
 * Entradas    : bin[3:0] (Valor de 0 a F).
 * Salidas     : seg[6:0] (Patrón para encender segmentos g-f-e-d-c-b-a).
 */

module hex_dec (
    input  logic [3:0] bin,
    output logic [6:0] seg
);

    always_comb begin
        case (bin)
            4'h0: seg = 7'b1000000;
            4'h1: seg = 7'b1111001;
            4'h2: seg = 7'b0100100;
            4'h3: seg = 7'b0110000;
            4'h4: seg = 7'b0011001;
            4'h5: seg = 7'b0010010;
            4'h6: seg = 7'b0000010;
            4'h7: seg = 7'b1111000;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0010000;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b0000011;
            4'hC: seg = 7'b1000110;
            4'hD: seg = 7'b0100001;
            4'hE: seg = 7'b0000110;
            4'hF: seg = 7'b0001110;
            default: seg = 7'b1111111; // Apagado
        endcase
    end
    
endmodule: hex_dec