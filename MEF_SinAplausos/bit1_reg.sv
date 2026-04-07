module bit1_reg (
    input  logic clk,
    input  logic bit_in,
    output logic bit_out
);
    always @(posedge clk)
        bit_out <= bit_in;
endmodule