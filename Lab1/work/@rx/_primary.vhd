library verilog;
use verilog.vl_types.all;
entity Rx is
    generic(
        START           : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        CHECK_START     : vl_logic_vector(0 to 1) := (Hi1, Hi1);
        PROC            : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        \DATA_READY\    : vl_logic_vector(0 to 1) := (Hi1, Hi0)
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        nx_boud_rate    : in     vl_logic;
        RxD             : in     vl_logic;
        data_ready      : out    vl_logic;
        RxD_out         : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of START : constant is 1;
    attribute mti_svvh_generic_type of CHECK_START : constant is 1;
    attribute mti_svvh_generic_type of PROC : constant is 1;
    attribute mti_svvh_generic_type of \DATA_READY\ : constant is 1;
end Rx;
