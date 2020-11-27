library verilog;
use verilog.vl_types.all;
entity Counter is
    generic(
        WIDTH           : integer := 16
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        inc             : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end Counter;
