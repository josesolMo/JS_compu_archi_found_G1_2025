module bit1_reg (
    input  logic clk,
    input  logic RESET,
    input  logic bit_in,
    output logic bit_out
);

    logic next_bit;

    assign next_bit = (~RESET & bit_in);

    always_ff @(negedge clk) begin
        bit_out <= next_bit;
    end

endmodule