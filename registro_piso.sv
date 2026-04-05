module registro_piso (
    input  logic clk,
    input  logic reset,
    input  logic registro_en,
    input  logic SW,
    output logic [3:0] piso
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            piso <= 4'b0000;
        else if (registro_en)
            piso <= {piso[2:0], SW};
    end

endmodule