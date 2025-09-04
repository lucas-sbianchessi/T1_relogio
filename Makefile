TOP = relogio_top_debounced_tb

VERILOG_BASE = .

VERILOG_SRC = \
    $(VERILOG_BASE)/clock_divider_fixed.sv \
    $(VERILOG_BASE)/bin_to_bcd.sv \
    $(VERILOG_BASE)/relogio_com_pause.sv \
    $(VERILOG_BASE)/ajuste_controller.sv \
    $(VERILOG_BASE)/blink_500ms.sv \
    $(VERILOG_BASE)/debounce.v \
    $(VERILOG_BASE)/edge_detector.sv \
    $(VERILOG_BASE)/relogio_top_ajuste.sv \
    $(VERILOG_BASE)/relogio_top_debounced.sv \
    $(VERILOG_BASE)/relogio_display_ajuste.sv \
    $(VERILOG_BASE)/dspl_drv_NexysA7.v \
    $(VERILOG_BASE)/relogio_top_debounced_tb.sv
    
TIME = 10ms

all: modelsim-top

# Command line simulation using ModelSim
modelsim:
	vlib mylib
	vmap work ./mylib
	vlog -work mylib -sv $(VERILOG_SRC)

modelsim-top: modelsim
	vsim $(GUI) mylib.$(TOP) -voptargs=+acc -c -do "vcd file ${TOP}.vcd -compress; vcd add /*; run ${TIME}; quit"
	
modelsim-all: modelsim
	vsim $(GUI) mylib.$(TOP) -voptargs=+acc -c -do "vcd file ${TOP}.vcd -compress; vcd add -r /*; run ${TIME}; quit"

modelsim-wave: modelsim
	vsim $(GUI) mylib.$(TOP) -voptargs=+acc -do "add wave -r /*; run ${TIME};"

# Command line simulation using Icarus Verilog 
iverilog:
	iverilog -g2012 -s $(TOP) $(VERILOG_SRC) -o $(TOP)
	
iverilog-vcd: iverilog
	vvp $(TOP) -lxt2

# Display waveforms
wave-vcd:
	@if [ -f "$(TOP).vcd" ]; then \
		gtkwave $(TOP).vcd --rcvar 'fontname_signals Monospace 12' --rcvar 'fontname_waves Monospace 12'; \
	else \
		gtkwave $(TOP).vcd.gz --rcvar 'fontname_signals Monospace 12' --rcvar 'fontname_waves Monospace 12'; \
	fi

# Clean all generated files
clean:
	@ rm -rf simu work mylib
	@ rm -f $(TOP)
	@ rm -f $(TOP).vcd.gz
	@ rm -f $(TOP).vcd $(TOP).ghw
	@ rm -f *.txt *.ini *.vsim transcript *.out