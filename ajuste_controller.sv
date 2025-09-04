module ajuste_controller (
    input logic clk_100MHz,
    input logic rstn,
    input logic btn_mode,
    input logic btn_inc,
    input logic btn_dec,
    input logic [5:0] segundos_in,
    input logic [5:0] minutos_in,
    input logic [5:0] horas_in,
    output logic pause,
    output logic load,
    output logic [1:0] modo_ajuste,
    output logic [5:0] segundos_out,
    output logic [5:0] minutos_out,
    output logic [5:0] horas_out
);

    // Estados
    typedef enum logic [1:0] {
        NORMAL = 2'b00,
        AJUSTE_SEG = 2'b01,
        AJUSTE_MIN = 2'b10,
        AJUSTE_HORA = 2'b11
    } estado_t;
    
    estado_t estado, next_estado;
    
    // Registros para detecção de borda
    logic btn_mode_prev, btn_inc_prev, btn_dec_prev;
    logic mode_rising, inc_rising, dec_rising;
    
    // Detecção de borda dos botões
    always_ff @(posedge clk_100MHz or negedge rstn) begin
        if (!rstn) begin
            btn_mode_prev <= 0;
            btn_inc_prev <= 0;
            btn_dec_prev <= 0;
        end else begin
            btn_mode_prev <= btn_mode;
            btn_inc_prev <= btn_inc;
            btn_dec_prev <= btn_dec;
        end
    end
    
    assign mode_rising = btn_mode && !btn_mode_prev;
    assign inc_rising = btn_inc && !btn_inc_prev;
    assign dec_rising = btn_dec && !btn_dec_prev;
    
    // Registro de estado
    always_ff @(posedge clk_100MHz or negedge rstn) begin
        if (!rstn) begin
            estado <= NORMAL;
        end else begin
            estado <= next_estado;
        end
    end
    
    // Lógica de próximo estado
    always_comb begin
        next_estado = estado;
        case (estado)
            NORMAL: if (mode_rising) next_estado = AJUSTE_SEG;
            AJUSTE_SEG: if (mode_rising) next_estado = AJUSTE_MIN;
            AJUSTE_MIN: if (mode_rising) next_estado = AJUSTE_HORA;
            AJUSTE_HORA: if (mode_rising) next_estado = NORMAL;
        endcase
    end
    
    // Registradores de valores ajustados
    always_ff @(posedge clk_100MHz or negedge rstn) begin
        if (!rstn) begin
            segundos_out <= 0;
            minutos_out <= 0;
            horas_out <= 0;
        end else begin
            if (estado == NORMAL) begin
                segundos_out <= segundos_in;
                minutos_out <= minutos_in;
                horas_out <= horas_in;
            end else begin
                if (inc_rising) begin
                    case (estado)
                        AJUSTE_SEG: segundos_out <= (segundos_out == 59) ? 0 : segundos_out + 1;
                        AJUSTE_MIN: minutos_out <= (minutos_out == 59) ? 0 : minutos_out + 1;
                        AJUSTE_HORA: horas_out <= (horas_out == 23) ? 0 : horas_out + 1;
                    endcase
                end else if (dec_rising) begin
                    case (estado)
                        AJUSTE_SEG: segundos_out <= (segundos_out == 0) ? 59 : segundos_out - 1;
                        AJUSTE_MIN: minutos_out <= (minutos_out == 0) ? 59 : minutos_out - 1;
                        AJUSTE_HORA: horas_out <= (horas_out == 0) ? 23 : horas_out - 1;
                    endcase
                end
            end
        end
    end
    
    // Sinais de controle
    assign pause = (estado != NORMAL);
    assign load = (estado == AJUSTE_HORA && next_estado == NORMAL);
    assign modo_ajuste = estado;

endmodule