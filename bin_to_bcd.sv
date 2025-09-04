module bin_to_bcd (
    input  logic [5:0] bin,
    output logic [3:0] dezena,
    output logic [3:0] unidade
);

    always_comb begin
        dezena = bin / 10;
        unidade = bin % 10;
    end

endmodule