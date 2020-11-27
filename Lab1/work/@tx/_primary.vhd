library verilog;
use verilog.vl_types.all;
entity Tx is
    generic(
        IDLE            : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        SENDDATA        : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        ENDBIT          : vl_logic_vector(0 to 1) := (Hi1, Hi0)
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        TxD_start       : in     vl_logic;
        TxD_data        : in     vl_logic_vector(7 downto 0);
        BaudTick        : in     vl_logic;
        TxD             : out    vl_logic;
        Busy            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of SENDDATA : constant is 1;
    attribute mti_svvh_generic_type of ENDBIT : constant is 1;
end Tx;
