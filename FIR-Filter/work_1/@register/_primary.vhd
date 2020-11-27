library verilog;
use verilog.vl_types.all;
entity \Register\ is
    generic(
        WIDTH           : integer := 16
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end \Register\;
