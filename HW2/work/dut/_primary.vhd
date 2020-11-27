library verilog;
use verilog.vl_types.all;
entity dut is
    port(
        clk             : in     vl_logic;
        req             : in     vl_logic;
        gnt             : out    vl_logic
    );
end dut;
