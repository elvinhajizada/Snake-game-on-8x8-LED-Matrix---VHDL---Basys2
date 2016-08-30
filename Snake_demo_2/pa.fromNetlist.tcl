
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name Snake_demo_1 -dir "D:/Xilinx ISE Projects/Snake_demo_1/planAhead_run_3" -part xc3s100ecp132-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/Xilinx ISE Projects/Snake_demo_1/Display.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/Xilinx ISE Projects/Snake_demo_1} }
set_property target_constrs_file "MatrixPins.ucf" [current_fileset -constrset]
add_files [list {MatrixPins.ucf}] -fileset [get_property constrset [current_run]]
link_design
