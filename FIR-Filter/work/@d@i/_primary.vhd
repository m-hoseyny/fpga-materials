library verilog;
use verilog.vl_types.all;
entity DI is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        ld              : in     vl_logic;
        inAddress       : in     vl_logic_vector(4 downto 0);
        outAddress      : out    vl_logic_vector(4 downto 0)
    );
end DI;
