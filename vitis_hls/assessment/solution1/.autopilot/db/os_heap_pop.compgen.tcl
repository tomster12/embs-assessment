# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 15 \
    name open_set_heap_f_score_V \
    reset_level 1 \
    sync_rst true \
    dir IO \
    corename open_set_heap_f_score_V \
    op interface \
    ports { open_set_heap_f_score_V_address0 { O 15 vector } open_set_heap_f_score_V_ce0 { O 1 bit } open_set_heap_f_score_V_we0 { O 1 bit } open_set_heap_f_score_V_d0 { O 11 vector } open_set_heap_f_score_V_q0 { I 11 vector } open_set_heap_f_score_V_address1 { O 15 vector } open_set_heap_f_score_V_ce1 { O 1 bit } open_set_heap_f_score_V_we1 { O 1 bit } open_set_heap_f_score_V_d1 { O 11 vector } open_set_heap_f_score_V_q1 { I 11 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'open_set_heap_f_score_V'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 16 \
    name open_set_heap_g_score_V \
    reset_level 1 \
    sync_rst true \
    dir IO \
    corename open_set_heap_g_score_V \
    op interface \
    ports { open_set_heap_g_score_V_address0 { O 15 vector } open_set_heap_g_score_V_ce0 { O 1 bit } open_set_heap_g_score_V_we0 { O 1 bit } open_set_heap_g_score_V_d0 { O 11 vector } open_set_heap_g_score_V_q0 { I 11 vector } open_set_heap_g_score_V_address1 { O 15 vector } open_set_heap_g_score_V_ce1 { O 1 bit } open_set_heap_g_score_V_we1 { O 1 bit } open_set_heap_g_score_V_d1 { O 11 vector } open_set_heap_g_score_V_q1 { I 11 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'open_set_heap_g_score_V'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 17 \
    name open_set_heap_x_V \
    reset_level 1 \
    sync_rst true \
    dir IO \
    corename open_set_heap_x_V \
    op interface \
    ports { open_set_heap_x_V_address0 { O 15 vector } open_set_heap_x_V_ce0 { O 1 bit } open_set_heap_x_V_we0 { O 1 bit } open_set_heap_x_V_d0 { O 9 vector } open_set_heap_x_V_q0 { I 9 vector } open_set_heap_x_V_address1 { O 15 vector } open_set_heap_x_V_ce1 { O 1 bit } open_set_heap_x_V_we1 { O 1 bit } open_set_heap_x_V_d1 { O 9 vector } open_set_heap_x_V_q1 { I 9 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'open_set_heap_x_V'"
}
}


# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 18 \
    name open_set_heap_y_V \
    reset_level 1 \
    sync_rst true \
    dir IO \
    corename open_set_heap_y_V \
    op interface \
    ports { open_set_heap_y_V_address0 { O 15 vector } open_set_heap_y_V_ce0 { O 1 bit } open_set_heap_y_V_we0 { O 1 bit } open_set_heap_y_V_d0 { O 9 vector } open_set_heap_y_V_q0 { I 9 vector } open_set_heap_y_V_address1 { O 15 vector } open_set_heap_y_V_ce1 { O 1 bit } open_set_heap_y_V_we1 { O 1 bit } open_set_heap_y_V_d1 { O 9 vector } open_set_heap_y_V_q1 { I 9 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'open_set_heap_y_V'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 14 \
    name open_set_size \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_open_set_size \
    op interface \
    ports { open_set_size_i { I 16 vector } open_set_size_o { O 16 vector } open_set_size_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -2 \
    name ap_return \
    type ap_return \
    reset_level 1 \
    sync_rst true \
    corename ap_return \
    op interface \
    ports { ap_return { O 1 vector } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -4 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


