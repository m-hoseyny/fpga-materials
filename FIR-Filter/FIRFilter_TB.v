`timescale 1ns / 1ps
module FIR_TB();
    parameter INPUT_WIDTH = 16;
    parameter LENGTH = 221184;
    parameter OUTPUT_WIDTH = 38;

    reg clk, reset, input_valid;
    reg [INPUT_WIDTH-1:0] din;

    reg [INPUT_WIDTH-1:0]input_data[0:LENGTH-1] ;
    reg [OUTPUT_WIDTH-1:0]expected_data[0:LENGTH-1] ;
    
    wire output_valid;
    wire [OUTPUT_WIDTH-1:0] dout ;
    reg [OUTPUT_WIDTH-1:0]expecter_dout;
    integer k, cnt, fp, ferror;

    FIR test_fir(
        .clk(clk),
        .reset(reset),
        .FIR_input(din),
        .input_Valid(input_valid),
        .FIR_output(dout),
        .output_Valid(output_valid)
    );

    initial begin  
        $readmemb("files/inputs.txt", input_data);   
    end
    initial begin
        $readmemb("files/outputs.txt", expected_data);
    end           

    initial begin
        clk = 1'b0;
        // repeat (500)#10 clk = ~clk;
    end
    always #10 clk = ~clk;

    initial begin 
        reset = 1'b0;
        din = 16'b0;  
        cnt = 0;
        #400;
        reset = 1'b1;
    end   

    initial 
    begin
        $display("Start Testing FIR Filter..");
	    fp = $fopen("outManualFIRVerilog.txt");
        ferror = $fopen("ErrorSamples.txt");
        #410;
        $display("Testing %d Samples...",LENGTH);
        $display("Input Width : %d, Output Width : %d", INPUT_WIDTH, OUTPUT_WIDTH);
        k = 0;
        input_valid = 1'b1;
        // #5;
        din =input_data[k];
        expecter_dout = expected_data[k];
        #20;

        // #1000;


        for (k=0; k < LENGTH; k = k)
        begin
            @(negedge clk) 
            begin
                if(input_valid)
                    input_valid = 1'b0;
                if (output_valid) //delay for FIR process
                begin
                        $fwrite(fp,"%b\n",dout);
                        expecter_dout = expected_data[k];
                        if(dout != expecter_dout)
                        begin
                        // $display("Sample failed: %d   input: %x expected: %x output: %x\n" , k, din, expected_data[k], dout);
                            $fwrite(ferror, "test failed: %d    input: %b expected: %b MyFIRoutput: %b\n" , k, din, expected_data[k], dout);
                        end
                        k = k+1;
                        din =input_data[k];
                        expecter_dout = expected_data[k];
                        input_valid = 1'b1;
                        // cnt = 0;

                        #100;
                        // @(posedge clk)
                        // begin


                        // end
                end
                // else
                //     cnt = cnt + 1;
            end
        end
        $fclose(fp);
        $fclose(ferror);
        $display ("Test Passed.");
        $stop;

    end




endmodule