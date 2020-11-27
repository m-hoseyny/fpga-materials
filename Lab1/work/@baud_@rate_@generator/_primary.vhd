library verilog;
use verilog.vl_types.all;
entity Baud_Rate_Generator is
    generic(
        SYSTEM_CLOCK    : integer := 50000000;
        COUNTER_LENGTH  : vl_notype
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        baud_rate       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SYSTEM_CLOCK : constant is 1;
    attribute mti_svvh_generic_type of COUNTER_LENGTH : constant is 3;
end Baud_Rate_Generator;
