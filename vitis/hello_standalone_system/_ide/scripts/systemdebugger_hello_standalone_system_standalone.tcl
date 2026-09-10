# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/administrator/Vivado_projects/zcu102_hello/vitis/hello_standalone_system/_ide/scripts/systemdebugger_hello_standalone_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/administrator/Vivado_projects/zcu102_hello/vitis/hello_standalone_system/_ide/scripts/systemdebugger_hello_standalone_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
source /tools/Xilinx/Vitis/2022.2/scripts/vitis/util/zynqmp_utils.tcl
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent JTAG-SMT2NC 210308BECC15" && level==0 && jtag_device_ctx=="jsn-JTAG-SMT2NC-210308BECC15-24738093-0"}
fpga -file /home/administrator/Vivado_projects/zcu102_hello/vitis/hello_standalone/_ide/bitstream/zynq_design_1_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/administrator/Vivado_projects/zcu102_hello/vitis/zcu102_platform/export/zcu102_platform/hw/zynq_design_1_wrapper.xsa -mem-ranges [list {0x80000000 0xbfffffff} {0x400000000 0x5ffffffff} {0x1000000000 0x7fffffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
set mode [expr [mrd -value 0xFF5E0200] & 0xf]
targets -set -nocase -filter {name =~ "*A53*#0"}
rst -processor
dow /home/administrator/Vivado_projects/zcu102_hello/vitis/zcu102_platform/export/zcu102_platform/sw/zcu102_platform/boot/fsbl.elf
set bp_12_27_fsbl_bp [bpadd -addr &XFsbl_Exit]
con -block -timeout 60
bpremove $bp_12_27_fsbl_bp
targets -set -nocase -filter {name =~ "*A53*#0"}
rst -processor
dow /home/administrator/Vivado_projects/zcu102_hello/vitis/hello_standalone/Debug/hello_standalone.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A53*#0"}
con
