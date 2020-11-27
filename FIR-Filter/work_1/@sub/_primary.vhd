library verilog;
use verilog.vl_types.all;
entity Sub is
    generic(
        WIDTH           : integer := 64
    );
    port(
        A               : in     vl_logic_vector;
        B               : in     vl_logic_vector;
        \Out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end Sub;
