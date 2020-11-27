module FIR (clk, reset, FIR_input, input_Valid, FIR_output, output_Valid);
    // Main Parameter
    parameter INPUT_LENGTH =  50;
    parameter INPUT_WIDTH = 16;
    parameter COEFF_WIDTH = 16;
    parameter COEFF_LENGTH = 64;
    parameter COEFF_ADDRESS_LENGTH = $clog2(COEFF_LENGTH);
    parameter OUTPUT_WIDTH = 38;
    parameter RAM_ADDRESS_LENGTH = $clog2(INPUT_LENGTH);
    //Stage Parameter
    parameter Idle = 0;
    parameter WriteDataToRam = 1;
    parameter PutDataOnOut = 3;
    parameter Calculation_LoadData = 2;
    parameter Calculation_PipStage = 4;
    parameter Calculation_OutPutReg = 5;
    parameter Calculation_ReadDataFromRam = 7;
    parameter ValidOutPut = 6;

    input     clk, reset, input_Valid;
    input     [INPUT_WIDTH-1:0] FIR_input;
    output    output_Valid;
    reg       output_Valid;
    output    [OUTPUT_WIDTH-1:0 ]FIR_output;
    reg signed [OUTPUT_WIDTH-1:0 ]FIR_output;

    reg [3:0]ps, ns;
    wire [RAM_ADDRESS_LENGTH-1:0] sub_in_ram_add, in_ram_add, ram_add, se_coeff_mem_add, mux_ram_add;

    reg sel_mux_in_ram_add, ram_read, ram_write, ram_reg_ld, coeff_reg_ld, mult_pip_reg_ld, output_reg_ld;
    reg coeff_cnt_reset, output_calc_reg_reset;

    reg coeff_cnt_inc, ram_cnt_inc;

    wire signed [COEFF_WIDTH-1:0]b_k, coeff_out;
    wire signed [INPUT_WIDTH-1:0] x_n_k, ram_output;
    wire [COEFF_ADDRESS_LENGTH:0]coeff_mem_add; 
    wire signed  [INPUT_WIDTH*2-1:0] mult_out, pip_mult_out;
    wire signed  [(INPUT_WIDTH*2+COEFF_ADDRESS_LENGTH)-1:0] se_pip_mult_out, calc_data, feed_back_calc_data;

    Counter #(
        .WIDTH(COEFF_ADDRESS_LENGTH+1)
    ) coeff_mem_add_cnt(clk, coeff_cnt_reset, coeff_cnt_inc, coeff_mem_add);

    Counter #(
        .WIDTH(RAM_ADDRESS_LENGTH)
    ) input_ram_add_cnt(clk, reset, ram_cnt_inc, in_ram_add);

    Coeff_ROM inst_Coeff_ROM (.address(coeff_mem_add), .clock(clk), .q(coeff_out));

    // CoeffRam #(
    //     .LENGTH(COEFF_LENGTH+1),
    //     .WIDTH(COEFF_WIDTH)
    // ) coeffram(coeff_mem_add, coeff_out);

    // Register #(
    //     .WIDTH(COEFF_WIDTH)
    // ) coeff_reg(clk, reset,coeff_reg_ld, coeff_out, b_k);

    SignExtend #(
        .IN_WIDTH(COEFF_ADDRESS_LENGTH+1),
        .OUT_WIDTH(RAM_ADDRESS_LENGTH)
    ) se_coeff_mem_add_module(coeff_mem_add, se_coeff_mem_add);
    
    Sub #(
        .WIDTH(RAM_ADDRESS_LENGTH)
    ) ram_add_sub (in_ram_add, se_coeff_mem_add, sub_in_ram_add);


    Mux #(
        .WIDTH(RAM_ADDRESS_LENGTH)
        ) input_ram_add_mux(sel_mux_in_ram_add, sub_in_ram_add, in_ram_add, mux_ram_add);

    assign ram_add = ( mux_ram_add >= 0 && mux_ram_add < INPUT_LENGTH) ? mux_ram_add : (INPUT_LENGTH-1);

    Ram #(
        .LENGTH(INPUT_LENGTH),
        .WIDTH(INPUT_WIDTH)
    ) input_ram(.clk(clk),
                // .reset(reset),
                .input_data(FIR_input),
                .address(ram_add),
                .read(ram_read),
                .write(ram_write),
                .output_data(ram_output) );
    
    Register #(
        .WIDTH(INPUT_LENGTH)
    ) ram_reg(clk, reset, ram_reg_ld, ram_output, x_n_k);

    Mult #(
        .WIDTH(INPUT_WIDTH)
    ) mult (x_n_k, b_k, mult_out);

    Register #(
        .WIDTH(2*INPUT_WIDTH)
    ) mult_pip_reg(clk, output_calc_reg_reset, mult_pip_reg_ld, mult_out, pip_mult_out);

    SignExtend #(
        .IN_WIDTH(INPUT_WIDTH*2),
        .OUT_WIDTH(2*INPUT_WIDTH + COEFF_ADDRESS_LENGTH)
    ) se_pip_mult_out_module(pip_mult_out, se_pip_mult_out);

    Adder #(
        .WIDTH(2*INPUT_WIDTH + COEFF_ADDRESS_LENGTH)
    ) addder (se_pip_mult_out, feed_back_calc_data, calc_data);

    Register #(
        .WIDTH(2*INPUT_WIDTH + COEFF_ADDRESS_LENGTH)
    ) ouput_reg(clk, output_calc_reg_reset, output_reg_ld, calc_data, feed_back_calc_data);




    always @(posedge clk, negedge reset) begin 
        if (!reset)
            ps <= Idle;
        else
            ps <= ns;
    end
    
    always @(*) begin
        {coeff_cnt_reset, output_calc_reg_reset} = 2'b11;
        {ram_cnt_inc, ram_write, sel_mux_in_ram_add, coeff_cnt_inc, output_Valid, ram_read,ram_reg_ld, coeff_reg_ld, mult_pip_reg_ld, output_reg_ld} = 10'b0;
        case(ps)
            Idle: 
                begin
                    coeff_cnt_reset = 1'b0;
                    output_calc_reg_reset = 1'b0;
                    if(input_Valid)
                        ns = WriteDataToRam;
                    else
                        ns = Idle;
                end
            WriteDataToRam: 
                begin
                    coeff_cnt_reset = 1'b0;
                    output_calc_reg_reset = 1'b0;
                    ram_cnt_inc = 1'b1;
                    ram_write = 1'b1;
                    sel_mux_in_ram_add = 1'b1;
                    ns = Calculation_ReadDataFromRam;
                end
            Calculation_ReadDataFromRam:
                begin
                    ram_read = 1'b1;
                    coeff_reg_ld = 1'b1;
                    ram_reg_ld = 1'b1;
                    ns = Calculation_PipStage; 
                end
            Calculation_PipStage: 
                begin
                    coeff_cnt_inc <= 1'b1;
                    mult_pip_reg_ld = 1'b1;
                    ns = Calculation_OutPutReg;
                end
            Calculation_OutPutReg: 
                begin
                    if (coeff_mem_add < COEFF_LENGTH+1) 
                    begin
                        output_reg_ld = 1'b1;
                        ns = Calculation_ReadDataFromRam;
                    end 
                    else 
                    begin
                        ns = ValidOutPut;
                        
                    end
                end
            
            ValidOutPut: 
                begin
                    output_Valid = 1'b1;
                    ns = Idle;
                end
        endcase
    end    

    always @(*)
        FIR_output = feed_back_calc_data;






endmodule
