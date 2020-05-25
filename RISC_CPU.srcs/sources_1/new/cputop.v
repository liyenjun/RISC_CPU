`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 20:47:59
// Design Name: 
// Module Name: cputop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "cpu.v"
`include "ram.v"
`include "rom.v"
`include "addr_decode.v"

`define PERIOD 100

module cputop(

    );
    reg reset_req, clock;
    integer    test;
    reg[(3*8):0]    mnemonic;
    reg [12:0]  PC_addr, IR_addr;
    wire    [7:0]   data;
    wire    [7:0]   addr;
    wire    rd, wr, halt, ram_sel, rom_sel;
    wire    [2:0]   opcode;
    wire    fetch;
    wire    [12:0]  ir_addr, pc_addr;
    
    cpu t_cpu(.clk(clock), .reset(reset_req), .halt(halt), .rd(rd), .wr(wr), .addr(addr), .data(data),
                .opcode(opcode), .fetch(fetch), .ir_addr(ir_addr), .pc_addr(pc_addr));
    ram t_ram(.addr(addr[9:0]), .read(rd), .write(wr), .ena(ram_sel), .data(data));
    rom t_rom(.addr(addr), .read(rd), .ena(rom_sel), .data(data));
    addr_decode t_addrdecode(.addr(addr), .ram_sel(ram_sel), .rom_sel(rom_sel));
    
initial
    begin
        clock=1;
        $timeformat(-9, 1, "ns", 12);
        display_debug_message;
        sys_reset;
        test1;
        $stop;
        test2;
        $stop;
        test3;
        $finish;
    end
    
    task display_debug_message;
        begin
            $display("\n******************************************");
            $display("* THE FOLLOWING DEBUG TASK ARE AVAILABLE: *");
            $display("* \"test1; \" to load the 1st diagnostic program. *");
            $display("* \"test2; \" to load the 2nd diagnostic program. *");
            $display("* \"test3; \" to load the 3rd diagnostic program. *");
            $display("********************************************");
        end
    endtask

    task test1;
        begin
            test = 0;
            disable MONITOR;
            $readmemb("test1.pro", t_rom.memory);
            $display("rom loaded successfully!");
            $readmemb("test1.dat", t_ram.ram);
            $display("ram loaded successfully!");
            #1 test = 1;
            #14800;
            sys_reset;
        end
    endtask

    task test2;
        begin
            test = 0;
            disable MONITOR;
            $readmemb("test2.pro", t_rom.memory);
            $display("rom loaded successfully!");
            $readmemb("test2.dat", t_ram.ram);
            $display("ram loaded successfully!");
            #1 test = 2;
            #11600;
            sys_reset;
        end
    endtask    

    task test3;
        begin
            test = 0;
            disable MONITOR;
            $readmemb("test3.pro", t_rom.memory);
            $display("rom loaded successfully!");
            $readmemb("test3.dat", t_ram.ram);
            $display("ram loaded successfully!");
            #1 test = 3;
            #9400;
            sys_reset;
        end
    endtask    
    
    task sys_reset;
        begin
            reset_req = 0;
            #(`PERIOD*0.7) reset_req =1;
            #(1.5*`PERIOD) reset_req = 0;
        end
    endtask
    
    always@(test)
        begin: MONITOR
            case(test)
            1: 
                begin
                    $display("\n***RUNNING CPUtest1 - The Basic CPU Diagnostic Program ***");
                    $display("\n    TIME    PC  INSTR   ADDR    DATA    ");
                    $display("                                          ");
                    while(test==1)
                        @(t_cpu.m_adr.pc_addr)  //fixed
                        if((t_cpu.m_adr.pc_addr%2 == 1)&&(t_cpu.m_adr.fetch == 1)) //fixed
                        begin
                            #60 PC_addr <= t_cpu.m_adr.pc_addr-1;
                                IR_addr <= t_cpu.m_adr.ir_addr;
                            #30 $storbe("%t  %h  %s  %h  %h", $time, PC_addr, mnemonic, IR_addr, data);
                        end
                end
            2:
                begin
                    $display("\n***RUNNING CPUtest2 - The Basic CPU Diagnostic Program ***");
                    $display("\n    TIME    PC  INSTR   ADDR    DATA    ");
                    $display("                                          ");
                    while(test==2)
                        @(t_cpu.m_adr.pc_addr)  //fixed
                    if((t_cpu.m_adr.pc_addr%2 == 1)&&(t_cpu.m_adr.fetch == 1)) //fixed
                    begin
                        #60 PC_addr <= t_cpu.m_adr.pc_addr-1;
                            IR_addr <= t_cpu.m_adr.ir_addr;
                        #30 $storbe("%t  %h  %s  %h  %h", $time, PC_addr, mnemonic, IR_addr, data);
                    end
                end
            
            3:
                begin
                    $display("\n***RUNNING CPUtest3 - The Basic CPU Diagnostic Program ***");
                    $display("\n    TIME    PC  INSTR   ADDR    DATA    ");
                    $display("                                          ");
                    while(test==3)
                    begin                                         
                        wait(t_cpu.m_alu.opcode == 3'h1)          
                        $storbe("%t  %d", $time, t_ram.ram[10'h2]);
                        wait(t_cpu.m_alu.opcode != 3'h1);
                    end
                end
            endcase        
        end
        
            always@(posedge halt)
                begin
                    #500
                        $display("\n*****************************************");
                        $display("** A HALT INSTRUCTION WAS PROCESSED !!! **");
                        $display("*****************************************\n");
               end
           always #(`PERIOD/2) clock=~clock;
           always@(t_cpu.opcode)
            case(t_cpu.m_alu.opcode)
                3'b000  : mnemonic = "HLT";
                3'h1    : mnemonic = "SKZ";
                3'h2    : mnemonic = "ADD";
                3'h3    : mnemonic = "AND";
                3'h4    : mnemonic = "XOR";
                3'h5    : mnemonic = "LDA";
                3'h6    : mnemonic = "STO";
                3'h7    : mnemonic = "JMP";
                default: mnemonic = "???";
            endcase
                        
endmodule
