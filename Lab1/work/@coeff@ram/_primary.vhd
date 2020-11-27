library verilog;
use verilog.vl_types.all;
entity CoeffRam is
    generic(
        LENGTH          : integer := 64;
        RAM_ADDRESS_LENGTH: vl_notype;
        WIDTH           : integer := 16
    );
    port(
        address         : in     vl_logic_vector;
        output_data     : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of LENGTH : constant is 1;
    attribute mti_svvh_generic_type of RAM_ADDRESS_LENGTH : constant is 3;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end CoeffRam;
