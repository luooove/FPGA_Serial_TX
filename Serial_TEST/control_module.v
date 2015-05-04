module control_module
(
	CLK,RSTn,
	TX_Done_Sig,
	TX_En_Sig,
	TX_Data
);

input CLK;
input RSTn;
input TX_Done_Sig;
output TX_En_Sig;
output [7:0] TX_Data;

/*************************/
parameter T1S =25'd05_999_999;

/**************************/
 
reg [24:0] Count_Sec;

always @(posedge CLK or negedge RSTn)
if(!RSTn)
	Count_Sec <= 25'd0;
else if(Count_Sec == T1S)
	Count_Sec <= 25'd0;
else
	Count_Sec <= Count_Sec + 1'b1;
	
/*************************************/

reg isEn;
reg [7:0] rData;

always @(posedge CLK or negedge RSTn)
if(!RSTn)
	begin
		isEn <= 1'b0;
		rData <= 8'h32;
	end
else if (TX_Done_Sig)
	begin
		rData <= rData + 1'b1;
		isEn <= 1'b0;
	end
else if(Count_Sec == T1S)
	isEn <= 1'b1;
	
/*************************************/

assign TX_Data = rData;
assign TX_En_Sig = isEn;

endmodule

