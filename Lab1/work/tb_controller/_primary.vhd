library verilog;
use verilog.vl_types.all;
entity tb_controller is
    generic(
        GetData1        : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi0);
        GetData2        : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        FIRCalculation  : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        SendData1       : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi1);
        Busy1           : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi0);
        SendData2       : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi1);
        Busy2           : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of GetData1 : constant is 1;
    attribute mti_svvh_generic_type of GetData2 : constant is 1;
    attribute mti_svvh_generic_type of FIRCalculation : constant is 1;
    attribute mti_svvh_generic_type of SendData1 : constant is 1;
    attribute mti_svvh_generic_type of Busy1 : constant is 1;
    attribute mti_svvh_generic_type of SendData2 : constant is 1;
    attribute mti_svvh_generic_type of Busy2 : constant is 1;
end tb_controller;
