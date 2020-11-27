library verilog;
use verilog.vl_types.all;
entity controller is
    generic(
        GetData1        : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi0);
        GetData2        : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        FIRCalculation  : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        SendData1       : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi1);
        Busy1           : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi0);
        SendData2       : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi1);
        Busy2           : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi0);
        InputValidStage : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        data_ready      : in     vl_logic;
        outputValid     : in     vl_logic;
        DataInRx        : in     vl_logic_vector(7 downto 0);
        DataInFIR       : in     vl_logic_vector(15 downto 0);
        busy            : in     vl_logic;
        inputValid      : out    vl_logic;
        TxD_start       : out    vl_logic;
        DataOutTx       : out    vl_logic_vector(7 downto 0);
        DataOutFIR      : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of GetData1 : constant is 1;
    attribute mti_svvh_generic_type of GetData2 : constant is 1;
    attribute mti_svvh_generic_type of FIRCalculation : constant is 1;
    attribute mti_svvh_generic_type of SendData1 : constant is 1;
    attribute mti_svvh_generic_type of Busy1 : constant is 1;
    attribute mti_svvh_generic_type of SendData2 : constant is 1;
    attribute mti_svvh_generic_type of Busy2 : constant is 1;
    attribute mti_svvh_generic_type of InputValidStage : constant is 1;
end controller;
