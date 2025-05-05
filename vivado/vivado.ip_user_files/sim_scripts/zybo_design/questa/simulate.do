onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib zybo_design_opt

do {wave.do}

view wave
view structure
view signals

do {zybo_design.udo}

run -all

quit -force
