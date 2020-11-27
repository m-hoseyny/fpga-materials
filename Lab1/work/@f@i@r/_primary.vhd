library verilog;
use verilog.vl_types.all;
entity FIR is
    generic(
        INPUT_LENGTH    : integer := 50;
        INPUT_WIDTH     : integer := 16;
        COEFF_WIDTH     : integer := 16;
        COEFF_LENGTH    : integer := 64;
        COEFF_ADDRESS_LENGTH: vl_notype;
        OUTPUT_WIDTH    : integer := 38;
        RAM_ADDRESS_LENGTH: vl_notype;
        Idle            : integer := 0;
        WriteDataToRam  : integer := 1;
        PutDataOnOut    : integer := 3;
        Calculation_LoadData: integer := 2;
        Calculation_PipStage: integer := 4;
        Calculation_OutPutReg: integer := 5;
        Calculation_ReadDataFromRam: integer := 7;
        ValidOutPut     : integer := 6
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        FIR_input       : in     vl_logic_vector;
        input_Valid     : in     vl_logic;
        FIR_output      : out    vl_logic_vector;
        output_Valid    : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INPUT_LENGTH : constant is 1;
    attribute mti_svvh_generic_type of INPUT_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of COEFF_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of COEFF_LENGTH : constant is 1;
    attribute mti_svvh_generic_type of COEFF_ADDRESS_LENGTH : constant is 3;
    attribute mti_svvh_generic_type of OUTPUT_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of RAM_ADDRESS_LENGTH : constant is 3;
    attribute mti_svvh_generic_type of Idle : constant is 1;
    attribute mti_svvh_generic_type of WriteDataToRam : constant is 1;
    attribute mti_svvh_generic_type of PutDataOnOut : constant is 1;
    attribute mti_svvh_generic_type of Calculation_LoadData : constant is 1;
    attribute mti_svvh_generic_type of Calculation_PipStage : constant is 1;
    attribute mti_svvh_generic_type of Calculation_OutPutReg : constant is 1;
    attribute mti_svvh_generic_type of Calculation_ReadDataFromRam : constant is 1;
    attribute mti_svvh_generic_type of ValidOutPut : constant is 1;
end FIR;
