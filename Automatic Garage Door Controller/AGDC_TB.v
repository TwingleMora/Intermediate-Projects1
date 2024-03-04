module AGDC_TB;
 reg UP_Max,DN_Max,Activate,CLK,RST;
 wire UP_M,DN_M;

AGDC Auto_Garage_Door( //Automatic Garage Door Controller
    .UP_Max(UP_Max),.DN_Max(DN_Max),.Activate(Activate),.CLK(CLK),.RST(RST),
    .UP_M(UP_M),.DN_M(DN_M)
);
always #5 CLK=~CLK;

task initialize;
begin
CLK=0;
RST=0;//state is IDLE
@(negedge CLK)
RST=1; 
end
endtask

task Sensors_Activate;
reg [5:0] activates;//= 6'b000000;  
reg [5:0] max_ups;// =  6'b000001;
reg [5:0] max_dns;// =  6'b000000;
integer counter;
begin
activates = 6'b111111;  
max_ups =   6'b001101;
max_dns =   6'b110010;
$display("State 0: IDLE , State 1: Move Down , State 2: Move Up ");
 $display("Up_Max: %b, Dn_Max: %b, Activate: %b , Up_Mator: %b, Dn_Mator: %b , State: %0d",UP_Max,DN_Max,Activate,UP_M,DN_M,Auto_Garage_Door.Current);
 @(negedge CLK)
    for(counter=0;counter<6;counter=counter+1)
    begin
      
       
        UP_Max=max_ups[counter];
        DN_Max=max_dns[counter];
        Activate=activates[counter];
        #10
        $display("Up_Max: %b, Dn_Max: %b, Activate: %b , Up_Mator: %b, Dn_Mator: %b , State: %0d",UP_Max,DN_Max,Activate,UP_M,DN_M,Auto_Garage_Door.Current);

    end
end
endtask

initial
begin
initialize;
Sensors_Activate;
$stop;
end
endmodule
