module relogio_display_final (
    input logic clk_100MHz,
    input logic reset,
    input logic [5:0] segundos,
    input logic [5:0] minutos,
    input logic [5:0] horas,
    input logic [1:0] modo_ajuste,
    output logic [7:0] an,
    output logic [7:0] dec_ddp,
    output logic [7:0] leds // LEDs para indicar o modo de ajuste
);

    // Instância do display com ajuste
    relogio_display_ajuste display (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .segundos(segundos),
        .minutos(minutos),
        .horas(horas),
        .modo_ajuste(modo_ajuste),
        .an(an),
        .dec_ddp(dec_ddp)
    );
    
    // LEDs para indicar o modo de ajuste
    always_comb begin
        case (modo_ajuste)
            2'b00: leds = 8'b00000000; // Modo normal - LEDs apagados
            2'b01: leds = 8'b00000001; // Ajuste de segundos - LED0 aceso
            2'b10: leds = 8'b00000011; // Ajuste de minutos - LED0-1 acesos
            2'b11: leds = 8'b00000111; // Ajuste de horas - LED0-2 acesos
        endcase
    end

endmodule