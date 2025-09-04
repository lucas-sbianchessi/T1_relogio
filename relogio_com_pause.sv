module relogio_com_pause (
    input logic clk_100MHz,
    input logic rstn,
    input logic pause,
    input logic load,
    input logic [5:0] load_segundos,
    input logic [5:0] load_minutos,
    input logic [5:0] load_horas,
    output logic [5:0] segundos,
    output logic [5:0] minutos,
    output logic [5:0] horas
);

    always_ff @(posedge clk_100MHz or negedge rstn) begin
        if (!rstn) begin
            segundos <= 0;
            minutos <= 0;
            horas <= 0;
        end else if (load) begin
            segundos <= load_segundos;
            minutos <= load_minutos;
            horas <= load_horas;
        end else if (!pause) begin
            // Lógica de incremento do relógio
            if (segundos == 59) begin
                segundos <= 0;
                if (minutos == 59) begin
                    minutos <= 0;
                    if (horas == 23) begin
                        horas <= 0;
                    end else begin
                        horas <= horas + 1;
                    end
                end else begin
                    minutos <= minutos + 1;
                end
            end else begin
                segundos <= segundos + 1;
            end
        end
    end

endmodule