library verilog;
use verilog.vl_types.all;
entity FIR_TB is
    generic(
        INPUT_WIDTH     : integer := 16;
        LENGTH          : integer := 221184;
        OUTPUT_WIDTH    : integer := 38
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INPUT_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of LENGTH : constant is 1;
    attribute mti_svvh_generic_type of OUTPUT_WIDTH : constant is 1;
end FIR_TB;
