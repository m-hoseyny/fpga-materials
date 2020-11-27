library verilog;
use verilog.vl_types.all;
entity SignExtend is
    generic(
        IN_WIDTH        : integer := 5;
        OUT_WIDTH       : integer := 32
    );
    port(
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IN_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of OUT_WIDTH : constant is 1;
end SignExtend;
