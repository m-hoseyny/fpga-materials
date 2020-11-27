# TCL File Generated by Component Editor 13.0sp1
# Thu Dec 01 13:42:37 IRST 2016
# DO NOT MODIFY


# 
# FIR "FIR" v1.0
#  2016.12.01.13:42:37
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module FIR
# 
set_module_property DESCRIPTION ""
set_module_property NAME FIR
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME FIR
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL filter_serial
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file filter_serial.v VERILOG PATH filter_serial.v TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter coeff1 INTEGER 15822929
set_parameter_property coeff1 DEFAULT_VALUE 15822929
set_parameter_property coeff1 DISPLAY_NAME coeff1
set_parameter_property coeff1 TYPE INTEGER
set_parameter_property coeff1 UNITS None
set_parameter_property coeff1 HDL_PARAMETER true
add_parameter coeff2 INTEGER 12589485
set_parameter_property coeff2 DEFAULT_VALUE 12589485
set_parameter_property coeff2 DISPLAY_NAME coeff2
set_parameter_property coeff2 TYPE INTEGER
set_parameter_property coeff2 UNITS None
set_parameter_property coeff2 HDL_PARAMETER true
add_parameter coeff3 INTEGER -7110558
set_parameter_property coeff3 DEFAULT_VALUE -7110558
set_parameter_property coeff3 DISPLAY_NAME coeff3
set_parameter_property coeff3 TYPE INTEGER
set_parameter_property coeff3 UNITS None
set_parameter_property coeff3 HDL_PARAMETER true
add_parameter coeff4 INTEGER -40655304
set_parameter_property coeff4 DEFAULT_VALUE -40655304
set_parameter_property coeff4 DISPLAY_NAME coeff4
set_parameter_property coeff4 TYPE INTEGER
set_parameter_property coeff4 UNITS None
set_parameter_property coeff4 HDL_PARAMETER true
add_parameter coeff5 INTEGER -63260525
set_parameter_property coeff5 DEFAULT_VALUE -63260525
set_parameter_property coeff5 DISPLAY_NAME coeff5
set_parameter_property coeff5 TYPE INTEGER
set_parameter_property coeff5 UNITS None
set_parameter_property coeff5 HDL_PARAMETER true
add_parameter coeff6 INTEGER -51726249
set_parameter_property coeff6 DEFAULT_VALUE -51726249
set_parameter_property coeff6 DISPLAY_NAME coeff6
set_parameter_property coeff6 TYPE INTEGER
set_parameter_property coeff6 UNITS None
set_parameter_property coeff6 HDL_PARAMETER true
add_parameter coeff7 INTEGER -10373828
set_parameter_property coeff7 DEFAULT_VALUE -10373828
set_parameter_property coeff7 DISPLAY_NAME coeff7
set_parameter_property coeff7 TYPE INTEGER
set_parameter_property coeff7 UNITS None
set_parameter_property coeff7 HDL_PARAMETER true
add_parameter coeff8 INTEGER 26417904
set_parameter_property coeff8 DEFAULT_VALUE 26417904
set_parameter_property coeff8 DISPLAY_NAME coeff8
set_parameter_property coeff8 TYPE INTEGER
set_parameter_property coeff8 UNITS None
set_parameter_property coeff8 HDL_PARAMETER true
add_parameter coeff9 INTEGER 24630279
set_parameter_property coeff9 DEFAULT_VALUE 24630279
set_parameter_property coeff9 DISPLAY_NAME coeff9
set_parameter_property coeff9 TYPE INTEGER
set_parameter_property coeff9 UNITS None
set_parameter_property coeff9 HDL_PARAMETER true
add_parameter coeff10 INTEGER -12828998
set_parameter_property coeff10 DEFAULT_VALUE -12828998
set_parameter_property coeff10 DISPLAY_NAME coeff10
set_parameter_property coeff10 TYPE INTEGER
set_parameter_property coeff10 UNITS None
set_parameter_property coeff10 HDL_PARAMETER true
add_parameter coeff11 INTEGER -44017600
set_parameter_property coeff11 DEFAULT_VALUE -44017600
set_parameter_property coeff11 DISPLAY_NAME coeff11
set_parameter_property coeff11 TYPE INTEGER
set_parameter_property coeff11 UNITS None
set_parameter_property coeff11 HDL_PARAMETER true
add_parameter coeff12 INTEGER -29678515
set_parameter_property coeff12 DEFAULT_VALUE -29678515
set_parameter_property coeff12 DISPLAY_NAME coeff12
set_parameter_property coeff12 TYPE INTEGER
set_parameter_property coeff12 UNITS None
set_parameter_property coeff12 HDL_PARAMETER true
add_parameter coeff13 INTEGER 21303396
set_parameter_property coeff13 DEFAULT_VALUE 21303396
set_parameter_property coeff13 DISPLAY_NAME coeff13
set_parameter_property coeff13 TYPE INTEGER
set_parameter_property coeff13 UNITS None
set_parameter_property coeff13 HDL_PARAMETER true
add_parameter coeff14 INTEGER 54805925
set_parameter_property coeff14 DEFAULT_VALUE 54805925
set_parameter_property coeff14 DISPLAY_NAME coeff14
set_parameter_property coeff14 TYPE INTEGER
set_parameter_property coeff14 UNITS None
set_parameter_property coeff14 HDL_PARAMETER true
add_parameter coeff15 INTEGER 27893350
set_parameter_property coeff15 DEFAULT_VALUE 27893350
set_parameter_property coeff15 DISPLAY_NAME coeff15
set_parameter_property coeff15 TYPE INTEGER
set_parameter_property coeff15 UNITS None
set_parameter_property coeff15 HDL_PARAMETER true
add_parameter coeff16 INTEGER -38044016
set_parameter_property coeff16 DEFAULT_VALUE -38044016
set_parameter_property coeff16 DISPLAY_NAME coeff16
set_parameter_property coeff16 TYPE INTEGER
set_parameter_property coeff16 UNITS None
set_parameter_property coeff16 HDL_PARAMETER true
add_parameter coeff17 INTEGER -70907552
set_parameter_property coeff17 DEFAULT_VALUE -70907552
set_parameter_property coeff17 DISPLAY_NAME coeff17
set_parameter_property coeff17 TYPE INTEGER
set_parameter_property coeff17 UNITS None
set_parameter_property coeff17 HDL_PARAMETER true
add_parameter coeff18 INTEGER -24445856
set_parameter_property coeff18 DEFAULT_VALUE -24445856
set_parameter_property coeff18 DISPLAY_NAME coeff18
set_parameter_property coeff18 TYPE INTEGER
set_parameter_property coeff18 UNITS None
set_parameter_property coeff18 HDL_PARAMETER true
add_parameter coeff19 INTEGER 61311250
set_parameter_property coeff19 DEFAULT_VALUE 61311250
set_parameter_property coeff19 DISPLAY_NAME coeff19
set_parameter_property coeff19 TYPE INTEGER
set_parameter_property coeff19 UNITS None
set_parameter_property coeff19 HDL_PARAMETER true
add_parameter coeff20 INTEGER 90601381
set_parameter_property coeff20 DEFAULT_VALUE 90601381
set_parameter_property coeff20 DISPLAY_NAME coeff20
set_parameter_property coeff20 TYPE INTEGER
set_parameter_property coeff20 UNITS None
set_parameter_property coeff20 HDL_PARAMETER true
add_parameter coeff21 INTEGER 15237669
set_parameter_property coeff21 DEFAULT_VALUE 15237669
set_parameter_property coeff21 DISPLAY_NAME coeff21
set_parameter_property coeff21 TYPE INTEGER
set_parameter_property coeff21 UNITS None
set_parameter_property coeff21 HDL_PARAMETER true
add_parameter coeff22 INTEGER -96996745
set_parameter_property coeff22 DEFAULT_VALUE -96996745
set_parameter_property coeff22 DISPLAY_NAME coeff22
set_parameter_property coeff22 TYPE INTEGER
set_parameter_property coeff22 UNITS None
set_parameter_property coeff22 HDL_PARAMETER true
add_parameter coeff23 INTEGER -117212395
set_parameter_property coeff23 DEFAULT_VALUE -117212395
set_parameter_property coeff23 DISPLAY_NAME coeff23
set_parameter_property coeff23 TYPE INTEGER
set_parameter_property coeff23 UNITS None
set_parameter_property coeff23 HDL_PARAMETER true
add_parameter coeff24 INTEGER 4251772
set_parameter_property coeff24 DEFAULT_VALUE 4251772
set_parameter_property coeff24 DISPLAY_NAME coeff24
set_parameter_property coeff24 TYPE INTEGER
set_parameter_property coeff24 UNITS None
set_parameter_property coeff24 HDL_PARAMETER true
add_parameter coeff25 INTEGER 157290652
set_parameter_property coeff25 DEFAULT_VALUE 157290652
set_parameter_property coeff25 DISPLAY_NAME coeff25
set_parameter_property coeff25 TYPE INTEGER
set_parameter_property coeff25 UNITS None
set_parameter_property coeff25 HDL_PARAMETER true
add_parameter coeff26 INTEGER 159257484
set_parameter_property coeff26 DEFAULT_VALUE 159257484
set_parameter_property coeff26 DISPLAY_NAME coeff26
set_parameter_property coeff26 TYPE INTEGER
set_parameter_property coeff26 UNITS None
set_parameter_property coeff26 HDL_PARAMETER true
add_parameter coeff27 INTEGER -48634503
set_parameter_property coeff27 DEFAULT_VALUE -48634503
set_parameter_property coeff27 DISPLAY_NAME coeff27
set_parameter_property coeff27 TYPE INTEGER
set_parameter_property coeff27 UNITS None
set_parameter_property coeff27 HDL_PARAMETER true
add_parameter coeff28 INTEGER -288270937
set_parameter_property coeff28 DEFAULT_VALUE -288270937
set_parameter_property coeff28 DISPLAY_NAME coeff28
set_parameter_property coeff28 TYPE INTEGER
set_parameter_property coeff28 UNITS None
set_parameter_property coeff28 HDL_PARAMETER true
add_parameter coeff29 INTEGER -257261434
set_parameter_property coeff29 DEFAULT_VALUE -257261434
set_parameter_property coeff29 DISPLAY_NAME coeff29
set_parameter_property coeff29 TYPE INTEGER
set_parameter_property coeff29 UNITS None
set_parameter_property coeff29 HDL_PARAMETER true
add_parameter coeff30 INTEGER 200400601
set_parameter_property coeff30 DEFAULT_VALUE 200400601
set_parameter_property coeff30 DISPLAY_NAME coeff30
set_parameter_property coeff30 TYPE INTEGER
set_parameter_property coeff30 UNITS None
set_parameter_property coeff30 HDL_PARAMETER true
add_parameter coeff31 INTEGER 906159873
set_parameter_property coeff31 DEFAULT_VALUE 906159873
set_parameter_property coeff31 DISPLAY_NAME coeff31
set_parameter_property coeff31 TYPE INTEGER
set_parameter_property coeff31 UNITS None
set_parameter_property coeff31 HDL_PARAMETER true
add_parameter coeff32 INTEGER 1435530257
set_parameter_property coeff32 DEFAULT_VALUE 1435530257
set_parameter_property coeff32 DISPLAY_NAME coeff32
set_parameter_property coeff32 TYPE INTEGER
set_parameter_property coeff32 UNITS None
set_parameter_property coeff32 HDL_PARAMETER true
add_parameter coeff33 INTEGER 1435530257
set_parameter_property coeff33 DEFAULT_VALUE 1435530257
set_parameter_property coeff33 DISPLAY_NAME coeff33
set_parameter_property coeff33 TYPE INTEGER
set_parameter_property coeff33 UNITS None
set_parameter_property coeff33 HDL_PARAMETER true
add_parameter coeff34 INTEGER 906159873
set_parameter_property coeff34 DEFAULT_VALUE 906159873
set_parameter_property coeff34 DISPLAY_NAME coeff34
set_parameter_property coeff34 TYPE INTEGER
set_parameter_property coeff34 UNITS None
set_parameter_property coeff34 HDL_PARAMETER true
add_parameter coeff35 INTEGER 200400601
set_parameter_property coeff35 DEFAULT_VALUE 200400601
set_parameter_property coeff35 DISPLAY_NAME coeff35
set_parameter_property coeff35 TYPE INTEGER
set_parameter_property coeff35 UNITS None
set_parameter_property coeff35 HDL_PARAMETER true
add_parameter coeff36 INTEGER -257261434
set_parameter_property coeff36 DEFAULT_VALUE -257261434
set_parameter_property coeff36 DISPLAY_NAME coeff36
set_parameter_property coeff36 TYPE INTEGER
set_parameter_property coeff36 UNITS None
set_parameter_property coeff36 HDL_PARAMETER true
add_parameter coeff37 INTEGER -288270937
set_parameter_property coeff37 DEFAULT_VALUE -288270937
set_parameter_property coeff37 DISPLAY_NAME coeff37
set_parameter_property coeff37 TYPE INTEGER
set_parameter_property coeff37 UNITS None
set_parameter_property coeff37 HDL_PARAMETER true
add_parameter coeff38 INTEGER -48634503
set_parameter_property coeff38 DEFAULT_VALUE -48634503
set_parameter_property coeff38 DISPLAY_NAME coeff38
set_parameter_property coeff38 TYPE INTEGER
set_parameter_property coeff38 UNITS None
set_parameter_property coeff38 HDL_PARAMETER true
add_parameter coeff39 INTEGER 159257484
set_parameter_property coeff39 DEFAULT_VALUE 159257484
set_parameter_property coeff39 DISPLAY_NAME coeff39
set_parameter_property coeff39 TYPE INTEGER
set_parameter_property coeff39 UNITS None
set_parameter_property coeff39 HDL_PARAMETER true
add_parameter coeff40 INTEGER 157290652
set_parameter_property coeff40 DEFAULT_VALUE 157290652
set_parameter_property coeff40 DISPLAY_NAME coeff40
set_parameter_property coeff40 TYPE INTEGER
set_parameter_property coeff40 UNITS None
set_parameter_property coeff40 HDL_PARAMETER true
add_parameter coeff41 INTEGER 4251772
set_parameter_property coeff41 DEFAULT_VALUE 4251772
set_parameter_property coeff41 DISPLAY_NAME coeff41
set_parameter_property coeff41 TYPE INTEGER
set_parameter_property coeff41 UNITS None
set_parameter_property coeff41 HDL_PARAMETER true
add_parameter coeff42 INTEGER -117212395
set_parameter_property coeff42 DEFAULT_VALUE -117212395
set_parameter_property coeff42 DISPLAY_NAME coeff42
set_parameter_property coeff42 TYPE INTEGER
set_parameter_property coeff42 UNITS None
set_parameter_property coeff42 HDL_PARAMETER true
add_parameter coeff43 INTEGER -96996745
set_parameter_property coeff43 DEFAULT_VALUE -96996745
set_parameter_property coeff43 DISPLAY_NAME coeff43
set_parameter_property coeff43 TYPE INTEGER
set_parameter_property coeff43 UNITS None
set_parameter_property coeff43 HDL_PARAMETER true
add_parameter coeff44 INTEGER 15237669
set_parameter_property coeff44 DEFAULT_VALUE 15237669
set_parameter_property coeff44 DISPLAY_NAME coeff44
set_parameter_property coeff44 TYPE INTEGER
set_parameter_property coeff44 UNITS None
set_parameter_property coeff44 HDL_PARAMETER true
add_parameter coeff45 INTEGER 90601381
set_parameter_property coeff45 DEFAULT_VALUE 90601381
set_parameter_property coeff45 DISPLAY_NAME coeff45
set_parameter_property coeff45 TYPE INTEGER
set_parameter_property coeff45 UNITS None
set_parameter_property coeff45 HDL_PARAMETER true
add_parameter coeff46 INTEGER 61311250
set_parameter_property coeff46 DEFAULT_VALUE 61311250
set_parameter_property coeff46 DISPLAY_NAME coeff46
set_parameter_property coeff46 TYPE INTEGER
set_parameter_property coeff46 UNITS None
set_parameter_property coeff46 HDL_PARAMETER true
add_parameter coeff47 INTEGER -24445856
set_parameter_property coeff47 DEFAULT_VALUE -24445856
set_parameter_property coeff47 DISPLAY_NAME coeff47
set_parameter_property coeff47 TYPE INTEGER
set_parameter_property coeff47 UNITS None
set_parameter_property coeff47 HDL_PARAMETER true
add_parameter coeff48 INTEGER -70907552
set_parameter_property coeff48 DEFAULT_VALUE -70907552
set_parameter_property coeff48 DISPLAY_NAME coeff48
set_parameter_property coeff48 TYPE INTEGER
set_parameter_property coeff48 UNITS None
set_parameter_property coeff48 HDL_PARAMETER true
add_parameter coeff49 INTEGER -38044016
set_parameter_property coeff49 DEFAULT_VALUE -38044016
set_parameter_property coeff49 DISPLAY_NAME coeff49
set_parameter_property coeff49 TYPE INTEGER
set_parameter_property coeff49 UNITS None
set_parameter_property coeff49 HDL_PARAMETER true
add_parameter coeff50 INTEGER 27893350
set_parameter_property coeff50 DEFAULT_VALUE 27893350
set_parameter_property coeff50 DISPLAY_NAME coeff50
set_parameter_property coeff50 TYPE INTEGER
set_parameter_property coeff50 UNITS None
set_parameter_property coeff50 HDL_PARAMETER true
add_parameter coeff51 INTEGER 54805925
set_parameter_property coeff51 DEFAULT_VALUE 54805925
set_parameter_property coeff51 DISPLAY_NAME coeff51
set_parameter_property coeff51 TYPE INTEGER
set_parameter_property coeff51 UNITS None
set_parameter_property coeff51 HDL_PARAMETER true
add_parameter coeff52 INTEGER 21303396
set_parameter_property coeff52 DEFAULT_VALUE 21303396
set_parameter_property coeff52 DISPLAY_NAME coeff52
set_parameter_property coeff52 TYPE INTEGER
set_parameter_property coeff52 UNITS None
set_parameter_property coeff52 HDL_PARAMETER true
add_parameter coeff53 INTEGER -29678515
set_parameter_property coeff53 DEFAULT_VALUE -29678515
set_parameter_property coeff53 DISPLAY_NAME coeff53
set_parameter_property coeff53 TYPE INTEGER
set_parameter_property coeff53 UNITS None
set_parameter_property coeff53 HDL_PARAMETER true
add_parameter coeff54 INTEGER -44017600
set_parameter_property coeff54 DEFAULT_VALUE -44017600
set_parameter_property coeff54 DISPLAY_NAME coeff54
set_parameter_property coeff54 TYPE INTEGER
set_parameter_property coeff54 UNITS None
set_parameter_property coeff54 HDL_PARAMETER true
add_parameter coeff55 INTEGER -12828998
set_parameter_property coeff55 DEFAULT_VALUE -12828998
set_parameter_property coeff55 DISPLAY_NAME coeff55
set_parameter_property coeff55 TYPE INTEGER
set_parameter_property coeff55 UNITS None
set_parameter_property coeff55 HDL_PARAMETER true
add_parameter coeff56 INTEGER 24630279
set_parameter_property coeff56 DEFAULT_VALUE 24630279
set_parameter_property coeff56 DISPLAY_NAME coeff56
set_parameter_property coeff56 TYPE INTEGER
set_parameter_property coeff56 UNITS None
set_parameter_property coeff56 HDL_PARAMETER true
add_parameter coeff57 INTEGER 26417904
set_parameter_property coeff57 DEFAULT_VALUE 26417904
set_parameter_property coeff57 DISPLAY_NAME coeff57
set_parameter_property coeff57 TYPE INTEGER
set_parameter_property coeff57 UNITS None
set_parameter_property coeff57 HDL_PARAMETER true
add_parameter coeff58 INTEGER -10373828
set_parameter_property coeff58 DEFAULT_VALUE -10373828
set_parameter_property coeff58 DISPLAY_NAME coeff58
set_parameter_property coeff58 TYPE INTEGER
set_parameter_property coeff58 UNITS None
set_parameter_property coeff58 HDL_PARAMETER true
add_parameter coeff59 INTEGER -51726249
set_parameter_property coeff59 DEFAULT_VALUE -51726249
set_parameter_property coeff59 DISPLAY_NAME coeff59
set_parameter_property coeff59 TYPE INTEGER
set_parameter_property coeff59 UNITS None
set_parameter_property coeff59 HDL_PARAMETER true
add_parameter coeff60 INTEGER -63260525
set_parameter_property coeff60 DEFAULT_VALUE -63260525
set_parameter_property coeff60 DISPLAY_NAME coeff60
set_parameter_property coeff60 TYPE INTEGER
set_parameter_property coeff60 UNITS None
set_parameter_property coeff60 HDL_PARAMETER true
add_parameter coeff61 INTEGER -40655304
set_parameter_property coeff61 DEFAULT_VALUE -40655304
set_parameter_property coeff61 DISPLAY_NAME coeff61
set_parameter_property coeff61 TYPE INTEGER
set_parameter_property coeff61 UNITS None
set_parameter_property coeff61 HDL_PARAMETER true
add_parameter coeff62 INTEGER -7110558
set_parameter_property coeff62 DEFAULT_VALUE -7110558
set_parameter_property coeff62 DISPLAY_NAME coeff62
set_parameter_property coeff62 TYPE INTEGER
set_parameter_property coeff62 UNITS None
set_parameter_property coeff62 HDL_PARAMETER true
add_parameter coeff63 INTEGER 12589485
set_parameter_property coeff63 DEFAULT_VALUE 12589485
set_parameter_property coeff63 DISPLAY_NAME coeff63
set_parameter_property coeff63 TYPE INTEGER
set_parameter_property coeff63 UNITS None
set_parameter_property coeff63 HDL_PARAMETER true
add_parameter coeff64 INTEGER 15822929
set_parameter_property coeff64 DEFAULT_VALUE 15822929
set_parameter_property coeff64 DISPLAY_NAME coeff64
set_parameter_property coeff64 TYPE INTEGER
set_parameter_property coeff64 UNITS None
set_parameter_property coeff64 HDL_PARAMETER true


# 
# display items
# 


# 
# connection point nios_custom_instruction_slave
# 
add_interface nios_custom_instruction_slave nios_custom_instruction end
set_interface_property nios_custom_instruction_slave clockCycle 0
set_interface_property nios_custom_instruction_slave operands 1
set_interface_property nios_custom_instruction_slave ENABLED true
set_interface_property nios_custom_instruction_slave EXPORT_OF ""
set_interface_property nios_custom_instruction_slave PORT_NAME_MAP ""
set_interface_property nios_custom_instruction_slave SVD_ADDRESS_GROUP ""

add_interface_port nios_custom_instruction_slave clk clk Input 1
add_interface_port nios_custom_instruction_slave clk_enable clk_en Input 1
add_interface_port nios_custom_instruction_slave reset reset Input 1
add_interface_port nios_custom_instruction_slave filter_in dataa Input 32
add_interface_port nios_custom_instruction_slave filter_out result Output 32
add_interface_port nios_custom_instruction_slave Done done Output 1
