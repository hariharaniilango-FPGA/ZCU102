# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/administrator/Vivado_projects/zcu102_hello/vitis/zcu102_platform/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/administrator/Vivado_projects/zcu102_hello/vitis/zcu102_platform/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {zcu102_platform}\
-hw {/home/administrator/Vivado_projects/zcu102_hello/project_1/zynq_design_1_wrapper.xsa}\
-proc {psu_cortexa53_0} -os {standalone} -arch {64-bit} -fsbl-target {psu_cortexa53_0} -out {/home/administrator/Vivado_projects/zcu102_hello/vitis}

platform write
platform generate -domains 
platform active {zcu102_platform}
platform generate
