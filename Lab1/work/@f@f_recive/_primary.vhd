library verilog;
use verilog.vl_types.all;
entity FF_recive is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        ld1             : in     vl_logic;
        ld2             : in     vl_logic;
        dataIn          : in     vl_logic_vector(7 downto 0);
        dataOut         : out    vl_logic_vector(15 downto 0)
    );
end FF_recive;
