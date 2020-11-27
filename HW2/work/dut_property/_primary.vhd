library verilog;
use verilog.vl_types.all;
entity dut_property is
    port(
        pclk            : in     vl_logic;
        preq            : in     vl_logic;
        pgnt            : in     vl_logic
    );
end dut_property;
