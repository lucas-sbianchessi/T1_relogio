module relogio_top_debounced_tb;

    logic clk_100MHz;
    logic rstn;
    logic btn_mode_raw, btn_inc_raw, btn_dec_raw;
    logic [5:0] segundos, minutos, horas;
    logic [1:0] modo_ajuste;
    
    // Instância do relógio com debounce
    relogio_top_debounced dut (
        .clk_100MHz(clk_100MHz),
        .rstn(rstn),
        .btn_mode_raw(btn_mode_raw),
        .btn_inc_raw(btn_inc_raw),
        .btn_dec_raw(btn_dec_raw),
        .segundos(segundos),
        .minutos(minutos),
        .horas(horas),
        .modo_ajuste(modo_ajuste)
    );
    
    // Geração de clock
    always #5 clk_100MHz = ~clk_100MHz;
    
    // Teste
    initial begin
        // Inicialização
        clk_100MHz = 0;
        rstn = 0;
        btn_mode_raw = 0;
        btn_inc_raw = 0;
        btn_dec_raw = 0;
        
        // Reset
        #100 rstn = 1;
        
        // Simula pressionamento do botão mode
        #1000000 btn_mode_raw = 1;
        #1000000 btn_mode_raw = 0;
        
        // Simula incremento de segundos
        #1000000 btn_inc_raw = 1;
        #1000000 btn_inc_raw = 0;
        
        // Simula pressionamento do botão mode novamente
        #1000000 btn_mode_raw = 1;
        #1000000 btn_mode_raw = 0;
        
        // Simula várias operações
        repeat (10) begin
            #1000000 btn_inc_raw = 1;
            #1000000 btn_inc_raw = 0;
        end
        
        // Finaliza simulação
        #10000000 $finish;
    end
    
    // Monitoramento
    initial begin
        $monitor("T=%0t Modo=%0d H:%0d M:%0d S:%0d", 
                 $time, modo_ajuste, horas, minutos, segundos);
    end

endmodule