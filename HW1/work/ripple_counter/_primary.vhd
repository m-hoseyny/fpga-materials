library verilog;
use verilog.vl_types.all;
entity ripple_counter is
    port(
        clock           : in     vl_logic;
        toggle          : in     vl_logic;
        reset           : in     vl_logic;
        count           : out    vl_logic_vector(3 downto 0)
    );
end ripple_counter;
