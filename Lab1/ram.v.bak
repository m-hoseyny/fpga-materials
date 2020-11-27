module Ram (clk, input_data, address, read, write, output_data);

    parameter LENGTH = 221184;
    parameter RAM_ADDRESS_LENGTH = $clog2(LENGTH);
    parameter WIDTH = 16;

    input     clk, read;
    input     [WIDTH-1:0] input_data;
    input     [RAM_ADDRESS_LENGTH-1:0]address;
    input     write;
    output    [WIDTH-1:0] output_data;

    reg       [WIDTH-1:0] memory [0:LENGTH-1];

    integer i;

    initial begin
        for (i=0; i < LENGTH ; i = i+1)
            memory[i] <= 0;
    end

    always @(posedge clk) begin //initialize
        begin
            if(write)
                memory[address] <= input_data;
        end

    end 
    assign output_data = read ? memory[address] : output_data;



endmodule



module Ram_TB();

    reg clk, reset, read, write;
    reg [15:0]input_data;
    reg [$clog2(221182):0] address;
    wire [15:0]output_data;

    Ram ins_ram(.clk(clk),
                // .reset(reset),
                .read(read),
                .write(write),
                .input_data(input_data),
                .output_data(output_data),
                .address(address));

    initial begin
        clk = 1'b0;
        repeat(100) #10 clk = ~clk;
    end

    initial begin
        reset = 1'b1;
        #2;
        reset = 1'b0;
        #25;
        reset = 1'b1;
        #5;
        read = 1;
        address = 0;
        #5;
        address = 18'd1;
        #20;
        read = 0;
        write = 1;
        #10;
        address = 18'd2;
        input_data = 16'd5;
        #100;
        write = 0;
        read = 1;
        #50;
    end


endmodule