// Encryption of ShiftRows in Verilog (128/256)
// Vi Lam, 07/05/20
// Function:
// Operates on the rows of the states
// Shifted the bytes cyclically in each row by a certain offset


//Encryption of shiftrows 128bits
module shiftrow(clock,sl,sr);
input clock;

input [127:0] sl;
output reg [127:0] sr;
always @(posedge clock)
begin

      sr[127:120] = sl[127:120];  
      sr[119:112] = sl[119:112];
      sr[111:104] = sl[111:104];
      sr[103:96]  = sl[103:96];
   
      sr[95:88] = sl[87:80];
      sr[87:80] = sl[79:72];
      sr[79:72] = sl[71:64];
      sr[71:64] = sl[95:88];
   
      sr[63:56] = sl[47:40];									
      sr[55:48] = sl[39:32];
      sr[47:40] = sl[63:56];
      sr[39:32] = sl[55:48];
   
      sr[31:24] = sl[7:0];
      sr[23:16] = sl[31:24];
      sr[15:8]  = sl[23:16];
      sr[7:0]   = sl[15:8]; 
		  end


endmodule

//Encryption of shiftrows 256bits
module shiftrow256(clock,sl,sr);
input clock;
input  [255:0] sl;
output reg [255:0] sr;
always @(posedge clock)
begin

       sr[255:248] = sl[255:248];  
       sr[247:240] = sl[247:240];
       sr[239:232] = sl[239:232];
       sr[231:224] = sl[231:224];
       sr[223:216] = sl[223:216];
       sr[215:208] = sl[215:208];
       sr[207:200] = sl[207:200];
       sr[199:192] = sl[199:192];
   
       sr[191:184] = sl[183:176];
       sr[183:176] = sl[175:168];
       sr[175:168] = sl[167:160];
       sr[167:160] = sl[159:152];
       sr[159:152] = sl[151:144];
       sr[151:144] = sl[143:136];
       sr[143:136] = sl[135:128];
       sr[135:128] = sl[191:184];

       sr[127:120] = sl[103:196];
       sr[119:112] = sl[95:88];
       sr[111:104] = sl[87:80];
       sr[103:96]  = sl[79:72];
       sr[95:88]   = sl[71:64];
       sr[87:80]   = sl[127:120];
       sr[79:72]   = sl[119:112];
       sr[71:64]   = sl[111:104];
   
       sr[63:56]   = sl[31:24];
       sr[55:48]   = sl[23:16];
       sr[47:40]   = sl[15:8];
       sr[39:32]   = sl[7:0];
       sr[31:24]   = sl[63:56];
       sr[23:16]   = sl[55:48];
       sr[15:8]    = sl[47:40];
       sr[7:0]     = sl[39:32];
		 end


endmodule