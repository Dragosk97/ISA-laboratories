/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP4
// Date      : Mon Nov  9 16:24:41 2020
/////////////////////////////////////////////////////////////


module FIR8_nbit7_TOT ( DIN, VIN, rst_n, clk, b0, b1, b2, b3, b4, b5, b6, b7, 
        b8, DOUT, VOUT );
  input [7:0] DIN;
  input [7:0] b0;
  input [7:0] b1;
  input [7:0] b2;
  input [7:0] b3;
  input [7:0] b4;
  input [7:0] b5;
  input [7:0] b6;
  input [7:0] b7;
  input [7:0] b8;
  output [7:0] DOUT;
  input VIN, rst_n, clk;
  output VOUT;
  wire   reg_coeff_en, reg_out_en, reg_rst_n, datapath_FIR_n2, datapath_FIR_n1,
         datapath_FIR_M0_10_, datapath_FIR_M0_11_, datapath_FIR_M0_12_,
         datapath_FIR_M0_6_, datapath_FIR_M0_7_, datapath_FIR_M0_8_,
         datapath_FIR_M0_9_, datapath_FIR_M1_10_, datapath_FIR_M1_11_,
         datapath_FIR_M1_12_, datapath_FIR_M1_6_, datapath_FIR_M1_7_,
         datapath_FIR_M1_8_, datapath_FIR_M1_9_, datapath_FIR_M2_10_,
         datapath_FIR_M2_11_, datapath_FIR_M2_12_, datapath_FIR_M2_6_,
         datapath_FIR_M2_7_, datapath_FIR_M2_8_, datapath_FIR_M2_9_,
         datapath_FIR_M3_10_, datapath_FIR_M3_11_, datapath_FIR_M3_12_,
         datapath_FIR_M3_6_, datapath_FIR_M3_7_, datapath_FIR_M3_8_,
         datapath_FIR_M3_9_, datapath_FIR_M4_10_, datapath_FIR_M4_11_,
         datapath_FIR_M4_12_, datapath_FIR_M4_6_, datapath_FIR_M4_7_,
         datapath_FIR_M4_8_, datapath_FIR_M4_9_, datapath_FIR_M5_10_,
         datapath_FIR_M5_11_, datapath_FIR_M5_12_, datapath_FIR_M5_6_,
         datapath_FIR_M5_7_, datapath_FIR_M5_8_, datapath_FIR_M5_9_,
         datapath_FIR_M6_10_, datapath_FIR_M6_11_, datapath_FIR_M6_12_,
         datapath_FIR_M6_6_, datapath_FIR_M6_7_, datapath_FIR_M6_8_,
         datapath_FIR_M6_9_, datapath_FIR_M7_10_, datapath_FIR_M7_11_,
         datapath_FIR_M7_12_, datapath_FIR_M7_6_, datapath_FIR_M7_7_,
         datapath_FIR_M7_8_, datapath_FIR_M7_9_, datapath_FIR_M8_10_,
         datapath_FIR_M8_11_, datapath_FIR_M8_12_, datapath_FIR_M8_6_,
         datapath_FIR_M8_7_, datapath_FIR_M8_8_, datapath_FIR_M8_9_,
         datapath_FIR_S0_0_, datapath_FIR_S0_1_, datapath_FIR_S0_2_,
         datapath_FIR_S0_3_, datapath_FIR_S0_4_, datapath_FIR_S0_5_,
         datapath_FIR_S0_6_, datapath_FIR_S1_0_, datapath_FIR_S1_1_,
         datapath_FIR_S1_2_, datapath_FIR_S1_3_, datapath_FIR_S1_4_,
         datapath_FIR_S1_5_, datapath_FIR_S1_6_, datapath_FIR_S2_0_,
         datapath_FIR_S2_1_, datapath_FIR_S2_2_, datapath_FIR_S2_3_,
         datapath_FIR_S2_4_, datapath_FIR_S2_5_, datapath_FIR_S2_6_,
         datapath_FIR_S3_0_, datapath_FIR_S3_1_, datapath_FIR_S3_2_,
         datapath_FIR_S3_3_, datapath_FIR_S3_4_, datapath_FIR_S3_5_,
         datapath_FIR_S3_6_, datapath_FIR_S4_0_, datapath_FIR_S4_1_,
         datapath_FIR_S4_2_, datapath_FIR_S4_3_, datapath_FIR_S4_4_,
         datapath_FIR_S4_5_, datapath_FIR_S4_6_, datapath_FIR_S5_0_,
         datapath_FIR_S5_1_, datapath_FIR_S5_2_, datapath_FIR_S5_3_,
         datapath_FIR_S5_4_, datapath_FIR_S5_5_, datapath_FIR_S5_6_,
         datapath_FIR_S6_0_, datapath_FIR_S6_1_, datapath_FIR_S6_2_,
         datapath_FIR_S6_3_, datapath_FIR_S6_4_, datapath_FIR_S6_5_,
         datapath_FIR_S6_6_, datapath_FIR_Reg_in_n8, datapath_FIR_Reg_in_n7,
         datapath_FIR_Reg_in_n6, datapath_FIR_Reg_in_n5,
         datapath_FIR_Reg_in_n4, datapath_FIR_Reg_in_n3,
         datapath_FIR_Reg_in_n2, datapath_FIR_Reg_in_n1,
         datapath_FIR_Reg_in_n17, datapath_FIR_Reg_in_n16,
         datapath_FIR_Reg_in_n15, datapath_FIR_Reg_in_n14,
         datapath_FIR_Reg_in_n13, datapath_FIR_Reg_in_n12,
         datapath_FIR_Reg_in_n11, datapath_FIR_Reg_in_n10,
         datapath_FIR_Reg_in_n9, datapath_FIR_Reg_coeff0_n26,
         datapath_FIR_Reg_coeff0_n25, datapath_FIR_Reg_coeff0_n24,
         datapath_FIR_Reg_coeff0_n23, datapath_FIR_Reg_coeff0_n22,
         datapath_FIR_Reg_coeff0_n21, datapath_FIR_Reg_coeff0_n20,
         datapath_FIR_Reg_coeff0_n19, datapath_FIR_Reg_coeff0_n18,
         datapath_FIR_Reg_coeff0_n8, datapath_FIR_Reg_coeff0_n7,
         datapath_FIR_Reg_coeff0_n6, datapath_FIR_Reg_coeff0_n5,
         datapath_FIR_Reg_coeff0_n4, datapath_FIR_Reg_coeff0_n3,
         datapath_FIR_Reg_coeff0_n2, datapath_FIR_Reg_coeff0_n1,
         datapath_FIR_Reg_coeff1_n26, datapath_FIR_Reg_coeff1_n25,
         datapath_FIR_Reg_coeff1_n24, datapath_FIR_Reg_coeff1_n23,
         datapath_FIR_Reg_coeff1_n22, datapath_FIR_Reg_coeff1_n21,
         datapath_FIR_Reg_coeff1_n20, datapath_FIR_Reg_coeff1_n19,
         datapath_FIR_Reg_coeff1_n18, datapath_FIR_Reg_coeff1_n8,
         datapath_FIR_Reg_coeff1_n7, datapath_FIR_Reg_coeff1_n6,
         datapath_FIR_Reg_coeff1_n5, datapath_FIR_Reg_coeff1_n4,
         datapath_FIR_Reg_coeff1_n3, datapath_FIR_Reg_coeff1_n2,
         datapath_FIR_Reg_coeff1_n1, datapath_FIR_Reg_coeff2_n26,
         datapath_FIR_Reg_coeff2_n25, datapath_FIR_Reg_coeff2_n24,
         datapath_FIR_Reg_coeff2_n23, datapath_FIR_Reg_coeff2_n22,
         datapath_FIR_Reg_coeff2_n21, datapath_FIR_Reg_coeff2_n20,
         datapath_FIR_Reg_coeff2_n19, datapath_FIR_Reg_coeff2_n18,
         datapath_FIR_Reg_coeff2_n8, datapath_FIR_Reg_coeff2_n7,
         datapath_FIR_Reg_coeff2_n6, datapath_FIR_Reg_coeff2_n5,
         datapath_FIR_Reg_coeff2_n4, datapath_FIR_Reg_coeff2_n3,
         datapath_FIR_Reg_coeff2_n2, datapath_FIR_Reg_coeff2_n1,
         datapath_FIR_Reg_coeff3_n30, datapath_FIR_Reg_coeff3_n29,
         datapath_FIR_Reg_coeff3_n28, datapath_FIR_Reg_coeff3_n27,
         datapath_FIR_Reg_coeff3_n26, datapath_FIR_Reg_coeff3_n25,
         datapath_FIR_Reg_coeff3_n24, datapath_FIR_Reg_coeff3_n23,
         datapath_FIR_Reg_coeff3_n22, datapath_FIR_Reg_coeff3_n21,
         datapath_FIR_Reg_coeff3_n20, datapath_FIR_Reg_coeff3_n19,
         datapath_FIR_Reg_coeff3_n18, datapath_FIR_Reg_coeff3_n8,
         datapath_FIR_Reg_coeff3_n7, datapath_FIR_Reg_coeff3_n6,
         datapath_FIR_Reg_coeff3_n5, datapath_FIR_Reg_coeff3_n4,
         datapath_FIR_Reg_coeff3_n3, datapath_FIR_Reg_coeff3_n2,
         datapath_FIR_Reg_coeff3_n1, datapath_FIR_Reg_coeff4_n26,
         datapath_FIR_Reg_coeff4_n25, datapath_FIR_Reg_coeff4_n24,
         datapath_FIR_Reg_coeff4_n23, datapath_FIR_Reg_coeff4_n22,
         datapath_FIR_Reg_coeff4_n21, datapath_FIR_Reg_coeff4_n20,
         datapath_FIR_Reg_coeff4_n19, datapath_FIR_Reg_coeff4_n18,
         datapath_FIR_Reg_coeff4_n8, datapath_FIR_Reg_coeff4_n7,
         datapath_FIR_Reg_coeff4_n6, datapath_FIR_Reg_coeff4_n5,
         datapath_FIR_Reg_coeff4_n4, datapath_FIR_Reg_coeff4_n3,
         datapath_FIR_Reg_coeff4_n2, datapath_FIR_Reg_coeff4_n1,
         datapath_FIR_Reg_coeff5_n30, datapath_FIR_Reg_coeff5_n29,
         datapath_FIR_Reg_coeff5_n28, datapath_FIR_Reg_coeff5_n27,
         datapath_FIR_Reg_coeff5_n26, datapath_FIR_Reg_coeff5_n25,
         datapath_FIR_Reg_coeff5_n24, datapath_FIR_Reg_coeff5_n23,
         datapath_FIR_Reg_coeff5_n22, datapath_FIR_Reg_coeff5_n21,
         datapath_FIR_Reg_coeff5_n20, datapath_FIR_Reg_coeff5_n19,
         datapath_FIR_Reg_coeff5_n18, datapath_FIR_Reg_coeff5_n8,
         datapath_FIR_Reg_coeff5_n7, datapath_FIR_Reg_coeff5_n6,
         datapath_FIR_Reg_coeff5_n5, datapath_FIR_Reg_coeff5_n4,
         datapath_FIR_Reg_coeff5_n3, datapath_FIR_Reg_coeff5_n2,
         datapath_FIR_Reg_coeff5_n1, datapath_FIR_Reg_coeff6_n26,
         datapath_FIR_Reg_coeff6_n25, datapath_FIR_Reg_coeff6_n24,
         datapath_FIR_Reg_coeff6_n23, datapath_FIR_Reg_coeff6_n22,
         datapath_FIR_Reg_coeff6_n21, datapath_FIR_Reg_coeff6_n20,
         datapath_FIR_Reg_coeff6_n19, datapath_FIR_Reg_coeff6_n18,
         datapath_FIR_Reg_coeff6_n8, datapath_FIR_Reg_coeff6_n7,
         datapath_FIR_Reg_coeff6_n6, datapath_FIR_Reg_coeff6_n5,
         datapath_FIR_Reg_coeff6_n4, datapath_FIR_Reg_coeff6_n3,
         datapath_FIR_Reg_coeff6_n2, datapath_FIR_Reg_coeff6_n1,
         datapath_FIR_Reg_coeff7_n27, datapath_FIR_Reg_coeff7_n26,
         datapath_FIR_Reg_coeff7_n25, datapath_FIR_Reg_coeff7_n24,
         datapath_FIR_Reg_coeff7_n23, datapath_FIR_Reg_coeff7_n22,
         datapath_FIR_Reg_coeff7_n21, datapath_FIR_Reg_coeff7_n20,
         datapath_FIR_Reg_coeff7_n19, datapath_FIR_Reg_coeff7_n18,
         datapath_FIR_Reg_coeff7_n8, datapath_FIR_Reg_coeff7_n7,
         datapath_FIR_Reg_coeff7_n6, datapath_FIR_Reg_coeff7_n5,
         datapath_FIR_Reg_coeff7_n4, datapath_FIR_Reg_coeff7_n3,
         datapath_FIR_Reg_coeff7_n2, datapath_FIR_Reg_coeff8_n28,
         datapath_FIR_Reg_coeff8_n27, datapath_FIR_Reg_coeff8_n26,
         datapath_FIR_Reg_coeff8_n25, datapath_FIR_Reg_coeff8_n24,
         datapath_FIR_Reg_coeff8_n23, datapath_FIR_Reg_coeff8_n22,
         datapath_FIR_Reg_coeff8_n21, datapath_FIR_Reg_coeff8_n20,
         datapath_FIR_Reg_coeff8_n19, datapath_FIR_Reg_coeff8_n18,
         datapath_FIR_Reg_coeff8_n8, datapath_FIR_Reg_coeff8_n7,
         datapath_FIR_Reg_coeff8_n6, datapath_FIR_Reg_coeff8_n5,
         datapath_FIR_Reg_coeff8_n4, datapath_FIR_Reg_coeff8_n3,
         datapath_FIR_Reg_coeff8_n2, datapath_FIR_Reg_coeff8_n1,
         datapath_FIR_Reg_Sample1_n26, datapath_FIR_Reg_Sample1_n25,
         datapath_FIR_Reg_Sample1_n24, datapath_FIR_Reg_Sample1_n23,
         datapath_FIR_Reg_Sample1_n22, datapath_FIR_Reg_Sample1_n21,
         datapath_FIR_Reg_Sample1_n20, datapath_FIR_Reg_Sample1_n19,
         datapath_FIR_Reg_Sample1_n18, datapath_FIR_Reg_Sample1_n8,
         datapath_FIR_Reg_Sample1_n7, datapath_FIR_Reg_Sample1_n6,
         datapath_FIR_Reg_Sample1_n5, datapath_FIR_Reg_Sample1_n4,
         datapath_FIR_Reg_Sample1_n3, datapath_FIR_Reg_Sample1_n2,
         datapath_FIR_Reg_Sample1_n1, datapath_FIR_Reg_Sample2_n26,
         datapath_FIR_Reg_Sample2_n25, datapath_FIR_Reg_Sample2_n24,
         datapath_FIR_Reg_Sample2_n23, datapath_FIR_Reg_Sample2_n22,
         datapath_FIR_Reg_Sample2_n21, datapath_FIR_Reg_Sample2_n20,
         datapath_FIR_Reg_Sample2_n19, datapath_FIR_Reg_Sample2_n18,
         datapath_FIR_Reg_Sample2_n8, datapath_FIR_Reg_Sample2_n7,
         datapath_FIR_Reg_Sample2_n6, datapath_FIR_Reg_Sample2_n5,
         datapath_FIR_Reg_Sample2_n4, datapath_FIR_Reg_Sample2_n3,
         datapath_FIR_Reg_Sample2_n2, datapath_FIR_Reg_Sample2_n1,
         datapath_FIR_Reg_Sample3_n29, datapath_FIR_Reg_Sample3_n28,
         datapath_FIR_Reg_Sample3_n27, datapath_FIR_Reg_Sample3_n26,
         datapath_FIR_Reg_Sample3_n25, datapath_FIR_Reg_Sample3_n24,
         datapath_FIR_Reg_Sample3_n23, datapath_FIR_Reg_Sample3_n22,
         datapath_FIR_Reg_Sample3_n21, datapath_FIR_Reg_Sample3_n20,
         datapath_FIR_Reg_Sample3_n19, datapath_FIR_Reg_Sample3_n18,
         datapath_FIR_Reg_Sample3_n8, datapath_FIR_Reg_Sample3_n7,
         datapath_FIR_Reg_Sample3_n6, datapath_FIR_Reg_Sample3_n5,
         datapath_FIR_Reg_Sample3_n4, datapath_FIR_Reg_Sample3_n3,
         datapath_FIR_Reg_Sample3_n2, datapath_FIR_Reg_Sample4_n26,
         datapath_FIR_Reg_Sample4_n25, datapath_FIR_Reg_Sample4_n24,
         datapath_FIR_Reg_Sample4_n23, datapath_FIR_Reg_Sample4_n22,
         datapath_FIR_Reg_Sample4_n21, datapath_FIR_Reg_Sample4_n20,
         datapath_FIR_Reg_Sample4_n19, datapath_FIR_Reg_Sample4_n18,
         datapath_FIR_Reg_Sample4_n8, datapath_FIR_Reg_Sample4_n7,
         datapath_FIR_Reg_Sample4_n6, datapath_FIR_Reg_Sample4_n5,
         datapath_FIR_Reg_Sample4_n4, datapath_FIR_Reg_Sample4_n3,
         datapath_FIR_Reg_Sample4_n2, datapath_FIR_Reg_Sample4_n1,
         datapath_FIR_Reg_Sample5_n33, datapath_FIR_Reg_Sample5_n32,
         datapath_FIR_Reg_Sample5_n31, datapath_FIR_Reg_Sample5_n30,
         datapath_FIR_Reg_Sample5_n29, datapath_FIR_Reg_Sample5_n28,
         datapath_FIR_Reg_Sample5_n27, datapath_FIR_Reg_Sample5_n26,
         datapath_FIR_Reg_Sample5_n25, datapath_FIR_Reg_Sample5_n24,
         datapath_FIR_Reg_Sample5_n23, datapath_FIR_Reg_Sample5_n22,
         datapath_FIR_Reg_Sample5_n21, datapath_FIR_Reg_Sample5_n20,
         datapath_FIR_Reg_Sample5_n19, datapath_FIR_Reg_Sample5_n18,
         datapath_FIR_Reg_Sample5_n8, datapath_FIR_Reg_Sample5_n6,
         datapath_FIR_Reg_Sample5_n5, datapath_FIR_Reg_Sample5_n4,
         datapath_FIR_Reg_Sample5_n3, datapath_FIR_Reg_Sample5_n2,
         datapath_FIR_Reg_Sample5_n1, datapath_FIR_Reg_Sample6_n26,
         datapath_FIR_Reg_Sample6_n25, datapath_FIR_Reg_Sample6_n24,
         datapath_FIR_Reg_Sample6_n23, datapath_FIR_Reg_Sample6_n22,
         datapath_FIR_Reg_Sample6_n21, datapath_FIR_Reg_Sample6_n20,
         datapath_FIR_Reg_Sample6_n19, datapath_FIR_Reg_Sample6_n18,
         datapath_FIR_Reg_Sample6_n8, datapath_FIR_Reg_Sample6_n7,
         datapath_FIR_Reg_Sample6_n6, datapath_FIR_Reg_Sample6_n5,
         datapath_FIR_Reg_Sample6_n4, datapath_FIR_Reg_Sample6_n3,
         datapath_FIR_Reg_Sample6_n2, datapath_FIR_Reg_Sample6_n1,
         datapath_FIR_Reg_Sample7_n29, datapath_FIR_Reg_Sample7_n28,
         datapath_FIR_Reg_Sample7_n27, datapath_FIR_Reg_Sample7_n26,
         datapath_FIR_Reg_Sample7_n25, datapath_FIR_Reg_Sample7_n24,
         datapath_FIR_Reg_Sample7_n23, datapath_FIR_Reg_Sample7_n22,
         datapath_FIR_Reg_Sample7_n21, datapath_FIR_Reg_Sample7_n20,
         datapath_FIR_Reg_Sample7_n19, datapath_FIR_Reg_Sample7_n18,
         datapath_FIR_Reg_Sample7_n8, datapath_FIR_Reg_Sample7_n7,
         datapath_FIR_Reg_Sample7_n6, datapath_FIR_Reg_Sample7_n5,
         datapath_FIR_Reg_Sample7_n4, datapath_FIR_Reg_Sample7_n2,
         datapath_FIR_Reg_Sample7_n1, datapath_FIR_Reg_Sample8_n30,
         datapath_FIR_Reg_Sample8_n29, datapath_FIR_Reg_Sample8_n28,
         datapath_FIR_Reg_Sample8_n27, datapath_FIR_Reg_Sample8_n26,
         datapath_FIR_Reg_Sample8_n25, datapath_FIR_Reg_Sample8_n24,
         datapath_FIR_Reg_Sample8_n23, datapath_FIR_Reg_Sample8_n22,
         datapath_FIR_Reg_Sample8_n21, datapath_FIR_Reg_Sample8_n20,
         datapath_FIR_Reg_Sample8_n19, datapath_FIR_Reg_Sample8_n18,
         datapath_FIR_Reg_Sample8_n8, datapath_FIR_Reg_Sample8_n7,
         datapath_FIR_Reg_Sample8_n6, datapath_FIR_Reg_Sample8_n5,
         datapath_FIR_Reg_Sample8_n4, datapath_FIR_Reg_Sample8_n3,
         datapath_FIR_Reg_Sample8_n2, datapath_FIR_Reg_Sample8_n1,
         datapath_FIR_Reg_out_n26, datapath_FIR_Reg_out_n25,
         datapath_FIR_Reg_out_n24, datapath_FIR_Reg_out_n23,
         datapath_FIR_Reg_out_n22, datapath_FIR_Reg_out_n21,
         datapath_FIR_Reg_out_n20, datapath_FIR_Reg_out_n19,
         datapath_FIR_Reg_out_n18, datapath_FIR_Reg_out_n8,
         datapath_FIR_Reg_out_n7, datapath_FIR_Reg_out_n6,
         datapath_FIR_Reg_out_n5, datapath_FIR_Reg_out_n4,
         datapath_FIR_Reg_out_n3, datapath_FIR_Reg_out_n2,
         datapath_FIR_Reg_out_n1, datapath_FIR_mult_205_n184,
         datapath_FIR_mult_205_n183, datapath_FIR_mult_205_n182,
         datapath_FIR_mult_205_n181, datapath_FIR_mult_205_n180,
         datapath_FIR_mult_205_n179, datapath_FIR_mult_205_n178,
         datapath_FIR_mult_205_n177, datapath_FIR_mult_205_n176,
         datapath_FIR_mult_205_n175, datapath_FIR_mult_205_n174,
         datapath_FIR_mult_205_n173, datapath_FIR_mult_205_n172,
         datapath_FIR_mult_205_n171, datapath_FIR_mult_205_n170,
         datapath_FIR_mult_205_n169, datapath_FIR_mult_205_n168,
         datapath_FIR_mult_205_n167, datapath_FIR_mult_205_n166,
         datapath_FIR_mult_205_n165, datapath_FIR_mult_205_n164,
         datapath_FIR_mult_205_n163, datapath_FIR_mult_205_n162,
         datapath_FIR_mult_205_n161, datapath_FIR_mult_205_n160,
         datapath_FIR_mult_205_n119, datapath_FIR_mult_205_n118,
         datapath_FIR_mult_205_n117, datapath_FIR_mult_205_n116,
         datapath_FIR_mult_205_n115, datapath_FIR_mult_205_n113,
         datapath_FIR_mult_205_n112, datapath_FIR_mult_205_n111,
         datapath_FIR_mult_205_n110, datapath_FIR_mult_205_n109,
         datapath_FIR_mult_205_n108, datapath_FIR_mult_205_n106,
         datapath_FIR_mult_205_n105, datapath_FIR_mult_205_n104,
         datapath_FIR_mult_205_n103, datapath_FIR_mult_205_n102,
         datapath_FIR_mult_205_n101, datapath_FIR_mult_205_n100,
         datapath_FIR_mult_205_n99, datapath_FIR_mult_205_n98,
         datapath_FIR_mult_205_n97, datapath_FIR_mult_205_n95,
         datapath_FIR_mult_205_n94, datapath_FIR_mult_205_n93,
         datapath_FIR_mult_205_n92, datapath_FIR_mult_205_n91,
         datapath_FIR_mult_205_n90, datapath_FIR_mult_205_n89,
         datapath_FIR_mult_205_n88, datapath_FIR_mult_205_n87,
         datapath_FIR_mult_205_n86, datapath_FIR_mult_205_n85,
         datapath_FIR_mult_205_n83, datapath_FIR_mult_205_n82,
         datapath_FIR_mult_205_n81, datapath_FIR_mult_205_n80,
         datapath_FIR_mult_205_n79, datapath_FIR_mult_205_n78,
         datapath_FIR_mult_205_n77, datapath_FIR_mult_205_n76,
         datapath_FIR_mult_205_n75, datapath_FIR_mult_205_n74,
         datapath_FIR_mult_205_n72, datapath_FIR_mult_205_n71,
         datapath_FIR_mult_205_n70, datapath_FIR_mult_205_n69,
         datapath_FIR_mult_205_n68, datapath_FIR_mult_205_n67,
         datapath_FIR_mult_205_n66, datapath_FIR_mult_205_n65,
         datapath_FIR_mult_205_n64, datapath_FIR_mult_205_n63,
         datapath_FIR_mult_205_n62, datapath_FIR_mult_205_n61,
         datapath_FIR_mult_205_n60, datapath_FIR_mult_205_n59,
         datapath_FIR_mult_205_n58, datapath_FIR_mult_205_n57,
         datapath_FIR_mult_205_n56, datapath_FIR_mult_205_n55,
         datapath_FIR_mult_205_n54, datapath_FIR_mult_205_n53,
         datapath_FIR_mult_205_n52, datapath_FIR_mult_205_n51,
         datapath_FIR_mult_205_n50, datapath_FIR_mult_205_n49,
         datapath_FIR_mult_205_n48, datapath_FIR_mult_205_n47,
         datapath_FIR_mult_205_n46, datapath_FIR_mult_205_n45,
         datapath_FIR_mult_205_n44, datapath_FIR_mult_205_n43,
         datapath_FIR_mult_205_n42, datapath_FIR_mult_205_n41,
         datapath_FIR_mult_205_n40, datapath_FIR_mult_205_n39,
         datapath_FIR_mult_205_n38, datapath_FIR_mult_205_n37,
         datapath_FIR_mult_205_n36, datapath_FIR_mult_205_n35,
         datapath_FIR_mult_205_n34, datapath_FIR_mult_205_n33,
         datapath_FIR_mult_205_n32, datapath_FIR_mult_205_n31,
         datapath_FIR_mult_205_n30, datapath_FIR_mult_205_n29,
         datapath_FIR_mult_205_n28, datapath_FIR_mult_205_n27,
         datapath_FIR_mult_205_n26, datapath_FIR_mult_205_n25,
         datapath_FIR_mult_205_n24, datapath_FIR_mult_205_n23,
         datapath_FIR_mult_205_n22, datapath_FIR_mult_205_n21,
         datapath_FIR_mult_205_n20, datapath_FIR_mult_205_n19,
         datapath_FIR_mult_205_n18, datapath_FIR_mult_205_n17,
         datapath_FIR_mult_205_n16, datapath_FIR_mult_205_n15,
         datapath_FIR_mult_205_n14, datapath_FIR_mult_205_n13,
         datapath_FIR_mult_205_n8, datapath_FIR_mult_205_n7,
         datapath_FIR_mult_205_n6, datapath_FIR_mult_205_n5,
         datapath_FIR_mult_205_n4, datapath_FIR_mult_205_n3,
         datapath_FIR_mult_205_n2, datapath_FIR_mult_206_n188,
         datapath_FIR_mult_206_n187, datapath_FIR_mult_206_n186,
         datapath_FIR_mult_206_n185, datapath_FIR_mult_206_n184,
         datapath_FIR_mult_206_n183, datapath_FIR_mult_206_n182,
         datapath_FIR_mult_206_n181, datapath_FIR_mult_206_n180,
         datapath_FIR_mult_206_n179, datapath_FIR_mult_206_n178,
         datapath_FIR_mult_206_n177, datapath_FIR_mult_206_n176,
         datapath_FIR_mult_206_n175, datapath_FIR_mult_206_n174,
         datapath_FIR_mult_206_n173, datapath_FIR_mult_206_n172,
         datapath_FIR_mult_206_n171, datapath_FIR_mult_206_n170,
         datapath_FIR_mult_206_n169, datapath_FIR_mult_206_n168,
         datapath_FIR_mult_206_n167, datapath_FIR_mult_206_n166,
         datapath_FIR_mult_206_n165, datapath_FIR_mult_206_n164,
         datapath_FIR_mult_206_n163, datapath_FIR_mult_206_n162,
         datapath_FIR_mult_206_n161, datapath_FIR_mult_206_n160,
         datapath_FIR_mult_206_n119, datapath_FIR_mult_206_n118,
         datapath_FIR_mult_206_n117, datapath_FIR_mult_206_n116,
         datapath_FIR_mult_206_n115, datapath_FIR_mult_206_n113,
         datapath_FIR_mult_206_n112, datapath_FIR_mult_206_n111,
         datapath_FIR_mult_206_n110, datapath_FIR_mult_206_n109,
         datapath_FIR_mult_206_n108, datapath_FIR_mult_206_n106,
         datapath_FIR_mult_206_n105, datapath_FIR_mult_206_n104,
         datapath_FIR_mult_206_n103, datapath_FIR_mult_206_n102,
         datapath_FIR_mult_206_n101, datapath_FIR_mult_206_n100,
         datapath_FIR_mult_206_n99, datapath_FIR_mult_206_n98,
         datapath_FIR_mult_206_n97, datapath_FIR_mult_206_n95,
         datapath_FIR_mult_206_n94, datapath_FIR_mult_206_n93,
         datapath_FIR_mult_206_n92, datapath_FIR_mult_206_n91,
         datapath_FIR_mult_206_n90, datapath_FIR_mult_206_n89,
         datapath_FIR_mult_206_n88, datapath_FIR_mult_206_n87,
         datapath_FIR_mult_206_n86, datapath_FIR_mult_206_n85,
         datapath_FIR_mult_206_n83, datapath_FIR_mult_206_n82,
         datapath_FIR_mult_206_n81, datapath_FIR_mult_206_n80,
         datapath_FIR_mult_206_n79, datapath_FIR_mult_206_n78,
         datapath_FIR_mult_206_n77, datapath_FIR_mult_206_n76,
         datapath_FIR_mult_206_n75, datapath_FIR_mult_206_n74,
         datapath_FIR_mult_206_n72, datapath_FIR_mult_206_n71,
         datapath_FIR_mult_206_n70, datapath_FIR_mult_206_n69,
         datapath_FIR_mult_206_n68, datapath_FIR_mult_206_n67,
         datapath_FIR_mult_206_n66, datapath_FIR_mult_206_n65,
         datapath_FIR_mult_206_n64, datapath_FIR_mult_206_n63,
         datapath_FIR_mult_206_n62, datapath_FIR_mult_206_n61,
         datapath_FIR_mult_206_n60, datapath_FIR_mult_206_n59,
         datapath_FIR_mult_206_n58, datapath_FIR_mult_206_n57,
         datapath_FIR_mult_206_n56, datapath_FIR_mult_206_n55,
         datapath_FIR_mult_206_n54, datapath_FIR_mult_206_n53,
         datapath_FIR_mult_206_n52, datapath_FIR_mult_206_n51,
         datapath_FIR_mult_206_n50, datapath_FIR_mult_206_n49,
         datapath_FIR_mult_206_n48, datapath_FIR_mult_206_n47,
         datapath_FIR_mult_206_n46, datapath_FIR_mult_206_n45,
         datapath_FIR_mult_206_n44, datapath_FIR_mult_206_n43,
         datapath_FIR_mult_206_n42, datapath_FIR_mult_206_n41,
         datapath_FIR_mult_206_n40, datapath_FIR_mult_206_n39,
         datapath_FIR_mult_206_n38, datapath_FIR_mult_206_n37,
         datapath_FIR_mult_206_n36, datapath_FIR_mult_206_n35,
         datapath_FIR_mult_206_n34, datapath_FIR_mult_206_n33,
         datapath_FIR_mult_206_n32, datapath_FIR_mult_206_n31,
         datapath_FIR_mult_206_n30, datapath_FIR_mult_206_n29,
         datapath_FIR_mult_206_n28, datapath_FIR_mult_206_n27,
         datapath_FIR_mult_206_n26, datapath_FIR_mult_206_n25,
         datapath_FIR_mult_206_n24, datapath_FIR_mult_206_n23,
         datapath_FIR_mult_206_n22, datapath_FIR_mult_206_n21,
         datapath_FIR_mult_206_n20, datapath_FIR_mult_206_n19,
         datapath_FIR_mult_206_n18, datapath_FIR_mult_206_n17,
         datapath_FIR_mult_206_n16, datapath_FIR_mult_206_n15,
         datapath_FIR_mult_206_n14, datapath_FIR_mult_206_n13,
         datapath_FIR_mult_206_n8, datapath_FIR_mult_206_n7,
         datapath_FIR_mult_206_n6, datapath_FIR_mult_206_n5,
         datapath_FIR_mult_206_n4, datapath_FIR_mult_206_n3,
         datapath_FIR_mult_206_n2, datapath_FIR_mult_213_n224,
         datapath_FIR_mult_213_n223, datapath_FIR_mult_213_n222,
         datapath_FIR_mult_213_n221, datapath_FIR_mult_213_n220,
         datapath_FIR_mult_213_n219, datapath_FIR_mult_213_n218,
         datapath_FIR_mult_213_n217, datapath_FIR_mult_213_n216,
         datapath_FIR_mult_213_n215, datapath_FIR_mult_213_n214,
         datapath_FIR_mult_213_n213, datapath_FIR_mult_213_n212,
         datapath_FIR_mult_213_n211, datapath_FIR_mult_213_n210,
         datapath_FIR_mult_213_n209, datapath_FIR_mult_213_n208,
         datapath_FIR_mult_213_n207, datapath_FIR_mult_213_n206,
         datapath_FIR_mult_213_n205, datapath_FIR_mult_213_n204,
         datapath_FIR_mult_213_n203, datapath_FIR_mult_213_n202,
         datapath_FIR_mult_213_n201, datapath_FIR_mult_213_n200,
         datapath_FIR_mult_213_n199, datapath_FIR_mult_213_n198,
         datapath_FIR_mult_213_n197, datapath_FIR_mult_213_n196,
         datapath_FIR_mult_213_n195, datapath_FIR_mult_213_n194,
         datapath_FIR_mult_213_n193, datapath_FIR_mult_213_n192,
         datapath_FIR_mult_213_n191, datapath_FIR_mult_213_n190,
         datapath_FIR_mult_213_n189, datapath_FIR_mult_213_n188,
         datapath_FIR_mult_213_n187, datapath_FIR_mult_213_n186,
         datapath_FIR_mult_213_n185, datapath_FIR_mult_213_n184,
         datapath_FIR_mult_213_n183, datapath_FIR_mult_213_n182,
         datapath_FIR_mult_213_n181, datapath_FIR_mult_213_n180,
         datapath_FIR_mult_213_n179, datapath_FIR_mult_213_n178,
         datapath_FIR_mult_213_n177, datapath_FIR_mult_213_n176,
         datapath_FIR_mult_213_n175, datapath_FIR_mult_213_n174,
         datapath_FIR_mult_213_n173, datapath_FIR_mult_213_n172,
         datapath_FIR_mult_213_n171, datapath_FIR_mult_213_n170,
         datapath_FIR_mult_213_n169, datapath_FIR_mult_213_n168,
         datapath_FIR_mult_213_n167, datapath_FIR_mult_213_n166,
         datapath_FIR_mult_213_n165, datapath_FIR_mult_213_n164,
         datapath_FIR_mult_213_n163, datapath_FIR_mult_213_n162,
         datapath_FIR_mult_213_n161, datapath_FIR_mult_213_n160,
         datapath_FIR_mult_213_n119, datapath_FIR_mult_213_n118,
         datapath_FIR_mult_213_n117, datapath_FIR_mult_213_n116,
         datapath_FIR_mult_213_n115, datapath_FIR_mult_213_n113,
         datapath_FIR_mult_213_n112, datapath_FIR_mult_213_n111,
         datapath_FIR_mult_213_n110, datapath_FIR_mult_213_n109,
         datapath_FIR_mult_213_n108, datapath_FIR_mult_213_n106,
         datapath_FIR_mult_213_n105, datapath_FIR_mult_213_n104,
         datapath_FIR_mult_213_n103, datapath_FIR_mult_213_n102,
         datapath_FIR_mult_213_n101, datapath_FIR_mult_213_n100,
         datapath_FIR_mult_213_n99, datapath_FIR_mult_213_n98,
         datapath_FIR_mult_213_n97, datapath_FIR_mult_213_n95,
         datapath_FIR_mult_213_n94, datapath_FIR_mult_213_n93,
         datapath_FIR_mult_213_n92, datapath_FIR_mult_213_n91,
         datapath_FIR_mult_213_n90, datapath_FIR_mult_213_n89,
         datapath_FIR_mult_213_n88, datapath_FIR_mult_213_n87,
         datapath_FIR_mult_213_n86, datapath_FIR_mult_213_n85,
         datapath_FIR_mult_213_n83, datapath_FIR_mult_213_n82,
         datapath_FIR_mult_213_n81, datapath_FIR_mult_213_n80,
         datapath_FIR_mult_213_n79, datapath_FIR_mult_213_n78,
         datapath_FIR_mult_213_n77, datapath_FIR_mult_213_n76,
         datapath_FIR_mult_213_n75, datapath_FIR_mult_213_n74,
         datapath_FIR_mult_213_n72, datapath_FIR_mult_213_n71,
         datapath_FIR_mult_213_n70, datapath_FIR_mult_213_n69,
         datapath_FIR_mult_213_n68, datapath_FIR_mult_213_n67,
         datapath_FIR_mult_213_n66, datapath_FIR_mult_213_n65,
         datapath_FIR_mult_213_n64, datapath_FIR_mult_213_n63,
         datapath_FIR_mult_213_n62, datapath_FIR_mult_213_n61,
         datapath_FIR_mult_213_n60, datapath_FIR_mult_213_n58,
         datapath_FIR_mult_213_n57, datapath_FIR_mult_213_n56,
         datapath_FIR_mult_213_n55, datapath_FIR_mult_213_n53,
         datapath_FIR_mult_213_n52, datapath_FIR_mult_213_n51,
         datapath_FIR_mult_213_n50, datapath_FIR_mult_213_n49,
         datapath_FIR_mult_213_n48, datapath_FIR_mult_213_n47,
         datapath_FIR_mult_213_n46, datapath_FIR_mult_213_n45,
         datapath_FIR_mult_213_n44, datapath_FIR_mult_213_n43,
         datapath_FIR_mult_213_n42, datapath_FIR_mult_213_n41,
         datapath_FIR_mult_213_n40, datapath_FIR_mult_213_n39,
         datapath_FIR_mult_213_n38, datapath_FIR_mult_213_n37,
         datapath_FIR_mult_213_n36, datapath_FIR_mult_213_n35,
         datapath_FIR_mult_213_n34, datapath_FIR_mult_213_n33,
         datapath_FIR_mult_213_n32, datapath_FIR_mult_213_n31,
         datapath_FIR_mult_213_n30, datapath_FIR_mult_213_n29,
         datapath_FIR_mult_213_n28, datapath_FIR_mult_213_n27,
         datapath_FIR_mult_213_n26, datapath_FIR_mult_213_n25,
         datapath_FIR_mult_213_n24, datapath_FIR_mult_213_n23,
         datapath_FIR_mult_213_n22, datapath_FIR_mult_213_n21,
         datapath_FIR_mult_213_n20, datapath_FIR_mult_213_n19,
         datapath_FIR_mult_213_n18, datapath_FIR_mult_213_n17,
         datapath_FIR_mult_213_n16, datapath_FIR_mult_213_n15,
         datapath_FIR_mult_213_n14, datapath_FIR_mult_213_n13,
         datapath_FIR_mult_213_n8, datapath_FIR_mult_213_n7,
         datapath_FIR_mult_213_n6, datapath_FIR_mult_213_n5,
         datapath_FIR_mult_213_n4, datapath_FIR_mult_213_n3,
         datapath_FIR_mult_213_n2, datapath_FIR_mult_210_n229,
         datapath_FIR_mult_210_n228, datapath_FIR_mult_210_n227,
         datapath_FIR_mult_210_n226, datapath_FIR_mult_210_n225,
         datapath_FIR_mult_210_n224, datapath_FIR_mult_210_n223,
         datapath_FIR_mult_210_n222, datapath_FIR_mult_210_n221,
         datapath_FIR_mult_210_n220, datapath_FIR_mult_210_n219,
         datapath_FIR_mult_210_n218, datapath_FIR_mult_210_n217,
         datapath_FIR_mult_210_n216, datapath_FIR_mult_210_n215,
         datapath_FIR_mult_210_n214, datapath_FIR_mult_210_n213,
         datapath_FIR_mult_210_n212, datapath_FIR_mult_210_n211,
         datapath_FIR_mult_210_n210, datapath_FIR_mult_210_n209,
         datapath_FIR_mult_210_n208, datapath_FIR_mult_210_n207,
         datapath_FIR_mult_210_n206, datapath_FIR_mult_210_n205,
         datapath_FIR_mult_210_n204, datapath_FIR_mult_210_n203,
         datapath_FIR_mult_210_n202, datapath_FIR_mult_210_n201,
         datapath_FIR_mult_210_n200, datapath_FIR_mult_210_n199,
         datapath_FIR_mult_210_n198, datapath_FIR_mult_210_n197,
         datapath_FIR_mult_210_n196, datapath_FIR_mult_210_n195,
         datapath_FIR_mult_210_n194, datapath_FIR_mult_210_n193,
         datapath_FIR_mult_210_n192, datapath_FIR_mult_210_n191,
         datapath_FIR_mult_210_n190, datapath_FIR_mult_210_n189,
         datapath_FIR_mult_210_n188, datapath_FIR_mult_210_n187,
         datapath_FIR_mult_210_n186, datapath_FIR_mult_210_n185,
         datapath_FIR_mult_210_n184, datapath_FIR_mult_210_n183,
         datapath_FIR_mult_210_n182, datapath_FIR_mult_210_n181,
         datapath_FIR_mult_210_n180, datapath_FIR_mult_210_n179,
         datapath_FIR_mult_210_n178, datapath_FIR_mult_210_n177,
         datapath_FIR_mult_210_n176, datapath_FIR_mult_210_n175,
         datapath_FIR_mult_210_n174, datapath_FIR_mult_210_n173,
         datapath_FIR_mult_210_n172, datapath_FIR_mult_210_n171,
         datapath_FIR_mult_210_n170, datapath_FIR_mult_210_n169,
         datapath_FIR_mult_210_n168, datapath_FIR_mult_210_n167,
         datapath_FIR_mult_210_n166, datapath_FIR_mult_210_n165,
         datapath_FIR_mult_210_n164, datapath_FIR_mult_210_n163,
         datapath_FIR_mult_210_n162, datapath_FIR_mult_210_n161,
         datapath_FIR_mult_210_n160, datapath_FIR_mult_210_n119,
         datapath_FIR_mult_210_n118, datapath_FIR_mult_210_n117,
         datapath_FIR_mult_210_n116, datapath_FIR_mult_210_n115,
         datapath_FIR_mult_210_n113, datapath_FIR_mult_210_n112,
         datapath_FIR_mult_210_n111, datapath_FIR_mult_210_n110,
         datapath_FIR_mult_210_n109, datapath_FIR_mult_210_n108,
         datapath_FIR_mult_210_n106, datapath_FIR_mult_210_n105,
         datapath_FIR_mult_210_n104, datapath_FIR_mult_210_n103,
         datapath_FIR_mult_210_n102, datapath_FIR_mult_210_n101,
         datapath_FIR_mult_210_n100, datapath_FIR_mult_210_n99,
         datapath_FIR_mult_210_n98, datapath_FIR_mult_210_n97,
         datapath_FIR_mult_210_n95, datapath_FIR_mult_210_n94,
         datapath_FIR_mult_210_n93, datapath_FIR_mult_210_n92,
         datapath_FIR_mult_210_n91, datapath_FIR_mult_210_n90,
         datapath_FIR_mult_210_n89, datapath_FIR_mult_210_n88,
         datapath_FIR_mult_210_n87, datapath_FIR_mult_210_n86,
         datapath_FIR_mult_210_n85, datapath_FIR_mult_210_n83,
         datapath_FIR_mult_210_n82, datapath_FIR_mult_210_n81,
         datapath_FIR_mult_210_n80, datapath_FIR_mult_210_n79,
         datapath_FIR_mult_210_n78, datapath_FIR_mult_210_n77,
         datapath_FIR_mult_210_n76, datapath_FIR_mult_210_n75,
         datapath_FIR_mult_210_n74, datapath_FIR_mult_210_n72,
         datapath_FIR_mult_210_n71, datapath_FIR_mult_210_n70,
         datapath_FIR_mult_210_n69, datapath_FIR_mult_210_n68,
         datapath_FIR_mult_210_n67, datapath_FIR_mult_210_n66,
         datapath_FIR_mult_210_n65, datapath_FIR_mult_210_n64,
         datapath_FIR_mult_210_n63, datapath_FIR_mult_210_n62,
         datapath_FIR_mult_210_n61, datapath_FIR_mult_210_n60,
         datapath_FIR_mult_210_n59, datapath_FIR_mult_210_n58,
         datapath_FIR_mult_210_n57, datapath_FIR_mult_210_n56,
         datapath_FIR_mult_210_n55, datapath_FIR_mult_210_n54,
         datapath_FIR_mult_210_n53, datapath_FIR_mult_210_n52,
         datapath_FIR_mult_210_n51, datapath_FIR_mult_210_n50,
         datapath_FIR_mult_210_n49, datapath_FIR_mult_210_n48,
         datapath_FIR_mult_210_n47, datapath_FIR_mult_210_n46,
         datapath_FIR_mult_210_n45, datapath_FIR_mult_210_n44,
         datapath_FIR_mult_210_n43, datapath_FIR_mult_210_n42,
         datapath_FIR_mult_210_n41, datapath_FIR_mult_210_n40,
         datapath_FIR_mult_210_n39, datapath_FIR_mult_210_n38,
         datapath_FIR_mult_210_n37, datapath_FIR_mult_210_n36,
         datapath_FIR_mult_210_n35, datapath_FIR_mult_210_n34,
         datapath_FIR_mult_210_n33, datapath_FIR_mult_210_n32,
         datapath_FIR_mult_210_n31, datapath_FIR_mult_210_n30,
         datapath_FIR_mult_210_n29, datapath_FIR_mult_210_n28,
         datapath_FIR_mult_210_n27, datapath_FIR_mult_210_n26,
         datapath_FIR_mult_210_n25, datapath_FIR_mult_210_n24,
         datapath_FIR_mult_210_n23, datapath_FIR_mult_210_n22,
         datapath_FIR_mult_210_n21, datapath_FIR_mult_210_n20,
         datapath_FIR_mult_210_n19, datapath_FIR_mult_210_n18,
         datapath_FIR_mult_210_n17, datapath_FIR_mult_210_n16,
         datapath_FIR_mult_210_n15, datapath_FIR_mult_210_n14,
         datapath_FIR_mult_210_n13, datapath_FIR_mult_210_n8,
         datapath_FIR_mult_210_n6, datapath_FIR_mult_210_n5,
         datapath_FIR_mult_210_n4, datapath_FIR_mult_210_n3,
         datapath_FIR_mult_210_n2,
         datapath_FIR_add_7_root_add_0_root_add_245_n3,
         datapath_FIR_add_7_root_add_0_root_add_245_n2,
         datapath_FIR_add_7_root_add_0_root_add_245_n1,
         datapath_FIR_mult_207_n187, datapath_FIR_mult_207_n186,
         datapath_FIR_mult_207_n185, datapath_FIR_mult_207_n184,
         datapath_FIR_mult_207_n183, datapath_FIR_mult_207_n182,
         datapath_FIR_mult_207_n181, datapath_FIR_mult_207_n180,
         datapath_FIR_mult_207_n179, datapath_FIR_mult_207_n178,
         datapath_FIR_mult_207_n177, datapath_FIR_mult_207_n176,
         datapath_FIR_mult_207_n175, datapath_FIR_mult_207_n174,
         datapath_FIR_mult_207_n173, datapath_FIR_mult_207_n172,
         datapath_FIR_mult_207_n171, datapath_FIR_mult_207_n170,
         datapath_FIR_mult_207_n169, datapath_FIR_mult_207_n168,
         datapath_FIR_mult_207_n167, datapath_FIR_mult_207_n166,
         datapath_FIR_mult_207_n165, datapath_FIR_mult_207_n164,
         datapath_FIR_mult_207_n163, datapath_FIR_mult_207_n162,
         datapath_FIR_mult_207_n161, datapath_FIR_mult_207_n160,
         datapath_FIR_mult_207_n119, datapath_FIR_mult_207_n118,
         datapath_FIR_mult_207_n117, datapath_FIR_mult_207_n116,
         datapath_FIR_mult_207_n115, datapath_FIR_mult_207_n113,
         datapath_FIR_mult_207_n112, datapath_FIR_mult_207_n111,
         datapath_FIR_mult_207_n110, datapath_FIR_mult_207_n109,
         datapath_FIR_mult_207_n108, datapath_FIR_mult_207_n106,
         datapath_FIR_mult_207_n105, datapath_FIR_mult_207_n104,
         datapath_FIR_mult_207_n103, datapath_FIR_mult_207_n102,
         datapath_FIR_mult_207_n101, datapath_FIR_mult_207_n100,
         datapath_FIR_mult_207_n99, datapath_FIR_mult_207_n98,
         datapath_FIR_mult_207_n97, datapath_FIR_mult_207_n95,
         datapath_FIR_mult_207_n94, datapath_FIR_mult_207_n93,
         datapath_FIR_mult_207_n92, datapath_FIR_mult_207_n91,
         datapath_FIR_mult_207_n90, datapath_FIR_mult_207_n89,
         datapath_FIR_mult_207_n88, datapath_FIR_mult_207_n87,
         datapath_FIR_mult_207_n86, datapath_FIR_mult_207_n85,
         datapath_FIR_mult_207_n83, datapath_FIR_mult_207_n82,
         datapath_FIR_mult_207_n81, datapath_FIR_mult_207_n80,
         datapath_FIR_mult_207_n79, datapath_FIR_mult_207_n78,
         datapath_FIR_mult_207_n77, datapath_FIR_mult_207_n76,
         datapath_FIR_mult_207_n75, datapath_FIR_mult_207_n74,
         datapath_FIR_mult_207_n72, datapath_FIR_mult_207_n71,
         datapath_FIR_mult_207_n70, datapath_FIR_mult_207_n69,
         datapath_FIR_mult_207_n68, datapath_FIR_mult_207_n67,
         datapath_FIR_mult_207_n66, datapath_FIR_mult_207_n65,
         datapath_FIR_mult_207_n64, datapath_FIR_mult_207_n63,
         datapath_FIR_mult_207_n62, datapath_FIR_mult_207_n61,
         datapath_FIR_mult_207_n60, datapath_FIR_mult_207_n59,
         datapath_FIR_mult_207_n58, datapath_FIR_mult_207_n57,
         datapath_FIR_mult_207_n56, datapath_FIR_mult_207_n55,
         datapath_FIR_mult_207_n54, datapath_FIR_mult_207_n53,
         datapath_FIR_mult_207_n52, datapath_FIR_mult_207_n51,
         datapath_FIR_mult_207_n50, datapath_FIR_mult_207_n49,
         datapath_FIR_mult_207_n48, datapath_FIR_mult_207_n47,
         datapath_FIR_mult_207_n46, datapath_FIR_mult_207_n45,
         datapath_FIR_mult_207_n44, datapath_FIR_mult_207_n43,
         datapath_FIR_mult_207_n42, datapath_FIR_mult_207_n41,
         datapath_FIR_mult_207_n40, datapath_FIR_mult_207_n39,
         datapath_FIR_mult_207_n38, datapath_FIR_mult_207_n37,
         datapath_FIR_mult_207_n36, datapath_FIR_mult_207_n35,
         datapath_FIR_mult_207_n34, datapath_FIR_mult_207_n33,
         datapath_FIR_mult_207_n32, datapath_FIR_mult_207_n31,
         datapath_FIR_mult_207_n30, datapath_FIR_mult_207_n29,
         datapath_FIR_mult_207_n28, datapath_FIR_mult_207_n27,
         datapath_FIR_mult_207_n26, datapath_FIR_mult_207_n25,
         datapath_FIR_mult_207_n24, datapath_FIR_mult_207_n23,
         datapath_FIR_mult_207_n22, datapath_FIR_mult_207_n21,
         datapath_FIR_mult_207_n20, datapath_FIR_mult_207_n19,
         datapath_FIR_mult_207_n18, datapath_FIR_mult_207_n17,
         datapath_FIR_mult_207_n16, datapath_FIR_mult_207_n15,
         datapath_FIR_mult_207_n14, datapath_FIR_mult_207_n13,
         datapath_FIR_mult_207_n8, datapath_FIR_mult_207_n7,
         datapath_FIR_mult_207_n6, datapath_FIR_mult_207_n5,
         datapath_FIR_mult_207_n4, datapath_FIR_mult_207_n3,
         datapath_FIR_mult_207_n2, datapath_FIR_mult_208_n232,
         datapath_FIR_mult_208_n231, datapath_FIR_mult_208_n230,
         datapath_FIR_mult_208_n229, datapath_FIR_mult_208_n228,
         datapath_FIR_mult_208_n227, datapath_FIR_mult_208_n226,
         datapath_FIR_mult_208_n225, datapath_FIR_mult_208_n224,
         datapath_FIR_mult_208_n223, datapath_FIR_mult_208_n222,
         datapath_FIR_mult_208_n221, datapath_FIR_mult_208_n220,
         datapath_FIR_mult_208_n219, datapath_FIR_mult_208_n218,
         datapath_FIR_mult_208_n217, datapath_FIR_mult_208_n216,
         datapath_FIR_mult_208_n215, datapath_FIR_mult_208_n214,
         datapath_FIR_mult_208_n213, datapath_FIR_mult_208_n212,
         datapath_FIR_mult_208_n211, datapath_FIR_mult_208_n210,
         datapath_FIR_mult_208_n209, datapath_FIR_mult_208_n208,
         datapath_FIR_mult_208_n207, datapath_FIR_mult_208_n206,
         datapath_FIR_mult_208_n205, datapath_FIR_mult_208_n204,
         datapath_FIR_mult_208_n203, datapath_FIR_mult_208_n202,
         datapath_FIR_mult_208_n201, datapath_FIR_mult_208_n200,
         datapath_FIR_mult_208_n199, datapath_FIR_mult_208_n198,
         datapath_FIR_mult_208_n197, datapath_FIR_mult_208_n196,
         datapath_FIR_mult_208_n195, datapath_FIR_mult_208_n194,
         datapath_FIR_mult_208_n193, datapath_FIR_mult_208_n192,
         datapath_FIR_mult_208_n191, datapath_FIR_mult_208_n190,
         datapath_FIR_mult_208_n189, datapath_FIR_mult_208_n188,
         datapath_FIR_mult_208_n187, datapath_FIR_mult_208_n186,
         datapath_FIR_mult_208_n185, datapath_FIR_mult_208_n184,
         datapath_FIR_mult_208_n183, datapath_FIR_mult_208_n182,
         datapath_FIR_mult_208_n181, datapath_FIR_mult_208_n180,
         datapath_FIR_mult_208_n179, datapath_FIR_mult_208_n178,
         datapath_FIR_mult_208_n177, datapath_FIR_mult_208_n176,
         datapath_FIR_mult_208_n175, datapath_FIR_mult_208_n174,
         datapath_FIR_mult_208_n173, datapath_FIR_mult_208_n172,
         datapath_FIR_mult_208_n171, datapath_FIR_mult_208_n170,
         datapath_FIR_mult_208_n169, datapath_FIR_mult_208_n168,
         datapath_FIR_mult_208_n167, datapath_FIR_mult_208_n166,
         datapath_FIR_mult_208_n165, datapath_FIR_mult_208_n164,
         datapath_FIR_mult_208_n163, datapath_FIR_mult_208_n162,
         datapath_FIR_mult_208_n161, datapath_FIR_mult_208_n160,
         datapath_FIR_mult_208_n119, datapath_FIR_mult_208_n118,
         datapath_FIR_mult_208_n117, datapath_FIR_mult_208_n116,
         datapath_FIR_mult_208_n115, datapath_FIR_mult_208_n113,
         datapath_FIR_mult_208_n112, datapath_FIR_mult_208_n111,
         datapath_FIR_mult_208_n110, datapath_FIR_mult_208_n109,
         datapath_FIR_mult_208_n108, datapath_FIR_mult_208_n106,
         datapath_FIR_mult_208_n105, datapath_FIR_mult_208_n104,
         datapath_FIR_mult_208_n103, datapath_FIR_mult_208_n102,
         datapath_FIR_mult_208_n101, datapath_FIR_mult_208_n100,
         datapath_FIR_mult_208_n99, datapath_FIR_mult_208_n98,
         datapath_FIR_mult_208_n97, datapath_FIR_mult_208_n95,
         datapath_FIR_mult_208_n94, datapath_FIR_mult_208_n93,
         datapath_FIR_mult_208_n92, datapath_FIR_mult_208_n91,
         datapath_FIR_mult_208_n90, datapath_FIR_mult_208_n89,
         datapath_FIR_mult_208_n88, datapath_FIR_mult_208_n87,
         datapath_FIR_mult_208_n86, datapath_FIR_mult_208_n85,
         datapath_FIR_mult_208_n83, datapath_FIR_mult_208_n82,
         datapath_FIR_mult_208_n81, datapath_FIR_mult_208_n80,
         datapath_FIR_mult_208_n79, datapath_FIR_mult_208_n78,
         datapath_FIR_mult_208_n77, datapath_FIR_mult_208_n76,
         datapath_FIR_mult_208_n75, datapath_FIR_mult_208_n74,
         datapath_FIR_mult_208_n72, datapath_FIR_mult_208_n71,
         datapath_FIR_mult_208_n70, datapath_FIR_mult_208_n69,
         datapath_FIR_mult_208_n68, datapath_FIR_mult_208_n67,
         datapath_FIR_mult_208_n66, datapath_FIR_mult_208_n65,
         datapath_FIR_mult_208_n64, datapath_FIR_mult_208_n63,
         datapath_FIR_mult_208_n62, datapath_FIR_mult_208_n61,
         datapath_FIR_mult_208_n60, datapath_FIR_mult_208_n58,
         datapath_FIR_mult_208_n57, datapath_FIR_mult_208_n56,
         datapath_FIR_mult_208_n55, datapath_FIR_mult_208_n53,
         datapath_FIR_mult_208_n52, datapath_FIR_mult_208_n51,
         datapath_FIR_mult_208_n50, datapath_FIR_mult_208_n49,
         datapath_FIR_mult_208_n48, datapath_FIR_mult_208_n47,
         datapath_FIR_mult_208_n46, datapath_FIR_mult_208_n45,
         datapath_FIR_mult_208_n44, datapath_FIR_mult_208_n43,
         datapath_FIR_mult_208_n42, datapath_FIR_mult_208_n41,
         datapath_FIR_mult_208_n40, datapath_FIR_mult_208_n39,
         datapath_FIR_mult_208_n38, datapath_FIR_mult_208_n37,
         datapath_FIR_mult_208_n36, datapath_FIR_mult_208_n35,
         datapath_FIR_mult_208_n34, datapath_FIR_mult_208_n33,
         datapath_FIR_mult_208_n32, datapath_FIR_mult_208_n31,
         datapath_FIR_mult_208_n30, datapath_FIR_mult_208_n29,
         datapath_FIR_mult_208_n28, datapath_FIR_mult_208_n27,
         datapath_FIR_mult_208_n26, datapath_FIR_mult_208_n25,
         datapath_FIR_mult_208_n24, datapath_FIR_mult_208_n23,
         datapath_FIR_mult_208_n22, datapath_FIR_mult_208_n21,
         datapath_FIR_mult_208_n20, datapath_FIR_mult_208_n19,
         datapath_FIR_mult_208_n18, datapath_FIR_mult_208_n17,
         datapath_FIR_mult_208_n16, datapath_FIR_mult_208_n15,
         datapath_FIR_mult_208_n14, datapath_FIR_mult_208_n13,
         datapath_FIR_mult_208_n8, datapath_FIR_mult_208_n6,
         datapath_FIR_mult_208_n5, datapath_FIR_mult_208_n4,
         datapath_FIR_mult_208_n3, datapath_FIR_mult_208_n2,
         datapath_FIR_mult_212_n223, datapath_FIR_mult_212_n222,
         datapath_FIR_mult_212_n221, datapath_FIR_mult_212_n220,
         datapath_FIR_mult_212_n219, datapath_FIR_mult_212_n218,
         datapath_FIR_mult_212_n217, datapath_FIR_mult_212_n216,
         datapath_FIR_mult_212_n215, datapath_FIR_mult_212_n214,
         datapath_FIR_mult_212_n213, datapath_FIR_mult_212_n212,
         datapath_FIR_mult_212_n211, datapath_FIR_mult_212_n210,
         datapath_FIR_mult_212_n209, datapath_FIR_mult_212_n208,
         datapath_FIR_mult_212_n207, datapath_FIR_mult_212_n206,
         datapath_FIR_mult_212_n205, datapath_FIR_mult_212_n204,
         datapath_FIR_mult_212_n203, datapath_FIR_mult_212_n202,
         datapath_FIR_mult_212_n201, datapath_FIR_mult_212_n200,
         datapath_FIR_mult_212_n199, datapath_FIR_mult_212_n198,
         datapath_FIR_mult_212_n197, datapath_FIR_mult_212_n196,
         datapath_FIR_mult_212_n195, datapath_FIR_mult_212_n194,
         datapath_FIR_mult_212_n193, datapath_FIR_mult_212_n192,
         datapath_FIR_mult_212_n191, datapath_FIR_mult_212_n190,
         datapath_FIR_mult_212_n189, datapath_FIR_mult_212_n188,
         datapath_FIR_mult_212_n187, datapath_FIR_mult_212_n186,
         datapath_FIR_mult_212_n185, datapath_FIR_mult_212_n184,
         datapath_FIR_mult_212_n183, datapath_FIR_mult_212_n182,
         datapath_FIR_mult_212_n181, datapath_FIR_mult_212_n180,
         datapath_FIR_mult_212_n179, datapath_FIR_mult_212_n178,
         datapath_FIR_mult_212_n177, datapath_FIR_mult_212_n176,
         datapath_FIR_mult_212_n175, datapath_FIR_mult_212_n174,
         datapath_FIR_mult_212_n173, datapath_FIR_mult_212_n172,
         datapath_FIR_mult_212_n171, datapath_FIR_mult_212_n170,
         datapath_FIR_mult_212_n169, datapath_FIR_mult_212_n168,
         datapath_FIR_mult_212_n167, datapath_FIR_mult_212_n166,
         datapath_FIR_mult_212_n165, datapath_FIR_mult_212_n164,
         datapath_FIR_mult_212_n163, datapath_FIR_mult_212_n162,
         datapath_FIR_mult_212_n161, datapath_FIR_mult_212_n160,
         datapath_FIR_mult_212_n119, datapath_FIR_mult_212_n118,
         datapath_FIR_mult_212_n117, datapath_FIR_mult_212_n116,
         datapath_FIR_mult_212_n115, datapath_FIR_mult_212_n113,
         datapath_FIR_mult_212_n112, datapath_FIR_mult_212_n111,
         datapath_FIR_mult_212_n110, datapath_FIR_mult_212_n109,
         datapath_FIR_mult_212_n108, datapath_FIR_mult_212_n106,
         datapath_FIR_mult_212_n105, datapath_FIR_mult_212_n104,
         datapath_FIR_mult_212_n103, datapath_FIR_mult_212_n102,
         datapath_FIR_mult_212_n101, datapath_FIR_mult_212_n100,
         datapath_FIR_mult_212_n99, datapath_FIR_mult_212_n98,
         datapath_FIR_mult_212_n97, datapath_FIR_mult_212_n95,
         datapath_FIR_mult_212_n94, datapath_FIR_mult_212_n93,
         datapath_FIR_mult_212_n91, datapath_FIR_mult_212_n90,
         datapath_FIR_mult_212_n89, datapath_FIR_mult_212_n88,
         datapath_FIR_mult_212_n87, datapath_FIR_mult_212_n86,
         datapath_FIR_mult_212_n85, datapath_FIR_mult_212_n83,
         datapath_FIR_mult_212_n82, datapath_FIR_mult_212_n81,
         datapath_FIR_mult_212_n80, datapath_FIR_mult_212_n79,
         datapath_FIR_mult_212_n78, datapath_FIR_mult_212_n77,
         datapath_FIR_mult_212_n76, datapath_FIR_mult_212_n75,
         datapath_FIR_mult_212_n74, datapath_FIR_mult_212_n72,
         datapath_FIR_mult_212_n71, datapath_FIR_mult_212_n70,
         datapath_FIR_mult_212_n69, datapath_FIR_mult_212_n68,
         datapath_FIR_mult_212_n67, datapath_FIR_mult_212_n66,
         datapath_FIR_mult_212_n65, datapath_FIR_mult_212_n64,
         datapath_FIR_mult_212_n63, datapath_FIR_mult_212_n62,
         datapath_FIR_mult_212_n61, datapath_FIR_mult_212_n60,
         datapath_FIR_mult_212_n58, datapath_FIR_mult_212_n57,
         datapath_FIR_mult_212_n56, datapath_FIR_mult_212_n55,
         datapath_FIR_mult_212_n54, datapath_FIR_mult_212_n53,
         datapath_FIR_mult_212_n52, datapath_FIR_mult_212_n51,
         datapath_FIR_mult_212_n50, datapath_FIR_mult_212_n49,
         datapath_FIR_mult_212_n48, datapath_FIR_mult_212_n47,
         datapath_FIR_mult_212_n46, datapath_FIR_mult_212_n45,
         datapath_FIR_mult_212_n44, datapath_FIR_mult_212_n43,
         datapath_FIR_mult_212_n42, datapath_FIR_mult_212_n41,
         datapath_FIR_mult_212_n40, datapath_FIR_mult_212_n39,
         datapath_FIR_mult_212_n38, datapath_FIR_mult_212_n37,
         datapath_FIR_mult_212_n36, datapath_FIR_mult_212_n35,
         datapath_FIR_mult_212_n34, datapath_FIR_mult_212_n33,
         datapath_FIR_mult_212_n32, datapath_FIR_mult_212_n31,
         datapath_FIR_mult_212_n30, datapath_FIR_mult_212_n29,
         datapath_FIR_mult_212_n28, datapath_FIR_mult_212_n27,
         datapath_FIR_mult_212_n26, datapath_FIR_mult_212_n25,
         datapath_FIR_mult_212_n24, datapath_FIR_mult_212_n23,
         datapath_FIR_mult_212_n22, datapath_FIR_mult_212_n21,
         datapath_FIR_mult_212_n20, datapath_FIR_mult_212_n19,
         datapath_FIR_mult_212_n18, datapath_FIR_mult_212_n17,
         datapath_FIR_mult_212_n16, datapath_FIR_mult_212_n15,
         datapath_FIR_mult_212_n14, datapath_FIR_mult_212_n13,
         datapath_FIR_mult_212_n8, datapath_FIR_mult_212_n7,
         datapath_FIR_mult_212_n6, datapath_FIR_mult_212_n5,
         datapath_FIR_mult_212_n4, datapath_FIR_mult_212_n3,
         datapath_FIR_mult_212_n2,
         datapath_FIR_add_6_root_add_0_root_add_245_n6,
         datapath_FIR_add_6_root_add_0_root_add_245_n5,
         datapath_FIR_add_6_root_add_0_root_add_245_n4,
         datapath_FIR_add_6_root_add_0_root_add_245_n3,
         datapath_FIR_add_6_root_add_0_root_add_245_n2,
         datapath_FIR_add_6_root_add_0_root_add_245_n1,
         datapath_FIR_add_2_root_add_0_root_add_245_n2,
         datapath_FIR_mult_209_n184, datapath_FIR_mult_209_n183,
         datapath_FIR_mult_209_n182, datapath_FIR_mult_209_n181,
         datapath_FIR_mult_209_n180, datapath_FIR_mult_209_n179,
         datapath_FIR_mult_209_n178, datapath_FIR_mult_209_n177,
         datapath_FIR_mult_209_n176, datapath_FIR_mult_209_n175,
         datapath_FIR_mult_209_n174, datapath_FIR_mult_209_n173,
         datapath_FIR_mult_209_n172, datapath_FIR_mult_209_n171,
         datapath_FIR_mult_209_n170, datapath_FIR_mult_209_n169,
         datapath_FIR_mult_209_n168, datapath_FIR_mult_209_n167,
         datapath_FIR_mult_209_n166, datapath_FIR_mult_209_n165,
         datapath_FIR_mult_209_n164, datapath_FIR_mult_209_n163,
         datapath_FIR_mult_209_n162, datapath_FIR_mult_209_n161,
         datapath_FIR_mult_209_n160, datapath_FIR_mult_209_n119,
         datapath_FIR_mult_209_n118, datapath_FIR_mult_209_n117,
         datapath_FIR_mult_209_n116, datapath_FIR_mult_209_n115,
         datapath_FIR_mult_209_n113, datapath_FIR_mult_209_n112,
         datapath_FIR_mult_209_n111, datapath_FIR_mult_209_n110,
         datapath_FIR_mult_209_n109, datapath_FIR_mult_209_n108,
         datapath_FIR_mult_209_n106, datapath_FIR_mult_209_n105,
         datapath_FIR_mult_209_n104, datapath_FIR_mult_209_n103,
         datapath_FIR_mult_209_n102, datapath_FIR_mult_209_n101,
         datapath_FIR_mult_209_n100, datapath_FIR_mult_209_n99,
         datapath_FIR_mult_209_n98, datapath_FIR_mult_209_n97,
         datapath_FIR_mult_209_n95, datapath_FIR_mult_209_n94,
         datapath_FIR_mult_209_n93, datapath_FIR_mult_209_n92,
         datapath_FIR_mult_209_n91, datapath_FIR_mult_209_n90,
         datapath_FIR_mult_209_n89, datapath_FIR_mult_209_n88,
         datapath_FIR_mult_209_n87, datapath_FIR_mult_209_n86,
         datapath_FIR_mult_209_n85, datapath_FIR_mult_209_n83,
         datapath_FIR_mult_209_n82, datapath_FIR_mult_209_n81,
         datapath_FIR_mult_209_n80, datapath_FIR_mult_209_n79,
         datapath_FIR_mult_209_n78, datapath_FIR_mult_209_n77,
         datapath_FIR_mult_209_n76, datapath_FIR_mult_209_n75,
         datapath_FIR_mult_209_n74, datapath_FIR_mult_209_n72,
         datapath_FIR_mult_209_n71, datapath_FIR_mult_209_n70,
         datapath_FIR_mult_209_n69, datapath_FIR_mult_209_n68,
         datapath_FIR_mult_209_n67, datapath_FIR_mult_209_n66,
         datapath_FIR_mult_209_n65, datapath_FIR_mult_209_n64,
         datapath_FIR_mult_209_n63, datapath_FIR_mult_209_n62,
         datapath_FIR_mult_209_n61, datapath_FIR_mult_209_n60,
         datapath_FIR_mult_209_n59, datapath_FIR_mult_209_n58,
         datapath_FIR_mult_209_n57, datapath_FIR_mult_209_n56,
         datapath_FIR_mult_209_n55, datapath_FIR_mult_209_n54,
         datapath_FIR_mult_209_n53, datapath_FIR_mult_209_n52,
         datapath_FIR_mult_209_n51, datapath_FIR_mult_209_n50,
         datapath_FIR_mult_209_n49, datapath_FIR_mult_209_n48,
         datapath_FIR_mult_209_n47, datapath_FIR_mult_209_n46,
         datapath_FIR_mult_209_n45, datapath_FIR_mult_209_n44,
         datapath_FIR_mult_209_n43, datapath_FIR_mult_209_n42,
         datapath_FIR_mult_209_n41, datapath_FIR_mult_209_n40,
         datapath_FIR_mult_209_n39, datapath_FIR_mult_209_n38,
         datapath_FIR_mult_209_n37, datapath_FIR_mult_209_n36,
         datapath_FIR_mult_209_n35, datapath_FIR_mult_209_n34,
         datapath_FIR_mult_209_n33, datapath_FIR_mult_209_n32,
         datapath_FIR_mult_209_n31, datapath_FIR_mult_209_n30,
         datapath_FIR_mult_209_n29, datapath_FIR_mult_209_n28,
         datapath_FIR_mult_209_n27, datapath_FIR_mult_209_n26,
         datapath_FIR_mult_209_n25, datapath_FIR_mult_209_n24,
         datapath_FIR_mult_209_n23, datapath_FIR_mult_209_n22,
         datapath_FIR_mult_209_n21, datapath_FIR_mult_209_n20,
         datapath_FIR_mult_209_n19, datapath_FIR_mult_209_n18,
         datapath_FIR_mult_209_n17, datapath_FIR_mult_209_n16,
         datapath_FIR_mult_209_n15, datapath_FIR_mult_209_n14,
         datapath_FIR_mult_209_n13, datapath_FIR_mult_209_n8,
         datapath_FIR_mult_209_n7, datapath_FIR_mult_209_n6,
         datapath_FIR_mult_209_n5, datapath_FIR_mult_209_n4,
         datapath_FIR_mult_209_n3, datapath_FIR_mult_209_n2,
         datapath_FIR_mult_211_n190, datapath_FIR_mult_211_n189,
         datapath_FIR_mult_211_n188, datapath_FIR_mult_211_n187,
         datapath_FIR_mult_211_n186, datapath_FIR_mult_211_n185,
         datapath_FIR_mult_211_n184, datapath_FIR_mult_211_n183,
         datapath_FIR_mult_211_n182, datapath_FIR_mult_211_n181,
         datapath_FIR_mult_211_n180, datapath_FIR_mult_211_n179,
         datapath_FIR_mult_211_n178, datapath_FIR_mult_211_n177,
         datapath_FIR_mult_211_n176, datapath_FIR_mult_211_n175,
         datapath_FIR_mult_211_n174, datapath_FIR_mult_211_n173,
         datapath_FIR_mult_211_n172, datapath_FIR_mult_211_n171,
         datapath_FIR_mult_211_n170, datapath_FIR_mult_211_n169,
         datapath_FIR_mult_211_n168, datapath_FIR_mult_211_n167,
         datapath_FIR_mult_211_n166, datapath_FIR_mult_211_n165,
         datapath_FIR_mult_211_n164, datapath_FIR_mult_211_n163,
         datapath_FIR_mult_211_n162, datapath_FIR_mult_211_n161,
         datapath_FIR_mult_211_n160, datapath_FIR_mult_211_n119,
         datapath_FIR_mult_211_n118, datapath_FIR_mult_211_n117,
         datapath_FIR_mult_211_n116, datapath_FIR_mult_211_n115,
         datapath_FIR_mult_211_n113, datapath_FIR_mult_211_n112,
         datapath_FIR_mult_211_n111, datapath_FIR_mult_211_n110,
         datapath_FIR_mult_211_n109, datapath_FIR_mult_211_n108,
         datapath_FIR_mult_211_n106, datapath_FIR_mult_211_n105,
         datapath_FIR_mult_211_n104, datapath_FIR_mult_211_n103,
         datapath_FIR_mult_211_n102, datapath_FIR_mult_211_n101,
         datapath_FIR_mult_211_n100, datapath_FIR_mult_211_n99,
         datapath_FIR_mult_211_n98, datapath_FIR_mult_211_n97,
         datapath_FIR_mult_211_n95, datapath_FIR_mult_211_n94,
         datapath_FIR_mult_211_n93, datapath_FIR_mult_211_n92,
         datapath_FIR_mult_211_n91, datapath_FIR_mult_211_n90,
         datapath_FIR_mult_211_n89, datapath_FIR_mult_211_n88,
         datapath_FIR_mult_211_n87, datapath_FIR_mult_211_n86,
         datapath_FIR_mult_211_n85, datapath_FIR_mult_211_n83,
         datapath_FIR_mult_211_n82, datapath_FIR_mult_211_n81,
         datapath_FIR_mult_211_n80, datapath_FIR_mult_211_n79,
         datapath_FIR_mult_211_n78, datapath_FIR_mult_211_n77,
         datapath_FIR_mult_211_n76, datapath_FIR_mult_211_n75,
         datapath_FIR_mult_211_n74, datapath_FIR_mult_211_n72,
         datapath_FIR_mult_211_n71, datapath_FIR_mult_211_n70,
         datapath_FIR_mult_211_n69, datapath_FIR_mult_211_n68,
         datapath_FIR_mult_211_n67, datapath_FIR_mult_211_n66,
         datapath_FIR_mult_211_n65, datapath_FIR_mult_211_n64,
         datapath_FIR_mult_211_n63, datapath_FIR_mult_211_n62,
         datapath_FIR_mult_211_n61, datapath_FIR_mult_211_n60,
         datapath_FIR_mult_211_n59, datapath_FIR_mult_211_n58,
         datapath_FIR_mult_211_n57, datapath_FIR_mult_211_n56,
         datapath_FIR_mult_211_n55, datapath_FIR_mult_211_n54,
         datapath_FIR_mult_211_n53, datapath_FIR_mult_211_n52,
         datapath_FIR_mult_211_n51, datapath_FIR_mult_211_n50,
         datapath_FIR_mult_211_n49, datapath_FIR_mult_211_n48,
         datapath_FIR_mult_211_n47, datapath_FIR_mult_211_n46,
         datapath_FIR_mult_211_n45, datapath_FIR_mult_211_n44,
         datapath_FIR_mult_211_n43, datapath_FIR_mult_211_n42,
         datapath_FIR_mult_211_n41, datapath_FIR_mult_211_n40,
         datapath_FIR_mult_211_n39, datapath_FIR_mult_211_n38,
         datapath_FIR_mult_211_n37, datapath_FIR_mult_211_n36,
         datapath_FIR_mult_211_n35, datapath_FIR_mult_211_n34,
         datapath_FIR_mult_211_n33, datapath_FIR_mult_211_n32,
         datapath_FIR_mult_211_n31, datapath_FIR_mult_211_n30,
         datapath_FIR_mult_211_n29, datapath_FIR_mult_211_n28,
         datapath_FIR_mult_211_n27, datapath_FIR_mult_211_n26,
         datapath_FIR_mult_211_n25, datapath_FIR_mult_211_n24,
         datapath_FIR_mult_211_n23, datapath_FIR_mult_211_n22,
         datapath_FIR_mult_211_n21, datapath_FIR_mult_211_n20,
         datapath_FIR_mult_211_n19, datapath_FIR_mult_211_n18,
         datapath_FIR_mult_211_n17, datapath_FIR_mult_211_n16,
         datapath_FIR_mult_211_n15, datapath_FIR_mult_211_n14,
         datapath_FIR_mult_211_n13, datapath_FIR_mult_211_n8,
         datapath_FIR_mult_211_n7, datapath_FIR_mult_211_n6,
         datapath_FIR_mult_211_n5, datapath_FIR_mult_211_n4,
         datapath_FIR_mult_211_n3, datapath_FIR_mult_211_n2,
         datapath_FIR_add_4_root_add_0_root_add_245_n1,
         datapath_FIR_add_3_root_add_0_root_add_245_n1,
         datapath_FIR_add_5_root_add_0_root_add_245_n1,
         datapath_FIR_add_1_root_add_0_root_add_245_n5,
         datapath_FIR_add_1_root_add_0_root_add_245_n4,
         datapath_FIR_add_1_root_add_0_root_add_245_n3,
         datapath_FIR_add_1_root_add_0_root_add_245_n2,
         datapath_FIR_add_1_root_add_0_root_add_245_n1,
         datapath_FIR_add_0_root_add_0_root_add_245_n6,
         datapath_FIR_add_0_root_add_0_root_add_245_n4,
         datapath_FIR_add_0_root_add_0_root_add_245_n3,
         datapath_FIR_add_0_root_add_0_root_add_245_n2,
         datapath_FIR_add_0_root_add_0_root_add_245_n1, control_unit_FIR_n6,
         control_unit_FIR_n5, control_unit_FIR_n3, control_unit_FIR_n1,
         control_unit_FIR_n12, control_unit_FIR_n11, control_unit_FIR_n10,
         control_unit_FIR_n9, control_unit_FIR_n8, control_unit_FIR_n7,
         control_unit_FIR_n4;
  wire   [6:0] datapath_FIR_Y;
  wire   [6:0] datapath_FIR_x8;
  wire   [6:0] datapath_FIR_x7;
  wire   [6:0] datapath_FIR_x6;
  wire   [6:0] datapath_FIR_x5;
  wire   [6:0] datapath_FIR_x4;
  wire   [6:0] datapath_FIR_x3;
  wire   [6:0] datapath_FIR_x2;
  wire   [6:0] datapath_FIR_x1;
  wire   [6:0] datapath_FIR_bq8;
  wire   [6:0] datapath_FIR_bq7;
  wire   [6:0] datapath_FIR_bq6;
  wire   [6:0] datapath_FIR_bq5;
  wire   [6:0] datapath_FIR_bq4;
  wire   [6:0] datapath_FIR_bq3;
  wire   [6:0] datapath_FIR_bq2;
  wire   [6:0] datapath_FIR_bq1;
  wire   [6:0] datapath_FIR_bq0;
  wire   [6:0] datapath_FIR_x0;
  wire   [6:2] datapath_FIR_add_7_root_add_0_root_add_245_carry;
  wire   [6:2] datapath_FIR_add_6_root_add_0_root_add_245_carry;
  wire   [6:2] datapath_FIR_add_2_root_add_0_root_add_245_carry;
  wire   [6:2] datapath_FIR_add_4_root_add_0_root_add_245_carry;
  wire   [6:2] datapath_FIR_add_3_root_add_0_root_add_245_carry;
  wire   [6:2] datapath_FIR_add_5_root_add_0_root_add_245_carry;
  wire   [6:2] datapath_FIR_add_1_root_add_0_root_add_245_carry;
  wire   [6:2] datapath_FIR_add_0_root_add_0_root_add_245_carry;
  wire   [2:1] control_unit_FIR_next_state;
  wire   [1:0] control_unit_FIR_present_state;
  assign DOUT[0] = 1'b0;

  CLKBUF_X1 datapath_FIR_U2 ( .A(datapath_FIR_x5[0]), .Z(datapath_FIR_n2) );
  CLKBUF_X1 datapath_FIR_U1 ( .A(datapath_FIR_x7[0]), .Z(datapath_FIR_n1) );
  AOI22_X1 datapath_FIR_Reg_in_U19 ( .A1(DIN[7]), .A2(datapath_FIR_Reg_in_n10), 
        .B1(datapath_FIR_x0[6]), .B2(datapath_FIR_Reg_in_n11), .ZN(
        datapath_FIR_Reg_in_n17) );
  INV_X1 datapath_FIR_Reg_in_U18 ( .A(datapath_FIR_Reg_in_n17), .ZN(
        datapath_FIR_Reg_in_n1) );
  AOI22_X1 datapath_FIR_Reg_in_U17 ( .A1(DIN[6]), .A2(datapath_FIR_Reg_in_n10), 
        .B1(datapath_FIR_x0[5]), .B2(datapath_FIR_Reg_in_n11), .ZN(
        datapath_FIR_Reg_in_n16) );
  INV_X1 datapath_FIR_Reg_in_U16 ( .A(datapath_FIR_Reg_in_n16), .ZN(
        datapath_FIR_Reg_in_n2) );
  AOI22_X1 datapath_FIR_Reg_in_U15 ( .A1(DIN[5]), .A2(datapath_FIR_Reg_in_n10), 
        .B1(datapath_FIR_x0[4]), .B2(datapath_FIR_Reg_in_n11), .ZN(
        datapath_FIR_Reg_in_n15) );
  INV_X1 datapath_FIR_Reg_in_U14 ( .A(datapath_FIR_Reg_in_n15), .ZN(
        datapath_FIR_Reg_in_n3) );
  AOI22_X1 datapath_FIR_Reg_in_U13 ( .A1(DIN[4]), .A2(datapath_FIR_Reg_in_n10), 
        .B1(datapath_FIR_x0[3]), .B2(datapath_FIR_Reg_in_n11), .ZN(
        datapath_FIR_Reg_in_n14) );
  INV_X1 datapath_FIR_Reg_in_U12 ( .A(datapath_FIR_Reg_in_n14), .ZN(
        datapath_FIR_Reg_in_n4) );
  AOI22_X1 datapath_FIR_Reg_in_U11 ( .A1(DIN[3]), .A2(datapath_FIR_Reg_in_n10), 
        .B1(datapath_FIR_x0[2]), .B2(datapath_FIR_Reg_in_n11), .ZN(
        datapath_FIR_Reg_in_n13) );
  INV_X1 datapath_FIR_Reg_in_U10 ( .A(datapath_FIR_Reg_in_n13), .ZN(
        datapath_FIR_Reg_in_n5) );
  AOI22_X1 datapath_FIR_Reg_in_U9 ( .A1(DIN[2]), .A2(datapath_FIR_Reg_in_n10), 
        .B1(datapath_FIR_x0[1]), .B2(datapath_FIR_Reg_in_n11), .ZN(
        datapath_FIR_Reg_in_n12) );
  INV_X1 datapath_FIR_Reg_in_U8 ( .A(datapath_FIR_Reg_in_n12), .ZN(
        datapath_FIR_Reg_in_n6) );
  AOI22_X1 datapath_FIR_Reg_in_U7 ( .A1(DIN[1]), .A2(datapath_FIR_Reg_in_n10), 
        .B1(datapath_FIR_x0[0]), .B2(datapath_FIR_Reg_in_n11), .ZN(
        datapath_FIR_Reg_in_n9) );
  INV_X1 datapath_FIR_Reg_in_U6 ( .A(datapath_FIR_Reg_in_n9), .ZN(
        datapath_FIR_Reg_in_n7) );
  INV_X1 datapath_FIR_Reg_in_U5 ( .A(reg_rst_n), .ZN(datapath_FIR_Reg_in_n8)
         );
  NOR2_X1 datapath_FIR_Reg_in_U4 ( .A1(reg_rst_n), .A2(datapath_FIR_Reg_in_n8), 
        .ZN(datapath_FIR_Reg_in_n11) );
  NOR2_X1 datapath_FIR_Reg_in_U3 ( .A1(datapath_FIR_Reg_in_n8), .A2(
        datapath_FIR_Reg_in_n11), .ZN(datapath_FIR_Reg_in_n10) );
  DFF_X1 datapath_FIR_Reg_in_q_reg_0_ ( .D(datapath_FIR_Reg_in_n7), .CK(clk), 
        .Q(datapath_FIR_x0[0]) );
  DFF_X1 datapath_FIR_Reg_in_q_reg_1_ ( .D(datapath_FIR_Reg_in_n6), .CK(clk), 
        .Q(datapath_FIR_x0[1]) );
  DFF_X1 datapath_FIR_Reg_in_q_reg_2_ ( .D(datapath_FIR_Reg_in_n5), .CK(clk), 
        .Q(datapath_FIR_x0[2]) );
  DFF_X1 datapath_FIR_Reg_in_q_reg_3_ ( .D(datapath_FIR_Reg_in_n4), .CK(clk), 
        .Q(datapath_FIR_x0[3]) );
  DFF_X1 datapath_FIR_Reg_in_q_reg_4_ ( .D(datapath_FIR_Reg_in_n3), .CK(clk), 
        .Q(datapath_FIR_x0[4]) );
  DFF_X1 datapath_FIR_Reg_in_q_reg_5_ ( .D(datapath_FIR_Reg_in_n2), .CK(clk), 
        .Q(datapath_FIR_x0[5]) );
  DFF_X1 datapath_FIR_Reg_in_q_reg_6_ ( .D(datapath_FIR_Reg_in_n1), .CK(clk), 
        .Q(datapath_FIR_x0[6]) );
  AOI22_X1 datapath_FIR_Reg_coeff0_U19 ( .A1(b0[7]), .A2(
        datapath_FIR_Reg_coeff0_n25), .B1(datapath_FIR_bq0[6]), .B2(
        datapath_FIR_Reg_coeff0_n24), .ZN(datapath_FIR_Reg_coeff0_n18) );
  INV_X1 datapath_FIR_Reg_coeff0_U18 ( .A(datapath_FIR_Reg_coeff0_n18), .ZN(
        datapath_FIR_Reg_coeff0_n1) );
  AOI22_X1 datapath_FIR_Reg_coeff0_U17 ( .A1(b0[6]), .A2(
        datapath_FIR_Reg_coeff0_n25), .B1(datapath_FIR_bq0[5]), .B2(
        datapath_FIR_Reg_coeff0_n24), .ZN(datapath_FIR_Reg_coeff0_n19) );
  INV_X1 datapath_FIR_Reg_coeff0_U16 ( .A(datapath_FIR_Reg_coeff0_n19), .ZN(
        datapath_FIR_Reg_coeff0_n2) );
  AOI22_X1 datapath_FIR_Reg_coeff0_U15 ( .A1(b0[5]), .A2(
        datapath_FIR_Reg_coeff0_n25), .B1(datapath_FIR_bq0[4]), .B2(
        datapath_FIR_Reg_coeff0_n24), .ZN(datapath_FIR_Reg_coeff0_n20) );
  INV_X1 datapath_FIR_Reg_coeff0_U14 ( .A(datapath_FIR_Reg_coeff0_n20), .ZN(
        datapath_FIR_Reg_coeff0_n3) );
  AOI22_X1 datapath_FIR_Reg_coeff0_U13 ( .A1(b0[4]), .A2(
        datapath_FIR_Reg_coeff0_n25), .B1(datapath_FIR_bq0[3]), .B2(
        datapath_FIR_Reg_coeff0_n24), .ZN(datapath_FIR_Reg_coeff0_n21) );
  INV_X1 datapath_FIR_Reg_coeff0_U12 ( .A(datapath_FIR_Reg_coeff0_n21), .ZN(
        datapath_FIR_Reg_coeff0_n4) );
  AOI22_X1 datapath_FIR_Reg_coeff0_U11 ( .A1(b0[3]), .A2(
        datapath_FIR_Reg_coeff0_n25), .B1(datapath_FIR_bq0[2]), .B2(
        datapath_FIR_Reg_coeff0_n24), .ZN(datapath_FIR_Reg_coeff0_n22) );
  INV_X1 datapath_FIR_Reg_coeff0_U10 ( .A(datapath_FIR_Reg_coeff0_n22), .ZN(
        datapath_FIR_Reg_coeff0_n5) );
  AOI22_X1 datapath_FIR_Reg_coeff0_U9 ( .A1(b0[2]), .A2(
        datapath_FIR_Reg_coeff0_n25), .B1(datapath_FIR_bq0[1]), .B2(
        datapath_FIR_Reg_coeff0_n24), .ZN(datapath_FIR_Reg_coeff0_n23) );
  INV_X1 datapath_FIR_Reg_coeff0_U8 ( .A(datapath_FIR_Reg_coeff0_n23), .ZN(
        datapath_FIR_Reg_coeff0_n6) );
  AOI22_X1 datapath_FIR_Reg_coeff0_U7 ( .A1(b0[1]), .A2(
        datapath_FIR_Reg_coeff0_n25), .B1(datapath_FIR_bq0[0]), .B2(
        datapath_FIR_Reg_coeff0_n24), .ZN(datapath_FIR_Reg_coeff0_n26) );
  INV_X1 datapath_FIR_Reg_coeff0_U6 ( .A(datapath_FIR_Reg_coeff0_n26), .ZN(
        datapath_FIR_Reg_coeff0_n7) );
  INV_X1 datapath_FIR_Reg_coeff0_U5 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_coeff0_n8) );
  NOR2_X1 datapath_FIR_Reg_coeff0_U4 ( .A1(reg_coeff_en), .A2(
        datapath_FIR_Reg_coeff0_n8), .ZN(datapath_FIR_Reg_coeff0_n24) );
  NOR2_X1 datapath_FIR_Reg_coeff0_U3 ( .A1(datapath_FIR_Reg_coeff0_n8), .A2(
        datapath_FIR_Reg_coeff0_n24), .ZN(datapath_FIR_Reg_coeff0_n25) );
  DFF_X1 datapath_FIR_Reg_coeff0_q_reg_0_ ( .D(datapath_FIR_Reg_coeff0_n7), 
        .CK(clk), .Q(datapath_FIR_bq0[0]) );
  DFF_X1 datapath_FIR_Reg_coeff0_q_reg_1_ ( .D(datapath_FIR_Reg_coeff0_n6), 
        .CK(clk), .Q(datapath_FIR_bq0[1]) );
  DFF_X1 datapath_FIR_Reg_coeff0_q_reg_2_ ( .D(datapath_FIR_Reg_coeff0_n5), 
        .CK(clk), .Q(datapath_FIR_bq0[2]) );
  DFF_X1 datapath_FIR_Reg_coeff0_q_reg_3_ ( .D(datapath_FIR_Reg_coeff0_n4), 
        .CK(clk), .Q(datapath_FIR_bq0[3]) );
  DFF_X1 datapath_FIR_Reg_coeff0_q_reg_4_ ( .D(datapath_FIR_Reg_coeff0_n3), 
        .CK(clk), .Q(datapath_FIR_bq0[4]) );
  DFF_X1 datapath_FIR_Reg_coeff0_q_reg_5_ ( .D(datapath_FIR_Reg_coeff0_n2), 
        .CK(clk), .Q(datapath_FIR_bq0[5]) );
  DFF_X1 datapath_FIR_Reg_coeff0_q_reg_6_ ( .D(datapath_FIR_Reg_coeff0_n1), 
        .CK(clk), .Q(datapath_FIR_bq0[6]) );
  AOI22_X1 datapath_FIR_Reg_coeff1_U19 ( .A1(b1[7]), .A2(
        datapath_FIR_Reg_coeff1_n25), .B1(datapath_FIR_bq1[6]), .B2(
        datapath_FIR_Reg_coeff1_n24), .ZN(datapath_FIR_Reg_coeff1_n18) );
  INV_X1 datapath_FIR_Reg_coeff1_U18 ( .A(datapath_FIR_Reg_coeff1_n18), .ZN(
        datapath_FIR_Reg_coeff1_n1) );
  AOI22_X1 datapath_FIR_Reg_coeff1_U17 ( .A1(b1[6]), .A2(
        datapath_FIR_Reg_coeff1_n25), .B1(datapath_FIR_bq1[5]), .B2(
        datapath_FIR_Reg_coeff1_n24), .ZN(datapath_FIR_Reg_coeff1_n19) );
  INV_X1 datapath_FIR_Reg_coeff1_U16 ( .A(datapath_FIR_Reg_coeff1_n19), .ZN(
        datapath_FIR_Reg_coeff1_n2) );
  AOI22_X1 datapath_FIR_Reg_coeff1_U15 ( .A1(b1[5]), .A2(
        datapath_FIR_Reg_coeff1_n25), .B1(datapath_FIR_bq1[4]), .B2(
        datapath_FIR_Reg_coeff1_n24), .ZN(datapath_FIR_Reg_coeff1_n20) );
  INV_X1 datapath_FIR_Reg_coeff1_U14 ( .A(datapath_FIR_Reg_coeff1_n20), .ZN(
        datapath_FIR_Reg_coeff1_n3) );
  AOI22_X1 datapath_FIR_Reg_coeff1_U13 ( .A1(b1[4]), .A2(
        datapath_FIR_Reg_coeff1_n25), .B1(datapath_FIR_bq1[3]), .B2(
        datapath_FIR_Reg_coeff1_n24), .ZN(datapath_FIR_Reg_coeff1_n21) );
  INV_X1 datapath_FIR_Reg_coeff1_U12 ( .A(datapath_FIR_Reg_coeff1_n21), .ZN(
        datapath_FIR_Reg_coeff1_n4) );
  AOI22_X1 datapath_FIR_Reg_coeff1_U11 ( .A1(b1[3]), .A2(
        datapath_FIR_Reg_coeff1_n25), .B1(datapath_FIR_bq1[2]), .B2(
        datapath_FIR_Reg_coeff1_n24), .ZN(datapath_FIR_Reg_coeff1_n22) );
  INV_X1 datapath_FIR_Reg_coeff1_U10 ( .A(datapath_FIR_Reg_coeff1_n22), .ZN(
        datapath_FIR_Reg_coeff1_n5) );
  AOI22_X1 datapath_FIR_Reg_coeff1_U9 ( .A1(b1[2]), .A2(
        datapath_FIR_Reg_coeff1_n25), .B1(datapath_FIR_bq1[1]), .B2(
        datapath_FIR_Reg_coeff1_n24), .ZN(datapath_FIR_Reg_coeff1_n23) );
  INV_X1 datapath_FIR_Reg_coeff1_U8 ( .A(datapath_FIR_Reg_coeff1_n23), .ZN(
        datapath_FIR_Reg_coeff1_n6) );
  AOI22_X1 datapath_FIR_Reg_coeff1_U7 ( .A1(b1[1]), .A2(
        datapath_FIR_Reg_coeff1_n25), .B1(datapath_FIR_bq1[0]), .B2(
        datapath_FIR_Reg_coeff1_n24), .ZN(datapath_FIR_Reg_coeff1_n26) );
  INV_X1 datapath_FIR_Reg_coeff1_U6 ( .A(datapath_FIR_Reg_coeff1_n26), .ZN(
        datapath_FIR_Reg_coeff1_n7) );
  INV_X1 datapath_FIR_Reg_coeff1_U5 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_coeff1_n8) );
  NOR2_X1 datapath_FIR_Reg_coeff1_U4 ( .A1(reg_coeff_en), .A2(
        datapath_FIR_Reg_coeff1_n8), .ZN(datapath_FIR_Reg_coeff1_n24) );
  NOR2_X1 datapath_FIR_Reg_coeff1_U3 ( .A1(datapath_FIR_Reg_coeff1_n8), .A2(
        datapath_FIR_Reg_coeff1_n24), .ZN(datapath_FIR_Reg_coeff1_n25) );
  DFF_X1 datapath_FIR_Reg_coeff1_q_reg_0_ ( .D(datapath_FIR_Reg_coeff1_n7), 
        .CK(clk), .Q(datapath_FIR_bq1[0]) );
  DFF_X1 datapath_FIR_Reg_coeff1_q_reg_1_ ( .D(datapath_FIR_Reg_coeff1_n6), 
        .CK(clk), .Q(datapath_FIR_bq1[1]) );
  DFF_X1 datapath_FIR_Reg_coeff1_q_reg_2_ ( .D(datapath_FIR_Reg_coeff1_n5), 
        .CK(clk), .Q(datapath_FIR_bq1[2]) );
  DFF_X1 datapath_FIR_Reg_coeff1_q_reg_3_ ( .D(datapath_FIR_Reg_coeff1_n4), 
        .CK(clk), .Q(datapath_FIR_bq1[3]) );
  DFF_X1 datapath_FIR_Reg_coeff1_q_reg_4_ ( .D(datapath_FIR_Reg_coeff1_n3), 
        .CK(clk), .Q(datapath_FIR_bq1[4]) );
  DFF_X1 datapath_FIR_Reg_coeff1_q_reg_5_ ( .D(datapath_FIR_Reg_coeff1_n2), 
        .CK(clk), .Q(datapath_FIR_bq1[5]) );
  DFF_X1 datapath_FIR_Reg_coeff1_q_reg_6_ ( .D(datapath_FIR_Reg_coeff1_n1), 
        .CK(clk), .Q(datapath_FIR_bq1[6]) );
  AOI22_X1 datapath_FIR_Reg_coeff2_U19 ( .A1(b2[7]), .A2(
        datapath_FIR_Reg_coeff2_n25), .B1(datapath_FIR_bq2[6]), .B2(
        datapath_FIR_Reg_coeff2_n24), .ZN(datapath_FIR_Reg_coeff2_n18) );
  INV_X1 datapath_FIR_Reg_coeff2_U18 ( .A(datapath_FIR_Reg_coeff2_n18), .ZN(
        datapath_FIR_Reg_coeff2_n1) );
  AOI22_X1 datapath_FIR_Reg_coeff2_U17 ( .A1(b2[6]), .A2(
        datapath_FIR_Reg_coeff2_n25), .B1(datapath_FIR_bq2[5]), .B2(
        datapath_FIR_Reg_coeff2_n24), .ZN(datapath_FIR_Reg_coeff2_n19) );
  INV_X1 datapath_FIR_Reg_coeff2_U16 ( .A(datapath_FIR_Reg_coeff2_n19), .ZN(
        datapath_FIR_Reg_coeff2_n2) );
  AOI22_X1 datapath_FIR_Reg_coeff2_U15 ( .A1(b2[5]), .A2(
        datapath_FIR_Reg_coeff2_n25), .B1(datapath_FIR_bq2[4]), .B2(
        datapath_FIR_Reg_coeff2_n24), .ZN(datapath_FIR_Reg_coeff2_n20) );
  INV_X1 datapath_FIR_Reg_coeff2_U14 ( .A(datapath_FIR_Reg_coeff2_n20), .ZN(
        datapath_FIR_Reg_coeff2_n3) );
  AOI22_X1 datapath_FIR_Reg_coeff2_U13 ( .A1(b2[4]), .A2(
        datapath_FIR_Reg_coeff2_n25), .B1(datapath_FIR_bq2[3]), .B2(
        datapath_FIR_Reg_coeff2_n24), .ZN(datapath_FIR_Reg_coeff2_n21) );
  INV_X1 datapath_FIR_Reg_coeff2_U12 ( .A(datapath_FIR_Reg_coeff2_n21), .ZN(
        datapath_FIR_Reg_coeff2_n4) );
  AOI22_X1 datapath_FIR_Reg_coeff2_U11 ( .A1(b2[3]), .A2(
        datapath_FIR_Reg_coeff2_n25), .B1(datapath_FIR_bq2[2]), .B2(
        datapath_FIR_Reg_coeff2_n24), .ZN(datapath_FIR_Reg_coeff2_n22) );
  INV_X1 datapath_FIR_Reg_coeff2_U10 ( .A(datapath_FIR_Reg_coeff2_n22), .ZN(
        datapath_FIR_Reg_coeff2_n5) );
  AOI22_X1 datapath_FIR_Reg_coeff2_U9 ( .A1(b2[2]), .A2(
        datapath_FIR_Reg_coeff2_n25), .B1(datapath_FIR_bq2[1]), .B2(
        datapath_FIR_Reg_coeff2_n24), .ZN(datapath_FIR_Reg_coeff2_n23) );
  INV_X1 datapath_FIR_Reg_coeff2_U8 ( .A(datapath_FIR_Reg_coeff2_n23), .ZN(
        datapath_FIR_Reg_coeff2_n6) );
  AOI22_X1 datapath_FIR_Reg_coeff2_U7 ( .A1(b2[1]), .A2(
        datapath_FIR_Reg_coeff2_n25), .B1(datapath_FIR_bq2[0]), .B2(
        datapath_FIR_Reg_coeff2_n24), .ZN(datapath_FIR_Reg_coeff2_n26) );
  INV_X1 datapath_FIR_Reg_coeff2_U6 ( .A(datapath_FIR_Reg_coeff2_n26), .ZN(
        datapath_FIR_Reg_coeff2_n7) );
  INV_X1 datapath_FIR_Reg_coeff2_U5 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_coeff2_n8) );
  NOR2_X1 datapath_FIR_Reg_coeff2_U4 ( .A1(reg_coeff_en), .A2(
        datapath_FIR_Reg_coeff2_n8), .ZN(datapath_FIR_Reg_coeff2_n24) );
  NOR2_X1 datapath_FIR_Reg_coeff2_U3 ( .A1(datapath_FIR_Reg_coeff2_n8), .A2(
        datapath_FIR_Reg_coeff2_n24), .ZN(datapath_FIR_Reg_coeff2_n25) );
  DFF_X1 datapath_FIR_Reg_coeff2_q_reg_0_ ( .D(datapath_FIR_Reg_coeff2_n7), 
        .CK(clk), .Q(datapath_FIR_bq2[0]) );
  DFF_X1 datapath_FIR_Reg_coeff2_q_reg_1_ ( .D(datapath_FIR_Reg_coeff2_n6), 
        .CK(clk), .Q(datapath_FIR_bq2[1]) );
  DFF_X1 datapath_FIR_Reg_coeff2_q_reg_2_ ( .D(datapath_FIR_Reg_coeff2_n5), 
        .CK(clk), .Q(datapath_FIR_bq2[2]) );
  DFF_X1 datapath_FIR_Reg_coeff2_q_reg_3_ ( .D(datapath_FIR_Reg_coeff2_n4), 
        .CK(clk), .Q(datapath_FIR_bq2[3]) );
  DFF_X1 datapath_FIR_Reg_coeff2_q_reg_4_ ( .D(datapath_FIR_Reg_coeff2_n3), 
        .CK(clk), .Q(datapath_FIR_bq2[4]) );
  DFF_X1 datapath_FIR_Reg_coeff2_q_reg_5_ ( .D(datapath_FIR_Reg_coeff2_n2), 
        .CK(clk), .Q(datapath_FIR_bq2[5]) );
  DFF_X1 datapath_FIR_Reg_coeff2_q_reg_6_ ( .D(datapath_FIR_Reg_coeff2_n1), 
        .CK(clk), .Q(datapath_FIR_bq2[6]) );
  AOI22_X1 datapath_FIR_Reg_coeff3_U21 ( .A1(b3[3]), .A2(
        datapath_FIR_Reg_coeff3_n29), .B1(datapath_FIR_Reg_coeff3_n4), .B2(
        datapath_FIR_Reg_coeff3_n28), .ZN(datapath_FIR_Reg_coeff3_n26) );
  AOI22_X1 datapath_FIR_Reg_coeff3_U20 ( .A1(b3[2]), .A2(
        datapath_FIR_Reg_coeff3_n29), .B1(datapath_FIR_Reg_coeff3_n2), .B2(
        datapath_FIR_Reg_coeff3_n28), .ZN(datapath_FIR_Reg_coeff3_n27) );
  AOI22_X1 datapath_FIR_Reg_coeff3_U19 ( .A1(b3[7]), .A2(
        datapath_FIR_Reg_coeff3_n29), .B1(datapath_FIR_bq3[6]), .B2(
        datapath_FIR_Reg_coeff3_n28), .ZN(datapath_FIR_Reg_coeff3_n22) );
  INV_X1 datapath_FIR_Reg_coeff3_U18 ( .A(datapath_FIR_Reg_coeff3_n22), .ZN(
        datapath_FIR_Reg_coeff3_n5) );
  AOI22_X1 datapath_FIR_Reg_coeff3_U17 ( .A1(b3[6]), .A2(
        datapath_FIR_Reg_coeff3_n29), .B1(datapath_FIR_bq3[5]), .B2(
        datapath_FIR_Reg_coeff3_n28), .ZN(datapath_FIR_Reg_coeff3_n23) );
  INV_X1 datapath_FIR_Reg_coeff3_U16 ( .A(datapath_FIR_Reg_coeff3_n23), .ZN(
        datapath_FIR_Reg_coeff3_n6) );
  AOI22_X1 datapath_FIR_Reg_coeff3_U15 ( .A1(b3[5]), .A2(
        datapath_FIR_Reg_coeff3_n29), .B1(datapath_FIR_bq3[4]), .B2(
        datapath_FIR_Reg_coeff3_n28), .ZN(datapath_FIR_Reg_coeff3_n24) );
  INV_X1 datapath_FIR_Reg_coeff3_U14 ( .A(datapath_FIR_Reg_coeff3_n24), .ZN(
        datapath_FIR_Reg_coeff3_n7) );
  AOI22_X1 datapath_FIR_Reg_coeff3_U13 ( .A1(b3[4]), .A2(
        datapath_FIR_Reg_coeff3_n29), .B1(datapath_FIR_bq3[3]), .B2(
        datapath_FIR_Reg_coeff3_n28), .ZN(datapath_FIR_Reg_coeff3_n25) );
  INV_X1 datapath_FIR_Reg_coeff3_U12 ( .A(datapath_FIR_Reg_coeff3_n25), .ZN(
        datapath_FIR_Reg_coeff3_n8) );
  AOI22_X1 datapath_FIR_Reg_coeff3_U11 ( .A1(b3[1]), .A2(
        datapath_FIR_Reg_coeff3_n29), .B1(datapath_FIR_bq3[0]), .B2(
        datapath_FIR_Reg_coeff3_n28), .ZN(datapath_FIR_Reg_coeff3_n30) );
  INV_X1 datapath_FIR_Reg_coeff3_U10 ( .A(datapath_FIR_Reg_coeff3_n30), .ZN(
        datapath_FIR_Reg_coeff3_n20) );
  INV_X1 datapath_FIR_Reg_coeff3_U9 ( .A(datapath_FIR_Reg_coeff3_n27), .ZN(
        datapath_FIR_Reg_coeff3_n19) );
  INV_X1 datapath_FIR_Reg_coeff3_U8 ( .A(datapath_FIR_Reg_coeff3_n26), .ZN(
        datapath_FIR_Reg_coeff3_n18) );
  INV_X1 datapath_FIR_Reg_coeff3_U7 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_coeff3_n21) );
  NOR2_X1 datapath_FIR_Reg_coeff3_U6 ( .A1(reg_coeff_en), .A2(
        datapath_FIR_Reg_coeff3_n21), .ZN(datapath_FIR_Reg_coeff3_n28) );
  NOR2_X1 datapath_FIR_Reg_coeff3_U5 ( .A1(datapath_FIR_Reg_coeff3_n21), .A2(
        datapath_FIR_Reg_coeff3_n28), .ZN(datapath_FIR_Reg_coeff3_n29) );
  INV_X1 datapath_FIR_Reg_coeff3_U4 ( .A(datapath_FIR_Reg_coeff3_n3), .ZN(
        datapath_FIR_Reg_coeff3_n4) );
  INV_X1 datapath_FIR_Reg_coeff3_U3 ( .A(datapath_FIR_Reg_coeff3_n1), .ZN(
        datapath_FIR_Reg_coeff3_n2) );
  DFF_X1 datapath_FIR_Reg_coeff3_q_reg_0_ ( .D(datapath_FIR_Reg_coeff3_n20), 
        .CK(clk), .Q(datapath_FIR_bq3[0]) );
  DFF_X1 datapath_FIR_Reg_coeff3_q_reg_2_ ( .D(datapath_FIR_Reg_coeff3_n18), 
        .CK(clk), .Q(datapath_FIR_bq3[2]), .QN(datapath_FIR_Reg_coeff3_n3) );
  DFF_X1 datapath_FIR_Reg_coeff3_q_reg_1_ ( .D(datapath_FIR_Reg_coeff3_n19), 
        .CK(clk), .Q(datapath_FIR_bq3[1]), .QN(datapath_FIR_Reg_coeff3_n1) );
  DFF_X1 datapath_FIR_Reg_coeff3_q_reg_3_ ( .D(datapath_FIR_Reg_coeff3_n8), 
        .CK(clk), .Q(datapath_FIR_bq3[3]) );
  DFF_X1 datapath_FIR_Reg_coeff3_q_reg_4_ ( .D(datapath_FIR_Reg_coeff3_n7), 
        .CK(clk), .Q(datapath_FIR_bq3[4]) );
  DFF_X1 datapath_FIR_Reg_coeff3_q_reg_5_ ( .D(datapath_FIR_Reg_coeff3_n6), 
        .CK(clk), .Q(datapath_FIR_bq3[5]) );
  DFF_X1 datapath_FIR_Reg_coeff3_q_reg_6_ ( .D(datapath_FIR_Reg_coeff3_n5), 
        .CK(clk), .Q(datapath_FIR_bq3[6]) );
  AOI22_X1 datapath_FIR_Reg_coeff4_U19 ( .A1(b4[7]), .A2(
        datapath_FIR_Reg_coeff4_n25), .B1(datapath_FIR_bq4[6]), .B2(
        datapath_FIR_Reg_coeff4_n24), .ZN(datapath_FIR_Reg_coeff4_n18) );
  INV_X1 datapath_FIR_Reg_coeff4_U18 ( .A(datapath_FIR_Reg_coeff4_n18), .ZN(
        datapath_FIR_Reg_coeff4_n1) );
  AOI22_X1 datapath_FIR_Reg_coeff4_U17 ( .A1(b4[6]), .A2(
        datapath_FIR_Reg_coeff4_n25), .B1(datapath_FIR_bq4[5]), .B2(
        datapath_FIR_Reg_coeff4_n24), .ZN(datapath_FIR_Reg_coeff4_n19) );
  INV_X1 datapath_FIR_Reg_coeff4_U16 ( .A(datapath_FIR_Reg_coeff4_n19), .ZN(
        datapath_FIR_Reg_coeff4_n2) );
  AOI22_X1 datapath_FIR_Reg_coeff4_U15 ( .A1(b4[5]), .A2(
        datapath_FIR_Reg_coeff4_n25), .B1(datapath_FIR_bq4[4]), .B2(
        datapath_FIR_Reg_coeff4_n24), .ZN(datapath_FIR_Reg_coeff4_n20) );
  INV_X1 datapath_FIR_Reg_coeff4_U14 ( .A(datapath_FIR_Reg_coeff4_n20), .ZN(
        datapath_FIR_Reg_coeff4_n3) );
  AOI22_X1 datapath_FIR_Reg_coeff4_U13 ( .A1(b4[4]), .A2(
        datapath_FIR_Reg_coeff4_n25), .B1(datapath_FIR_bq4[3]), .B2(
        datapath_FIR_Reg_coeff4_n24), .ZN(datapath_FIR_Reg_coeff4_n21) );
  INV_X1 datapath_FIR_Reg_coeff4_U12 ( .A(datapath_FIR_Reg_coeff4_n21), .ZN(
        datapath_FIR_Reg_coeff4_n4) );
  AOI22_X1 datapath_FIR_Reg_coeff4_U11 ( .A1(b4[3]), .A2(
        datapath_FIR_Reg_coeff4_n25), .B1(datapath_FIR_bq4[2]), .B2(
        datapath_FIR_Reg_coeff4_n24), .ZN(datapath_FIR_Reg_coeff4_n22) );
  INV_X1 datapath_FIR_Reg_coeff4_U10 ( .A(datapath_FIR_Reg_coeff4_n22), .ZN(
        datapath_FIR_Reg_coeff4_n5) );
  AOI22_X1 datapath_FIR_Reg_coeff4_U9 ( .A1(b4[2]), .A2(
        datapath_FIR_Reg_coeff4_n25), .B1(datapath_FIR_bq4[1]), .B2(
        datapath_FIR_Reg_coeff4_n24), .ZN(datapath_FIR_Reg_coeff4_n23) );
  INV_X1 datapath_FIR_Reg_coeff4_U8 ( .A(datapath_FIR_Reg_coeff4_n23), .ZN(
        datapath_FIR_Reg_coeff4_n6) );
  AOI22_X1 datapath_FIR_Reg_coeff4_U7 ( .A1(b4[1]), .A2(
        datapath_FIR_Reg_coeff4_n25), .B1(datapath_FIR_bq4[0]), .B2(
        datapath_FIR_Reg_coeff4_n24), .ZN(datapath_FIR_Reg_coeff4_n26) );
  INV_X1 datapath_FIR_Reg_coeff4_U6 ( .A(datapath_FIR_Reg_coeff4_n26), .ZN(
        datapath_FIR_Reg_coeff4_n7) );
  INV_X1 datapath_FIR_Reg_coeff4_U5 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_coeff4_n8) );
  NOR2_X1 datapath_FIR_Reg_coeff4_U4 ( .A1(reg_coeff_en), .A2(
        datapath_FIR_Reg_coeff4_n8), .ZN(datapath_FIR_Reg_coeff4_n24) );
  NOR2_X1 datapath_FIR_Reg_coeff4_U3 ( .A1(datapath_FIR_Reg_coeff4_n8), .A2(
        datapath_FIR_Reg_coeff4_n24), .ZN(datapath_FIR_Reg_coeff4_n25) );
  DFF_X1 datapath_FIR_Reg_coeff4_q_reg_0_ ( .D(datapath_FIR_Reg_coeff4_n7), 
        .CK(clk), .Q(datapath_FIR_bq4[0]) );
  DFF_X1 datapath_FIR_Reg_coeff4_q_reg_1_ ( .D(datapath_FIR_Reg_coeff4_n6), 
        .CK(clk), .Q(datapath_FIR_bq4[1]) );
  DFF_X1 datapath_FIR_Reg_coeff4_q_reg_2_ ( .D(datapath_FIR_Reg_coeff4_n5), 
        .CK(clk), .Q(datapath_FIR_bq4[2]) );
  DFF_X1 datapath_FIR_Reg_coeff4_q_reg_3_ ( .D(datapath_FIR_Reg_coeff4_n4), 
        .CK(clk), .Q(datapath_FIR_bq4[3]) );
  DFF_X1 datapath_FIR_Reg_coeff4_q_reg_4_ ( .D(datapath_FIR_Reg_coeff4_n3), 
        .CK(clk), .Q(datapath_FIR_bq4[4]) );
  DFF_X1 datapath_FIR_Reg_coeff4_q_reg_5_ ( .D(datapath_FIR_Reg_coeff4_n2), 
        .CK(clk), .Q(datapath_FIR_bq4[5]) );
  DFF_X1 datapath_FIR_Reg_coeff4_q_reg_6_ ( .D(datapath_FIR_Reg_coeff4_n1), 
        .CK(clk), .Q(datapath_FIR_bq4[6]) );
  AOI22_X1 datapath_FIR_Reg_coeff5_U21 ( .A1(b5[3]), .A2(
        datapath_FIR_Reg_coeff5_n29), .B1(datapath_FIR_Reg_coeff5_n2), .B2(
        datapath_FIR_Reg_coeff5_n28), .ZN(datapath_FIR_Reg_coeff5_n26) );
  INV_X1 datapath_FIR_Reg_coeff5_U20 ( .A(datapath_FIR_Reg_coeff5_n26), .ZN(
        datapath_FIR_Reg_coeff5_n18) );
  AOI22_X1 datapath_FIR_Reg_coeff5_U19 ( .A1(b5[7]), .A2(
        datapath_FIR_Reg_coeff5_n29), .B1(datapath_FIR_bq5[6]), .B2(
        datapath_FIR_Reg_coeff5_n28), .ZN(datapath_FIR_Reg_coeff5_n22) );
  INV_X1 datapath_FIR_Reg_coeff5_U18 ( .A(datapath_FIR_Reg_coeff5_n22), .ZN(
        datapath_FIR_Reg_coeff5_n5) );
  AOI22_X1 datapath_FIR_Reg_coeff5_U17 ( .A1(b5[6]), .A2(
        datapath_FIR_Reg_coeff5_n29), .B1(datapath_FIR_bq5[5]), .B2(
        datapath_FIR_Reg_coeff5_n28), .ZN(datapath_FIR_Reg_coeff5_n23) );
  INV_X1 datapath_FIR_Reg_coeff5_U16 ( .A(datapath_FIR_Reg_coeff5_n23), .ZN(
        datapath_FIR_Reg_coeff5_n6) );
  AOI22_X1 datapath_FIR_Reg_coeff5_U15 ( .A1(b5[5]), .A2(
        datapath_FIR_Reg_coeff5_n29), .B1(datapath_FIR_bq5[4]), .B2(
        datapath_FIR_Reg_coeff5_n28), .ZN(datapath_FIR_Reg_coeff5_n24) );
  INV_X1 datapath_FIR_Reg_coeff5_U14 ( .A(datapath_FIR_Reg_coeff5_n24), .ZN(
        datapath_FIR_Reg_coeff5_n7) );
  AOI22_X1 datapath_FIR_Reg_coeff5_U13 ( .A1(b5[4]), .A2(
        datapath_FIR_Reg_coeff5_n29), .B1(datapath_FIR_bq5[3]), .B2(
        datapath_FIR_Reg_coeff5_n28), .ZN(datapath_FIR_Reg_coeff5_n25) );
  INV_X1 datapath_FIR_Reg_coeff5_U12 ( .A(datapath_FIR_Reg_coeff5_n25), .ZN(
        datapath_FIR_Reg_coeff5_n8) );
  AOI22_X1 datapath_FIR_Reg_coeff5_U11 ( .A1(b5[2]), .A2(
        datapath_FIR_Reg_coeff5_n29), .B1(datapath_FIR_Reg_coeff5_n4), .B2(
        datapath_FIR_Reg_coeff5_n28), .ZN(datapath_FIR_Reg_coeff5_n27) );
  INV_X1 datapath_FIR_Reg_coeff5_U10 ( .A(datapath_FIR_Reg_coeff5_n27), .ZN(
        datapath_FIR_Reg_coeff5_n19) );
  AOI22_X1 datapath_FIR_Reg_coeff5_U9 ( .A1(b5[1]), .A2(
        datapath_FIR_Reg_coeff5_n29), .B1(datapath_FIR_bq5[0]), .B2(
        datapath_FIR_Reg_coeff5_n28), .ZN(datapath_FIR_Reg_coeff5_n30) );
  INV_X1 datapath_FIR_Reg_coeff5_U8 ( .A(datapath_FIR_Reg_coeff5_n30), .ZN(
        datapath_FIR_Reg_coeff5_n20) );
  INV_X1 datapath_FIR_Reg_coeff5_U7 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_coeff5_n21) );
  NOR2_X1 datapath_FIR_Reg_coeff5_U6 ( .A1(reg_coeff_en), .A2(
        datapath_FIR_Reg_coeff5_n21), .ZN(datapath_FIR_Reg_coeff5_n28) );
  NOR2_X1 datapath_FIR_Reg_coeff5_U5 ( .A1(datapath_FIR_Reg_coeff5_n21), .A2(
        datapath_FIR_Reg_coeff5_n28), .ZN(datapath_FIR_Reg_coeff5_n29) );
  INV_X1 datapath_FIR_Reg_coeff5_U4 ( .A(datapath_FIR_Reg_coeff5_n3), .ZN(
        datapath_FIR_Reg_coeff5_n4) );
  INV_X1 datapath_FIR_Reg_coeff5_U3 ( .A(datapath_FIR_Reg_coeff5_n1), .ZN(
        datapath_FIR_Reg_coeff5_n2) );
  DFF_X1 datapath_FIR_Reg_coeff5_q_reg_2_ ( .D(datapath_FIR_Reg_coeff5_n18), 
        .CK(clk), .Q(datapath_FIR_bq5[2]), .QN(datapath_FIR_Reg_coeff5_n1) );
  DFF_X1 datapath_FIR_Reg_coeff5_q_reg_0_ ( .D(datapath_FIR_Reg_coeff5_n20), 
        .CK(clk), .Q(datapath_FIR_bq5[0]) );
  DFF_X1 datapath_FIR_Reg_coeff5_q_reg_1_ ( .D(datapath_FIR_Reg_coeff5_n19), 
        .CK(clk), .Q(datapath_FIR_bq5[1]), .QN(datapath_FIR_Reg_coeff5_n3) );
  DFF_X1 datapath_FIR_Reg_coeff5_q_reg_3_ ( .D(datapath_FIR_Reg_coeff5_n8), 
        .CK(clk), .Q(datapath_FIR_bq5[3]) );
  DFF_X1 datapath_FIR_Reg_coeff5_q_reg_4_ ( .D(datapath_FIR_Reg_coeff5_n7), 
        .CK(clk), .Q(datapath_FIR_bq5[4]) );
  DFF_X1 datapath_FIR_Reg_coeff5_q_reg_5_ ( .D(datapath_FIR_Reg_coeff5_n6), 
        .CK(clk), .Q(datapath_FIR_bq5[5]) );
  DFF_X1 datapath_FIR_Reg_coeff5_q_reg_6_ ( .D(datapath_FIR_Reg_coeff5_n5), 
        .CK(clk), .Q(datapath_FIR_bq5[6]) );
  AOI22_X1 datapath_FIR_Reg_coeff6_U19 ( .A1(b6[7]), .A2(
        datapath_FIR_Reg_coeff6_n25), .B1(datapath_FIR_bq6[6]), .B2(
        datapath_FIR_Reg_coeff6_n24), .ZN(datapath_FIR_Reg_coeff6_n18) );
  INV_X1 datapath_FIR_Reg_coeff6_U18 ( .A(datapath_FIR_Reg_coeff6_n18), .ZN(
        datapath_FIR_Reg_coeff6_n1) );
  AOI22_X1 datapath_FIR_Reg_coeff6_U17 ( .A1(b6[6]), .A2(
        datapath_FIR_Reg_coeff6_n25), .B1(datapath_FIR_bq6[5]), .B2(
        datapath_FIR_Reg_coeff6_n24), .ZN(datapath_FIR_Reg_coeff6_n19) );
  INV_X1 datapath_FIR_Reg_coeff6_U16 ( .A(datapath_FIR_Reg_coeff6_n19), .ZN(
        datapath_FIR_Reg_coeff6_n2) );
  AOI22_X1 datapath_FIR_Reg_coeff6_U15 ( .A1(b6[5]), .A2(
        datapath_FIR_Reg_coeff6_n25), .B1(datapath_FIR_bq6[4]), .B2(
        datapath_FIR_Reg_coeff6_n24), .ZN(datapath_FIR_Reg_coeff6_n20) );
  INV_X1 datapath_FIR_Reg_coeff6_U14 ( .A(datapath_FIR_Reg_coeff6_n20), .ZN(
        datapath_FIR_Reg_coeff6_n3) );
  AOI22_X1 datapath_FIR_Reg_coeff6_U13 ( .A1(b6[4]), .A2(
        datapath_FIR_Reg_coeff6_n25), .B1(datapath_FIR_bq6[3]), .B2(
        datapath_FIR_Reg_coeff6_n24), .ZN(datapath_FIR_Reg_coeff6_n21) );
  INV_X1 datapath_FIR_Reg_coeff6_U12 ( .A(datapath_FIR_Reg_coeff6_n21), .ZN(
        datapath_FIR_Reg_coeff6_n4) );
  AOI22_X1 datapath_FIR_Reg_coeff6_U11 ( .A1(b6[3]), .A2(
        datapath_FIR_Reg_coeff6_n25), .B1(datapath_FIR_bq6[2]), .B2(
        datapath_FIR_Reg_coeff6_n24), .ZN(datapath_FIR_Reg_coeff6_n22) );
  INV_X1 datapath_FIR_Reg_coeff6_U10 ( .A(datapath_FIR_Reg_coeff6_n22), .ZN(
        datapath_FIR_Reg_coeff6_n5) );
  AOI22_X1 datapath_FIR_Reg_coeff6_U9 ( .A1(b6[2]), .A2(
        datapath_FIR_Reg_coeff6_n25), .B1(datapath_FIR_bq6[1]), .B2(
        datapath_FIR_Reg_coeff6_n24), .ZN(datapath_FIR_Reg_coeff6_n23) );
  INV_X1 datapath_FIR_Reg_coeff6_U8 ( .A(datapath_FIR_Reg_coeff6_n23), .ZN(
        datapath_FIR_Reg_coeff6_n6) );
  AOI22_X1 datapath_FIR_Reg_coeff6_U7 ( .A1(b6[1]), .A2(
        datapath_FIR_Reg_coeff6_n25), .B1(datapath_FIR_bq6[0]), .B2(
        datapath_FIR_Reg_coeff6_n24), .ZN(datapath_FIR_Reg_coeff6_n26) );
  INV_X1 datapath_FIR_Reg_coeff6_U6 ( .A(datapath_FIR_Reg_coeff6_n26), .ZN(
        datapath_FIR_Reg_coeff6_n7) );
  INV_X1 datapath_FIR_Reg_coeff6_U5 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_coeff6_n8) );
  NOR2_X1 datapath_FIR_Reg_coeff6_U4 ( .A1(reg_coeff_en), .A2(
        datapath_FIR_Reg_coeff6_n8), .ZN(datapath_FIR_Reg_coeff6_n24) );
  NOR2_X1 datapath_FIR_Reg_coeff6_U3 ( .A1(datapath_FIR_Reg_coeff6_n8), .A2(
        datapath_FIR_Reg_coeff6_n24), .ZN(datapath_FIR_Reg_coeff6_n25) );
  DFF_X1 datapath_FIR_Reg_coeff6_q_reg_0_ ( .D(datapath_FIR_Reg_coeff6_n7), 
        .CK(clk), .Q(datapath_FIR_bq6[0]) );
  DFF_X1 datapath_FIR_Reg_coeff6_q_reg_1_ ( .D(datapath_FIR_Reg_coeff6_n6), 
        .CK(clk), .Q(datapath_FIR_bq6[1]) );
  DFF_X1 datapath_FIR_Reg_coeff6_q_reg_2_ ( .D(datapath_FIR_Reg_coeff6_n5), 
        .CK(clk), .Q(datapath_FIR_bq6[2]) );
  DFF_X1 datapath_FIR_Reg_coeff6_q_reg_3_ ( .D(datapath_FIR_Reg_coeff6_n4), 
        .CK(clk), .Q(datapath_FIR_bq6[3]) );
  DFF_X1 datapath_FIR_Reg_coeff6_q_reg_4_ ( .D(datapath_FIR_Reg_coeff6_n3), 
        .CK(clk), .Q(datapath_FIR_bq6[4]) );
  DFF_X1 datapath_FIR_Reg_coeff6_q_reg_5_ ( .D(datapath_FIR_Reg_coeff6_n2), 
        .CK(clk), .Q(datapath_FIR_bq6[5]) );
  DFF_X1 datapath_FIR_Reg_coeff6_q_reg_6_ ( .D(datapath_FIR_Reg_coeff6_n1), 
        .CK(clk), .Q(datapath_FIR_bq6[6]) );
  AOI22_X1 datapath_FIR_Reg_coeff7_U19 ( .A1(b7[3]), .A2(
        datapath_FIR_Reg_coeff7_n26), .B1(datapath_FIR_bq7[2]), .B2(
        datapath_FIR_Reg_coeff7_n25), .ZN(datapath_FIR_Reg_coeff7_n23) );
  AOI22_X1 datapath_FIR_Reg_coeff7_U18 ( .A1(b7[7]), .A2(
        datapath_FIR_Reg_coeff7_n26), .B1(datapath_FIR_bq7[6]), .B2(
        datapath_FIR_Reg_coeff7_n25), .ZN(datapath_FIR_Reg_coeff7_n19) );
  INV_X1 datapath_FIR_Reg_coeff7_U17 ( .A(datapath_FIR_Reg_coeff7_n19), .ZN(
        datapath_FIR_Reg_coeff7_n2) );
  AOI22_X1 datapath_FIR_Reg_coeff7_U16 ( .A1(b7[6]), .A2(
        datapath_FIR_Reg_coeff7_n26), .B1(datapath_FIR_bq7[5]), .B2(
        datapath_FIR_Reg_coeff7_n25), .ZN(datapath_FIR_Reg_coeff7_n20) );
  INV_X1 datapath_FIR_Reg_coeff7_U15 ( .A(datapath_FIR_Reg_coeff7_n20), .ZN(
        datapath_FIR_Reg_coeff7_n3) );
  AOI22_X1 datapath_FIR_Reg_coeff7_U14 ( .A1(b7[5]), .A2(
        datapath_FIR_Reg_coeff7_n26), .B1(datapath_FIR_bq7[4]), .B2(
        datapath_FIR_Reg_coeff7_n25), .ZN(datapath_FIR_Reg_coeff7_n21) );
  INV_X1 datapath_FIR_Reg_coeff7_U13 ( .A(datapath_FIR_Reg_coeff7_n21), .ZN(
        datapath_FIR_Reg_coeff7_n4) );
  AOI22_X1 datapath_FIR_Reg_coeff7_U12 ( .A1(b7[4]), .A2(
        datapath_FIR_Reg_coeff7_n26), .B1(datapath_FIR_bq7[3]), .B2(
        datapath_FIR_Reg_coeff7_n25), .ZN(datapath_FIR_Reg_coeff7_n22) );
  INV_X1 datapath_FIR_Reg_coeff7_U11 ( .A(datapath_FIR_Reg_coeff7_n22), .ZN(
        datapath_FIR_Reg_coeff7_n5) );
  AOI22_X1 datapath_FIR_Reg_coeff7_U10 ( .A1(b7[1]), .A2(
        datapath_FIR_Reg_coeff7_n26), .B1(datapath_FIR_bq7[0]), .B2(
        datapath_FIR_Reg_coeff7_n25), .ZN(datapath_FIR_Reg_coeff7_n27) );
  INV_X1 datapath_FIR_Reg_coeff7_U9 ( .A(datapath_FIR_Reg_coeff7_n27), .ZN(
        datapath_FIR_Reg_coeff7_n8) );
  AOI22_X1 datapath_FIR_Reg_coeff7_U8 ( .A1(b7[2]), .A2(
        datapath_FIR_Reg_coeff7_n26), .B1(datapath_FIR_bq7[1]), .B2(
        datapath_FIR_Reg_coeff7_n25), .ZN(datapath_FIR_Reg_coeff7_n24) );
  INV_X1 datapath_FIR_Reg_coeff7_U7 ( .A(datapath_FIR_Reg_coeff7_n24), .ZN(
        datapath_FIR_Reg_coeff7_n7) );
  INV_X1 datapath_FIR_Reg_coeff7_U6 ( .A(datapath_FIR_Reg_coeff7_n23), .ZN(
        datapath_FIR_Reg_coeff7_n6) );
  INV_X1 datapath_FIR_Reg_coeff7_U5 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_coeff7_n18) );
  NOR2_X1 datapath_FIR_Reg_coeff7_U4 ( .A1(reg_coeff_en), .A2(
        datapath_FIR_Reg_coeff7_n18), .ZN(datapath_FIR_Reg_coeff7_n25) );
  NOR2_X1 datapath_FIR_Reg_coeff7_U3 ( .A1(datapath_FIR_Reg_coeff7_n18), .A2(
        datapath_FIR_Reg_coeff7_n25), .ZN(datapath_FIR_Reg_coeff7_n26) );
  DFF_X1 datapath_FIR_Reg_coeff7_q_reg_1_ ( .D(datapath_FIR_Reg_coeff7_n7), 
        .CK(clk), .Q(datapath_FIR_bq7[1]) );
  DFF_X1 datapath_FIR_Reg_coeff7_q_reg_0_ ( .D(datapath_FIR_Reg_coeff7_n8), 
        .CK(clk), .Q(datapath_FIR_bq7[0]) );
  DFF_X1 datapath_FIR_Reg_coeff7_q_reg_2_ ( .D(datapath_FIR_Reg_coeff7_n6), 
        .CK(clk), .Q(datapath_FIR_bq7[2]) );
  DFF_X1 datapath_FIR_Reg_coeff7_q_reg_3_ ( .D(datapath_FIR_Reg_coeff7_n5), 
        .CK(clk), .Q(datapath_FIR_bq7[3]) );
  DFF_X1 datapath_FIR_Reg_coeff7_q_reg_4_ ( .D(datapath_FIR_Reg_coeff7_n4), 
        .CK(clk), .Q(datapath_FIR_bq7[4]) );
  DFF_X1 datapath_FIR_Reg_coeff7_q_reg_5_ ( .D(datapath_FIR_Reg_coeff7_n3), 
        .CK(clk), .Q(datapath_FIR_bq7[5]) );
  DFF_X1 datapath_FIR_Reg_coeff7_q_reg_6_ ( .D(datapath_FIR_Reg_coeff7_n2), 
        .CK(clk), .Q(datapath_FIR_bq7[6]) );
  AOI22_X1 datapath_FIR_Reg_coeff8_U20 ( .A1(b8[3]), .A2(
        datapath_FIR_Reg_coeff8_n27), .B1(datapath_FIR_bq8[2]), .B2(
        datapath_FIR_Reg_coeff8_n26), .ZN(datapath_FIR_Reg_coeff8_n24) );
  AOI22_X1 datapath_FIR_Reg_coeff8_U19 ( .A1(b8[2]), .A2(
        datapath_FIR_Reg_coeff8_n27), .B1(datapath_FIR_Reg_coeff8_n2), .B2(
        datapath_FIR_Reg_coeff8_n26), .ZN(datapath_FIR_Reg_coeff8_n25) );
  INV_X1 datapath_FIR_Reg_coeff8_U18 ( .A(datapath_FIR_Reg_coeff8_n25), .ZN(
        datapath_FIR_Reg_coeff8_n8) );
  INV_X1 datapath_FIR_Reg_coeff8_U17 ( .A(datapath_FIR_Reg_coeff8_n1), .ZN(
        datapath_FIR_Reg_coeff8_n2) );
  AOI22_X1 datapath_FIR_Reg_coeff8_U16 ( .A1(b8[7]), .A2(
        datapath_FIR_Reg_coeff8_n27), .B1(datapath_FIR_bq8[6]), .B2(
        datapath_FIR_Reg_coeff8_n26), .ZN(datapath_FIR_Reg_coeff8_n20) );
  INV_X1 datapath_FIR_Reg_coeff8_U15 ( .A(datapath_FIR_Reg_coeff8_n20), .ZN(
        datapath_FIR_Reg_coeff8_n3) );
  AOI22_X1 datapath_FIR_Reg_coeff8_U14 ( .A1(b8[6]), .A2(
        datapath_FIR_Reg_coeff8_n27), .B1(datapath_FIR_bq8[5]), .B2(
        datapath_FIR_Reg_coeff8_n26), .ZN(datapath_FIR_Reg_coeff8_n21) );
  INV_X1 datapath_FIR_Reg_coeff8_U13 ( .A(datapath_FIR_Reg_coeff8_n21), .ZN(
        datapath_FIR_Reg_coeff8_n4) );
  AOI22_X1 datapath_FIR_Reg_coeff8_U12 ( .A1(b8[5]), .A2(
        datapath_FIR_Reg_coeff8_n27), .B1(datapath_FIR_bq8[4]), .B2(
        datapath_FIR_Reg_coeff8_n26), .ZN(datapath_FIR_Reg_coeff8_n22) );
  INV_X1 datapath_FIR_Reg_coeff8_U11 ( .A(datapath_FIR_Reg_coeff8_n22), .ZN(
        datapath_FIR_Reg_coeff8_n5) );
  AOI22_X1 datapath_FIR_Reg_coeff8_U10 ( .A1(b8[4]), .A2(
        datapath_FIR_Reg_coeff8_n27), .B1(datapath_FIR_bq8[3]), .B2(
        datapath_FIR_Reg_coeff8_n26), .ZN(datapath_FIR_Reg_coeff8_n23) );
  INV_X1 datapath_FIR_Reg_coeff8_U9 ( .A(datapath_FIR_Reg_coeff8_n23), .ZN(
        datapath_FIR_Reg_coeff8_n6) );
  AOI22_X1 datapath_FIR_Reg_coeff8_U8 ( .A1(b8[1]), .A2(
        datapath_FIR_Reg_coeff8_n27), .B1(datapath_FIR_bq8[0]), .B2(
        datapath_FIR_Reg_coeff8_n26), .ZN(datapath_FIR_Reg_coeff8_n28) );
  INV_X1 datapath_FIR_Reg_coeff8_U7 ( .A(datapath_FIR_Reg_coeff8_n28), .ZN(
        datapath_FIR_Reg_coeff8_n18) );
  INV_X1 datapath_FIR_Reg_coeff8_U6 ( .A(datapath_FIR_Reg_coeff8_n24), .ZN(
        datapath_FIR_Reg_coeff8_n7) );
  INV_X1 datapath_FIR_Reg_coeff8_U5 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_coeff8_n19) );
  NOR2_X1 datapath_FIR_Reg_coeff8_U4 ( .A1(reg_coeff_en), .A2(
        datapath_FIR_Reg_coeff8_n19), .ZN(datapath_FIR_Reg_coeff8_n26) );
  NOR2_X1 datapath_FIR_Reg_coeff8_U3 ( .A1(datapath_FIR_Reg_coeff8_n19), .A2(
        datapath_FIR_Reg_coeff8_n26), .ZN(datapath_FIR_Reg_coeff8_n27) );
  DFF_X1 datapath_FIR_Reg_coeff8_q_reg_0_ ( .D(datapath_FIR_Reg_coeff8_n18), 
        .CK(clk), .Q(datapath_FIR_bq8[0]) );
  DFF_X1 datapath_FIR_Reg_coeff8_q_reg_2_ ( .D(datapath_FIR_Reg_coeff8_n7), 
        .CK(clk), .Q(datapath_FIR_bq8[2]) );
  DFF_X1 datapath_FIR_Reg_coeff8_q_reg_1_ ( .D(datapath_FIR_Reg_coeff8_n8), 
        .CK(clk), .Q(datapath_FIR_bq8[1]), .QN(datapath_FIR_Reg_coeff8_n1) );
  DFF_X1 datapath_FIR_Reg_coeff8_q_reg_3_ ( .D(datapath_FIR_Reg_coeff8_n6), 
        .CK(clk), .Q(datapath_FIR_bq8[3]) );
  DFF_X1 datapath_FIR_Reg_coeff8_q_reg_4_ ( .D(datapath_FIR_Reg_coeff8_n5), 
        .CK(clk), .Q(datapath_FIR_bq8[4]) );
  DFF_X1 datapath_FIR_Reg_coeff8_q_reg_5_ ( .D(datapath_FIR_Reg_coeff8_n4), 
        .CK(clk), .Q(datapath_FIR_bq8[5]) );
  DFF_X1 datapath_FIR_Reg_coeff8_q_reg_6_ ( .D(datapath_FIR_Reg_coeff8_n3), 
        .CK(clk), .Q(datapath_FIR_bq8[6]) );
  AOI22_X1 datapath_FIR_Reg_Sample1_U19 ( .A1(datapath_FIR_x0[5]), .A2(
        datapath_FIR_Reg_Sample1_n25), .B1(datapath_FIR_x1[5]), .B2(
        datapath_FIR_Reg_Sample1_n24), .ZN(datapath_FIR_Reg_Sample1_n19) );
  INV_X1 datapath_FIR_Reg_Sample1_U18 ( .A(datapath_FIR_Reg_Sample1_n19), .ZN(
        datapath_FIR_Reg_Sample1_n2) );
  AOI22_X1 datapath_FIR_Reg_Sample1_U17 ( .A1(datapath_FIR_x0[4]), .A2(
        datapath_FIR_Reg_Sample1_n25), .B1(datapath_FIR_x1[4]), .B2(
        datapath_FIR_Reg_Sample1_n24), .ZN(datapath_FIR_Reg_Sample1_n20) );
  INV_X1 datapath_FIR_Reg_Sample1_U16 ( .A(datapath_FIR_Reg_Sample1_n20), .ZN(
        datapath_FIR_Reg_Sample1_n3) );
  AOI22_X1 datapath_FIR_Reg_Sample1_U15 ( .A1(datapath_FIR_x0[3]), .A2(
        datapath_FIR_Reg_Sample1_n25), .B1(datapath_FIR_x1[3]), .B2(
        datapath_FIR_Reg_Sample1_n24), .ZN(datapath_FIR_Reg_Sample1_n21) );
  INV_X1 datapath_FIR_Reg_Sample1_U14 ( .A(datapath_FIR_Reg_Sample1_n21), .ZN(
        datapath_FIR_Reg_Sample1_n4) );
  AOI22_X1 datapath_FIR_Reg_Sample1_U13 ( .A1(datapath_FIR_x0[2]), .A2(
        datapath_FIR_Reg_Sample1_n25), .B1(datapath_FIR_x1[2]), .B2(
        datapath_FIR_Reg_Sample1_n24), .ZN(datapath_FIR_Reg_Sample1_n22) );
  INV_X1 datapath_FIR_Reg_Sample1_U12 ( .A(datapath_FIR_Reg_Sample1_n22), .ZN(
        datapath_FIR_Reg_Sample1_n5) );
  AOI22_X1 datapath_FIR_Reg_Sample1_U11 ( .A1(datapath_FIR_x0[1]), .A2(
        datapath_FIR_Reg_Sample1_n25), .B1(datapath_FIR_x1[1]), .B2(
        datapath_FIR_Reg_Sample1_n24), .ZN(datapath_FIR_Reg_Sample1_n23) );
  INV_X1 datapath_FIR_Reg_Sample1_U10 ( .A(datapath_FIR_Reg_Sample1_n23), .ZN(
        datapath_FIR_Reg_Sample1_n6) );
  AOI22_X1 datapath_FIR_Reg_Sample1_U9 ( .A1(datapath_FIR_x0[0]), .A2(
        datapath_FIR_Reg_Sample1_n25), .B1(datapath_FIR_x1[0]), .B2(
        datapath_FIR_Reg_Sample1_n24), .ZN(datapath_FIR_Reg_Sample1_n26) );
  INV_X1 datapath_FIR_Reg_Sample1_U8 ( .A(datapath_FIR_Reg_Sample1_n26), .ZN(
        datapath_FIR_Reg_Sample1_n7) );
  AOI22_X1 datapath_FIR_Reg_Sample1_U7 ( .A1(datapath_FIR_x0[6]), .A2(
        datapath_FIR_Reg_Sample1_n25), .B1(datapath_FIR_x1[6]), .B2(
        datapath_FIR_Reg_Sample1_n24), .ZN(datapath_FIR_Reg_Sample1_n18) );
  INV_X1 datapath_FIR_Reg_Sample1_U6 ( .A(datapath_FIR_Reg_Sample1_n18), .ZN(
        datapath_FIR_Reg_Sample1_n1) );
  INV_X1 datapath_FIR_Reg_Sample1_U5 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_Sample1_n8) );
  NOR2_X1 datapath_FIR_Reg_Sample1_U4 ( .A1(datapath_FIR_Reg_Sample1_n8), .A2(
        datapath_FIR_Reg_Sample1_n24), .ZN(datapath_FIR_Reg_Sample1_n25) );
  NOR2_X1 datapath_FIR_Reg_Sample1_U3 ( .A1(reg_out_en), .A2(
        datapath_FIR_Reg_Sample1_n8), .ZN(datapath_FIR_Reg_Sample1_n24) );
  DFF_X1 datapath_FIR_Reg_Sample1_q_reg_0_ ( .D(datapath_FIR_Reg_Sample1_n7), 
        .CK(clk), .Q(datapath_FIR_x1[0]) );
  DFF_X1 datapath_FIR_Reg_Sample1_q_reg_1_ ( .D(datapath_FIR_Reg_Sample1_n6), 
        .CK(clk), .Q(datapath_FIR_x1[1]) );
  DFF_X1 datapath_FIR_Reg_Sample1_q_reg_2_ ( .D(datapath_FIR_Reg_Sample1_n5), 
        .CK(clk), .Q(datapath_FIR_x1[2]) );
  DFF_X1 datapath_FIR_Reg_Sample1_q_reg_3_ ( .D(datapath_FIR_Reg_Sample1_n4), 
        .CK(clk), .Q(datapath_FIR_x1[3]) );
  DFF_X1 datapath_FIR_Reg_Sample1_q_reg_4_ ( .D(datapath_FIR_Reg_Sample1_n3), 
        .CK(clk), .Q(datapath_FIR_x1[4]) );
  DFF_X1 datapath_FIR_Reg_Sample1_q_reg_5_ ( .D(datapath_FIR_Reg_Sample1_n2), 
        .CK(clk), .Q(datapath_FIR_x1[5]) );
  DFF_X1 datapath_FIR_Reg_Sample1_q_reg_6_ ( .D(datapath_FIR_Reg_Sample1_n1), 
        .CK(clk), .Q(datapath_FIR_x1[6]) );
  AOI22_X1 datapath_FIR_Reg_Sample2_U19 ( .A1(datapath_FIR_x1[5]), .A2(
        datapath_FIR_Reg_Sample2_n25), .B1(datapath_FIR_x2[5]), .B2(
        datapath_FIR_Reg_Sample2_n24), .ZN(datapath_FIR_Reg_Sample2_n19) );
  INV_X1 datapath_FIR_Reg_Sample2_U18 ( .A(datapath_FIR_Reg_Sample2_n19), .ZN(
        datapath_FIR_Reg_Sample2_n2) );
  AOI22_X1 datapath_FIR_Reg_Sample2_U17 ( .A1(datapath_FIR_x1[4]), .A2(
        datapath_FIR_Reg_Sample2_n25), .B1(datapath_FIR_x2[4]), .B2(
        datapath_FIR_Reg_Sample2_n24), .ZN(datapath_FIR_Reg_Sample2_n20) );
  INV_X1 datapath_FIR_Reg_Sample2_U16 ( .A(datapath_FIR_Reg_Sample2_n20), .ZN(
        datapath_FIR_Reg_Sample2_n3) );
  AOI22_X1 datapath_FIR_Reg_Sample2_U15 ( .A1(datapath_FIR_x1[3]), .A2(
        datapath_FIR_Reg_Sample2_n25), .B1(datapath_FIR_x2[3]), .B2(
        datapath_FIR_Reg_Sample2_n24), .ZN(datapath_FIR_Reg_Sample2_n21) );
  INV_X1 datapath_FIR_Reg_Sample2_U14 ( .A(datapath_FIR_Reg_Sample2_n21), .ZN(
        datapath_FIR_Reg_Sample2_n4) );
  AOI22_X1 datapath_FIR_Reg_Sample2_U13 ( .A1(datapath_FIR_x1[2]), .A2(
        datapath_FIR_Reg_Sample2_n25), .B1(datapath_FIR_x2[2]), .B2(
        datapath_FIR_Reg_Sample2_n24), .ZN(datapath_FIR_Reg_Sample2_n22) );
  INV_X1 datapath_FIR_Reg_Sample2_U12 ( .A(datapath_FIR_Reg_Sample2_n22), .ZN(
        datapath_FIR_Reg_Sample2_n5) );
  AOI22_X1 datapath_FIR_Reg_Sample2_U11 ( .A1(datapath_FIR_x1[1]), .A2(
        datapath_FIR_Reg_Sample2_n25), .B1(datapath_FIR_x2[1]), .B2(
        datapath_FIR_Reg_Sample2_n24), .ZN(datapath_FIR_Reg_Sample2_n23) );
  INV_X1 datapath_FIR_Reg_Sample2_U10 ( .A(datapath_FIR_Reg_Sample2_n23), .ZN(
        datapath_FIR_Reg_Sample2_n6) );
  AOI22_X1 datapath_FIR_Reg_Sample2_U9 ( .A1(datapath_FIR_x1[0]), .A2(
        datapath_FIR_Reg_Sample2_n25), .B1(datapath_FIR_x2[0]), .B2(
        datapath_FIR_Reg_Sample2_n24), .ZN(datapath_FIR_Reg_Sample2_n26) );
  INV_X1 datapath_FIR_Reg_Sample2_U8 ( .A(datapath_FIR_Reg_Sample2_n26), .ZN(
        datapath_FIR_Reg_Sample2_n7) );
  AOI22_X1 datapath_FIR_Reg_Sample2_U7 ( .A1(datapath_FIR_x1[6]), .A2(
        datapath_FIR_Reg_Sample2_n25), .B1(datapath_FIR_x2[6]), .B2(
        datapath_FIR_Reg_Sample2_n24), .ZN(datapath_FIR_Reg_Sample2_n18) );
  INV_X1 datapath_FIR_Reg_Sample2_U6 ( .A(datapath_FIR_Reg_Sample2_n18), .ZN(
        datapath_FIR_Reg_Sample2_n1) );
  INV_X1 datapath_FIR_Reg_Sample2_U5 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_Sample2_n8) );
  NOR2_X1 datapath_FIR_Reg_Sample2_U4 ( .A1(datapath_FIR_Reg_Sample2_n8), .A2(
        datapath_FIR_Reg_Sample2_n24), .ZN(datapath_FIR_Reg_Sample2_n25) );
  NOR2_X1 datapath_FIR_Reg_Sample2_U3 ( .A1(reg_out_en), .A2(
        datapath_FIR_Reg_Sample2_n8), .ZN(datapath_FIR_Reg_Sample2_n24) );
  DFF_X1 datapath_FIR_Reg_Sample2_q_reg_0_ ( .D(datapath_FIR_Reg_Sample2_n7), 
        .CK(clk), .Q(datapath_FIR_x2[0]) );
  DFF_X1 datapath_FIR_Reg_Sample2_q_reg_1_ ( .D(datapath_FIR_Reg_Sample2_n6), 
        .CK(clk), .Q(datapath_FIR_x2[1]) );
  DFF_X1 datapath_FIR_Reg_Sample2_q_reg_2_ ( .D(datapath_FIR_Reg_Sample2_n5), 
        .CK(clk), .Q(datapath_FIR_x2[2]) );
  DFF_X1 datapath_FIR_Reg_Sample2_q_reg_3_ ( .D(datapath_FIR_Reg_Sample2_n4), 
        .CK(clk), .Q(datapath_FIR_x2[3]) );
  DFF_X1 datapath_FIR_Reg_Sample2_q_reg_4_ ( .D(datapath_FIR_Reg_Sample2_n3), 
        .CK(clk), .Q(datapath_FIR_x2[4]) );
  DFF_X1 datapath_FIR_Reg_Sample2_q_reg_5_ ( .D(datapath_FIR_Reg_Sample2_n2), 
        .CK(clk), .Q(datapath_FIR_x2[5]) );
  DFF_X1 datapath_FIR_Reg_Sample2_q_reg_6_ ( .D(datapath_FIR_Reg_Sample2_n1), 
        .CK(clk), .Q(datapath_FIR_x2[6]) );
  AOI22_X1 datapath_FIR_Reg_Sample3_U20 ( .A1(datapath_FIR_x2[0]), .A2(
        datapath_FIR_Reg_Sample3_n28), .B1(datapath_FIR_x3[0]), .B2(
        datapath_FIR_Reg_Sample3_n27), .ZN(datapath_FIR_Reg_Sample3_n29) );
  AOI22_X1 datapath_FIR_Reg_Sample3_U19 ( .A1(datapath_FIR_x2[1]), .A2(
        datapath_FIR_Reg_Sample3_n28), .B1(datapath_FIR_Reg_Sample3_n3), .B2(
        datapath_FIR_Reg_Sample3_n27), .ZN(datapath_FIR_Reg_Sample3_n26) );
  AOI22_X1 datapath_FIR_Reg_Sample3_U18 ( .A1(datapath_FIR_x2[5]), .A2(
        datapath_FIR_Reg_Sample3_n28), .B1(datapath_FIR_x3[5]), .B2(
        datapath_FIR_Reg_Sample3_n27), .ZN(datapath_FIR_Reg_Sample3_n22) );
  AOI22_X1 datapath_FIR_Reg_Sample3_U17 ( .A1(datapath_FIR_x2[4]), .A2(
        datapath_FIR_Reg_Sample3_n28), .B1(datapath_FIR_x3[4]), .B2(
        datapath_FIR_Reg_Sample3_n27), .ZN(datapath_FIR_Reg_Sample3_n23) );
  INV_X1 datapath_FIR_Reg_Sample3_U16 ( .A(datapath_FIR_Reg_Sample3_n29), .ZN(
        datapath_FIR_Reg_Sample3_n19) );
  AOI22_X1 datapath_FIR_Reg_Sample3_U15 ( .A1(datapath_FIR_x2[2]), .A2(
        datapath_FIR_Reg_Sample3_n28), .B1(datapath_FIR_x3[2]), .B2(
        datapath_FIR_Reg_Sample3_n27), .ZN(datapath_FIR_Reg_Sample3_n25) );
  INV_X1 datapath_FIR_Reg_Sample3_U14 ( .A(datapath_FIR_Reg_Sample3_n22), .ZN(
        datapath_FIR_Reg_Sample3_n5) );
  AOI22_X1 datapath_FIR_Reg_Sample3_U13 ( .A1(datapath_FIR_x2[3]), .A2(
        datapath_FIR_Reg_Sample3_n28), .B1(datapath_FIR_x3[3]), .B2(
        datapath_FIR_Reg_Sample3_n27), .ZN(datapath_FIR_Reg_Sample3_n24) );
  INV_X1 datapath_FIR_Reg_Sample3_U12 ( .A(datapath_FIR_Reg_Sample3_n2), .ZN(
        datapath_FIR_Reg_Sample3_n3) );
  AOI22_X1 datapath_FIR_Reg_Sample3_U11 ( .A1(datapath_FIR_x2[6]), .A2(
        datapath_FIR_Reg_Sample3_n28), .B1(datapath_FIR_x3[6]), .B2(
        datapath_FIR_Reg_Sample3_n27), .ZN(datapath_FIR_Reg_Sample3_n21) );
  INV_X1 datapath_FIR_Reg_Sample3_U10 ( .A(datapath_FIR_Reg_Sample3_n21), .ZN(
        datapath_FIR_Reg_Sample3_n4) );
  INV_X1 datapath_FIR_Reg_Sample3_U9 ( .A(datapath_FIR_Reg_Sample3_n25), .ZN(
        datapath_FIR_Reg_Sample3_n8) );
  INV_X1 datapath_FIR_Reg_Sample3_U8 ( .A(datapath_FIR_Reg_Sample3_n26), .ZN(
        datapath_FIR_Reg_Sample3_n18) );
  INV_X1 datapath_FIR_Reg_Sample3_U7 ( .A(datapath_FIR_Reg_Sample3_n24), .ZN(
        datapath_FIR_Reg_Sample3_n7) );
  INV_X1 datapath_FIR_Reg_Sample3_U6 ( .A(datapath_FIR_Reg_Sample3_n23), .ZN(
        datapath_FIR_Reg_Sample3_n6) );
  INV_X1 datapath_FIR_Reg_Sample3_U5 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_Sample3_n20) );
  NOR2_X1 datapath_FIR_Reg_Sample3_U4 ( .A1(datapath_FIR_Reg_Sample3_n20), 
        .A2(datapath_FIR_Reg_Sample3_n27), .ZN(datapath_FIR_Reg_Sample3_n28)
         );
  NOR2_X1 datapath_FIR_Reg_Sample3_U3 ( .A1(reg_out_en), .A2(
        datapath_FIR_Reg_Sample3_n20), .ZN(datapath_FIR_Reg_Sample3_n27) );
  DFF_X1 datapath_FIR_Reg_Sample3_q_reg_4_ ( .D(datapath_FIR_Reg_Sample3_n6), 
        .CK(clk), .Q(datapath_FIR_x3[4]) );
  DFF_X1 datapath_FIR_Reg_Sample3_q_reg_3_ ( .D(datapath_FIR_Reg_Sample3_n7), 
        .CK(clk), .Q(datapath_FIR_x3[3]) );
  DFF_X1 datapath_FIR_Reg_Sample3_q_reg_0_ ( .D(datapath_FIR_Reg_Sample3_n19), 
        .CK(clk), .Q(datapath_FIR_x3[0]) );
  DFF_X1 datapath_FIR_Reg_Sample3_q_reg_1_ ( .D(datapath_FIR_Reg_Sample3_n18), 
        .CK(clk), .Q(datapath_FIR_x3[1]), .QN(datapath_FIR_Reg_Sample3_n2) );
  DFF_X1 datapath_FIR_Reg_Sample3_q_reg_2_ ( .D(datapath_FIR_Reg_Sample3_n8), 
        .CK(clk), .Q(datapath_FIR_x3[2]) );
  DFF_X1 datapath_FIR_Reg_Sample3_q_reg_5_ ( .D(datapath_FIR_Reg_Sample3_n5), 
        .CK(clk), .Q(datapath_FIR_x3[5]) );
  DFF_X1 datapath_FIR_Reg_Sample3_q_reg_6_ ( .D(datapath_FIR_Reg_Sample3_n4), 
        .CK(clk), .Q(datapath_FIR_x3[6]) );
  AOI22_X1 datapath_FIR_Reg_Sample4_U19 ( .A1(datapath_FIR_x3[0]), .A2(
        datapath_FIR_Reg_Sample4_n25), .B1(datapath_FIR_x4[0]), .B2(
        datapath_FIR_Reg_Sample4_n24), .ZN(datapath_FIR_Reg_Sample4_n26) );
  AOI22_X1 datapath_FIR_Reg_Sample4_U18 ( .A1(datapath_FIR_x3[1]), .A2(
        datapath_FIR_Reg_Sample4_n25), .B1(datapath_FIR_x4[1]), .B2(
        datapath_FIR_Reg_Sample4_n24), .ZN(datapath_FIR_Reg_Sample4_n23) );
  AOI22_X1 datapath_FIR_Reg_Sample4_U17 ( .A1(datapath_FIR_x3[5]), .A2(
        datapath_FIR_Reg_Sample4_n25), .B1(datapath_FIR_x4[5]), .B2(
        datapath_FIR_Reg_Sample4_n24), .ZN(datapath_FIR_Reg_Sample4_n19) );
  AOI22_X1 datapath_FIR_Reg_Sample4_U16 ( .A1(datapath_FIR_x3[4]), .A2(
        datapath_FIR_Reg_Sample4_n25), .B1(datapath_FIR_x4[4]), .B2(
        datapath_FIR_Reg_Sample4_n24), .ZN(datapath_FIR_Reg_Sample4_n20) );
  AOI22_X1 datapath_FIR_Reg_Sample4_U15 ( .A1(datapath_FIR_x3[2]), .A2(
        datapath_FIR_Reg_Sample4_n25), .B1(datapath_FIR_x4[2]), .B2(
        datapath_FIR_Reg_Sample4_n24), .ZN(datapath_FIR_Reg_Sample4_n22) );
  AOI22_X1 datapath_FIR_Reg_Sample4_U14 ( .A1(datapath_FIR_x3[3]), .A2(
        datapath_FIR_Reg_Sample4_n25), .B1(datapath_FIR_x4[3]), .B2(
        datapath_FIR_Reg_Sample4_n24), .ZN(datapath_FIR_Reg_Sample4_n21) );
  AOI22_X1 datapath_FIR_Reg_Sample4_U13 ( .A1(datapath_FIR_x3[6]), .A2(
        datapath_FIR_Reg_Sample4_n25), .B1(datapath_FIR_x4[6]), .B2(
        datapath_FIR_Reg_Sample4_n24), .ZN(datapath_FIR_Reg_Sample4_n18) );
  INV_X1 datapath_FIR_Reg_Sample4_U12 ( .A(datapath_FIR_Reg_Sample4_n18), .ZN(
        datapath_FIR_Reg_Sample4_n1) );
  INV_X1 datapath_FIR_Reg_Sample4_U11 ( .A(datapath_FIR_Reg_Sample4_n19), .ZN(
        datapath_FIR_Reg_Sample4_n2) );
  INV_X1 datapath_FIR_Reg_Sample4_U10 ( .A(datapath_FIR_Reg_Sample4_n20), .ZN(
        datapath_FIR_Reg_Sample4_n3) );
  INV_X1 datapath_FIR_Reg_Sample4_U9 ( .A(datapath_FIR_Reg_Sample4_n21), .ZN(
        datapath_FIR_Reg_Sample4_n4) );
  INV_X1 datapath_FIR_Reg_Sample4_U8 ( .A(datapath_FIR_Reg_Sample4_n22), .ZN(
        datapath_FIR_Reg_Sample4_n5) );
  INV_X1 datapath_FIR_Reg_Sample4_U7 ( .A(datapath_FIR_Reg_Sample4_n23), .ZN(
        datapath_FIR_Reg_Sample4_n6) );
  INV_X1 datapath_FIR_Reg_Sample4_U6 ( .A(datapath_FIR_Reg_Sample4_n26), .ZN(
        datapath_FIR_Reg_Sample4_n7) );
  INV_X1 datapath_FIR_Reg_Sample4_U5 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_Sample4_n8) );
  NOR2_X1 datapath_FIR_Reg_Sample4_U4 ( .A1(datapath_FIR_Reg_Sample4_n8), .A2(
        datapath_FIR_Reg_Sample4_n24), .ZN(datapath_FIR_Reg_Sample4_n25) );
  NOR2_X1 datapath_FIR_Reg_Sample4_U3 ( .A1(reg_out_en), .A2(
        datapath_FIR_Reg_Sample4_n8), .ZN(datapath_FIR_Reg_Sample4_n24) );
  DFF_X1 datapath_FIR_Reg_Sample4_q_reg_0_ ( .D(datapath_FIR_Reg_Sample4_n7), 
        .CK(clk), .Q(datapath_FIR_x4[0]) );
  DFF_X1 datapath_FIR_Reg_Sample4_q_reg_1_ ( .D(datapath_FIR_Reg_Sample4_n6), 
        .CK(clk), .Q(datapath_FIR_x4[1]) );
  DFF_X1 datapath_FIR_Reg_Sample4_q_reg_2_ ( .D(datapath_FIR_Reg_Sample4_n5), 
        .CK(clk), .Q(datapath_FIR_x4[2]) );
  DFF_X1 datapath_FIR_Reg_Sample4_q_reg_3_ ( .D(datapath_FIR_Reg_Sample4_n4), 
        .CK(clk), .Q(datapath_FIR_x4[3]) );
  DFF_X1 datapath_FIR_Reg_Sample4_q_reg_4_ ( .D(datapath_FIR_Reg_Sample4_n3), 
        .CK(clk), .Q(datapath_FIR_x4[4]) );
  DFF_X1 datapath_FIR_Reg_Sample4_q_reg_5_ ( .D(datapath_FIR_Reg_Sample4_n2), 
        .CK(clk), .Q(datapath_FIR_x4[5]) );
  DFF_X1 datapath_FIR_Reg_Sample4_q_reg_6_ ( .D(datapath_FIR_Reg_Sample4_n1), 
        .CK(clk), .Q(datapath_FIR_x4[6]) );
  AOI22_X1 datapath_FIR_Reg_Sample5_U22 ( .A1(datapath_FIR_x4[0]), .A2(
        datapath_FIR_Reg_Sample5_n32), .B1(datapath_FIR_Reg_Sample5_n4), .B2(
        datapath_FIR_Reg_Sample5_n31), .ZN(datapath_FIR_Reg_Sample5_n33) );
  AOI22_X1 datapath_FIR_Reg_Sample5_U21 ( .A1(datapath_FIR_x4[1]), .A2(
        datapath_FIR_Reg_Sample5_n32), .B1(datapath_FIR_Reg_Sample5_n6), .B2(
        datapath_FIR_Reg_Sample5_n31), .ZN(datapath_FIR_Reg_Sample5_n30) );
  AOI22_X1 datapath_FIR_Reg_Sample5_U20 ( .A1(datapath_FIR_x4[5]), .A2(
        datapath_FIR_Reg_Sample5_n32), .B1(datapath_FIR_x5[5]), .B2(
        datapath_FIR_Reg_Sample5_n31), .ZN(datapath_FIR_Reg_Sample5_n26) );
  AOI22_X1 datapath_FIR_Reg_Sample5_U19 ( .A1(datapath_FIR_x4[4]), .A2(
        datapath_FIR_Reg_Sample5_n32), .B1(datapath_FIR_x5[4]), .B2(
        datapath_FIR_Reg_Sample5_n31), .ZN(datapath_FIR_Reg_Sample5_n27) );
  AOI22_X1 datapath_FIR_Reg_Sample5_U18 ( .A1(datapath_FIR_x4[2]), .A2(
        datapath_FIR_Reg_Sample5_n32), .B1(datapath_FIR_Reg_Sample5_n2), .B2(
        datapath_FIR_Reg_Sample5_n31), .ZN(datapath_FIR_Reg_Sample5_n29) );
  INV_X1 datapath_FIR_Reg_Sample5_U17 ( .A(datapath_FIR_Reg_Sample5_n33), .ZN(
        datapath_FIR_Reg_Sample5_n23) );
  INV_X1 datapath_FIR_Reg_Sample5_U16 ( .A(datapath_FIR_Reg_Sample5_n26), .ZN(
        datapath_FIR_Reg_Sample5_n18) );
  INV_X1 datapath_FIR_Reg_Sample5_U15 ( .A(datapath_FIR_Reg_Sample5_n27), .ZN(
        datapath_FIR_Reg_Sample5_n19) );
  INV_X1 datapath_FIR_Reg_Sample5_U14 ( .A(datapath_FIR_Reg_Sample5_n29), .ZN(
        datapath_FIR_Reg_Sample5_n21) );
  INV_X1 datapath_FIR_Reg_Sample5_U13 ( .A(datapath_FIR_Reg_Sample5_n30), .ZN(
        datapath_FIR_Reg_Sample5_n22) );
  AOI22_X1 datapath_FIR_Reg_Sample5_U12 ( .A1(datapath_FIR_x4[6]), .A2(
        datapath_FIR_Reg_Sample5_n32), .B1(datapath_FIR_x5[6]), .B2(
        datapath_FIR_Reg_Sample5_n31), .ZN(datapath_FIR_Reg_Sample5_n25) );
  INV_X1 datapath_FIR_Reg_Sample5_U11 ( .A(datapath_FIR_Reg_Sample5_n25), .ZN(
        datapath_FIR_Reg_Sample5_n8) );
  AOI22_X1 datapath_FIR_Reg_Sample5_U10 ( .A1(datapath_FIR_x4[3]), .A2(
        datapath_FIR_Reg_Sample5_n32), .B1(datapath_FIR_x5[3]), .B2(
        datapath_FIR_Reg_Sample5_n31), .ZN(datapath_FIR_Reg_Sample5_n28) );
  INV_X1 datapath_FIR_Reg_Sample5_U9 ( .A(datapath_FIR_Reg_Sample5_n28), .ZN(
        datapath_FIR_Reg_Sample5_n20) );
  INV_X1 datapath_FIR_Reg_Sample5_U8 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_Sample5_n24) );
  NOR2_X1 datapath_FIR_Reg_Sample5_U7 ( .A1(datapath_FIR_Reg_Sample5_n24), 
        .A2(datapath_FIR_Reg_Sample5_n31), .ZN(datapath_FIR_Reg_Sample5_n32)
         );
  NOR2_X1 datapath_FIR_Reg_Sample5_U6 ( .A1(reg_out_en), .A2(
        datapath_FIR_Reg_Sample5_n24), .ZN(datapath_FIR_Reg_Sample5_n31) );
  INV_X1 datapath_FIR_Reg_Sample5_U5 ( .A(datapath_FIR_Reg_Sample5_n5), .ZN(
        datapath_FIR_Reg_Sample5_n6) );
  INV_X1 datapath_FIR_Reg_Sample5_U4 ( .A(datapath_FIR_Reg_Sample5_n3), .ZN(
        datapath_FIR_Reg_Sample5_n4) );
  INV_X1 datapath_FIR_Reg_Sample5_U3 ( .A(datapath_FIR_Reg_Sample5_n1), .ZN(
        datapath_FIR_Reg_Sample5_n2) );
  DFF_X1 datapath_FIR_Reg_Sample5_q_reg_0_ ( .D(datapath_FIR_Reg_Sample5_n23), 
        .CK(clk), .Q(datapath_FIR_x5[0]), .QN(datapath_FIR_Reg_Sample5_n3) );
  DFF_X1 datapath_FIR_Reg_Sample5_q_reg_1_ ( .D(datapath_FIR_Reg_Sample5_n22), 
        .CK(clk), .Q(datapath_FIR_x5[1]), .QN(datapath_FIR_Reg_Sample5_n5) );
  DFF_X1 datapath_FIR_Reg_Sample5_q_reg_2_ ( .D(datapath_FIR_Reg_Sample5_n21), 
        .CK(clk), .Q(datapath_FIR_x5[2]), .QN(datapath_FIR_Reg_Sample5_n1) );
  DFF_X1 datapath_FIR_Reg_Sample5_q_reg_3_ ( .D(datapath_FIR_Reg_Sample5_n20), 
        .CK(clk), .Q(datapath_FIR_x5[3]) );
  DFF_X1 datapath_FIR_Reg_Sample5_q_reg_4_ ( .D(datapath_FIR_Reg_Sample5_n19), 
        .CK(clk), .Q(datapath_FIR_x5[4]) );
  DFF_X1 datapath_FIR_Reg_Sample5_q_reg_5_ ( .D(datapath_FIR_Reg_Sample5_n18), 
        .CK(clk), .Q(datapath_FIR_x5[5]) );
  DFF_X1 datapath_FIR_Reg_Sample5_q_reg_6_ ( .D(datapath_FIR_Reg_Sample5_n8), 
        .CK(clk), .Q(datapath_FIR_x5[6]) );
  AOI22_X1 datapath_FIR_Reg_Sample6_U19 ( .A1(datapath_FIR_n2), .A2(
        datapath_FIR_Reg_Sample6_n25), .B1(datapath_FIR_x6[0]), .B2(
        datapath_FIR_Reg_Sample6_n24), .ZN(datapath_FIR_Reg_Sample6_n26) );
  AOI22_X1 datapath_FIR_Reg_Sample6_U18 ( .A1(datapath_FIR_x5[1]), .A2(
        datapath_FIR_Reg_Sample6_n25), .B1(datapath_FIR_x6[1]), .B2(
        datapath_FIR_Reg_Sample6_n24), .ZN(datapath_FIR_Reg_Sample6_n23) );
  AOI22_X1 datapath_FIR_Reg_Sample6_U17 ( .A1(datapath_FIR_x5[5]), .A2(
        datapath_FIR_Reg_Sample6_n25), .B1(datapath_FIR_x6[5]), .B2(
        datapath_FIR_Reg_Sample6_n24), .ZN(datapath_FIR_Reg_Sample6_n19) );
  AOI22_X1 datapath_FIR_Reg_Sample6_U16 ( .A1(datapath_FIR_x5[4]), .A2(
        datapath_FIR_Reg_Sample6_n25), .B1(datapath_FIR_x6[4]), .B2(
        datapath_FIR_Reg_Sample6_n24), .ZN(datapath_FIR_Reg_Sample6_n20) );
  AOI22_X1 datapath_FIR_Reg_Sample6_U15 ( .A1(datapath_FIR_x5[2]), .A2(
        datapath_FIR_Reg_Sample6_n25), .B1(datapath_FIR_x6[2]), .B2(
        datapath_FIR_Reg_Sample6_n24), .ZN(datapath_FIR_Reg_Sample6_n22) );
  INV_X1 datapath_FIR_Reg_Sample6_U14 ( .A(datapath_FIR_Reg_Sample6_n19), .ZN(
        datapath_FIR_Reg_Sample6_n2) );
  INV_X1 datapath_FIR_Reg_Sample6_U13 ( .A(datapath_FIR_Reg_Sample6_n20), .ZN(
        datapath_FIR_Reg_Sample6_n3) );
  INV_X1 datapath_FIR_Reg_Sample6_U12 ( .A(datapath_FIR_Reg_Sample6_n22), .ZN(
        datapath_FIR_Reg_Sample6_n5) );
  INV_X1 datapath_FIR_Reg_Sample6_U11 ( .A(datapath_FIR_Reg_Sample6_n23), .ZN(
        datapath_FIR_Reg_Sample6_n6) );
  INV_X1 datapath_FIR_Reg_Sample6_U10 ( .A(datapath_FIR_Reg_Sample6_n26), .ZN(
        datapath_FIR_Reg_Sample6_n7) );
  AOI22_X1 datapath_FIR_Reg_Sample6_U9 ( .A1(datapath_FIR_x5[6]), .A2(
        datapath_FIR_Reg_Sample6_n25), .B1(datapath_FIR_x6[6]), .B2(
        datapath_FIR_Reg_Sample6_n24), .ZN(datapath_FIR_Reg_Sample6_n18) );
  INV_X1 datapath_FIR_Reg_Sample6_U8 ( .A(datapath_FIR_Reg_Sample6_n18), .ZN(
        datapath_FIR_Reg_Sample6_n1) );
  AOI22_X1 datapath_FIR_Reg_Sample6_U7 ( .A1(datapath_FIR_x5[3]), .A2(
        datapath_FIR_Reg_Sample6_n25), .B1(datapath_FIR_x6[3]), .B2(
        datapath_FIR_Reg_Sample6_n24), .ZN(datapath_FIR_Reg_Sample6_n21) );
  INV_X1 datapath_FIR_Reg_Sample6_U6 ( .A(datapath_FIR_Reg_Sample6_n21), .ZN(
        datapath_FIR_Reg_Sample6_n4) );
  INV_X1 datapath_FIR_Reg_Sample6_U5 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_Sample6_n8) );
  NOR2_X1 datapath_FIR_Reg_Sample6_U4 ( .A1(datapath_FIR_Reg_Sample6_n8), .A2(
        datapath_FIR_Reg_Sample6_n24), .ZN(datapath_FIR_Reg_Sample6_n25) );
  NOR2_X1 datapath_FIR_Reg_Sample6_U3 ( .A1(reg_out_en), .A2(
        datapath_FIR_Reg_Sample6_n8), .ZN(datapath_FIR_Reg_Sample6_n24) );
  DFF_X1 datapath_FIR_Reg_Sample6_q_reg_0_ ( .D(datapath_FIR_Reg_Sample6_n7), 
        .CK(clk), .Q(datapath_FIR_x6[0]) );
  DFF_X1 datapath_FIR_Reg_Sample6_q_reg_1_ ( .D(datapath_FIR_Reg_Sample6_n6), 
        .CK(clk), .Q(datapath_FIR_x6[1]) );
  DFF_X1 datapath_FIR_Reg_Sample6_q_reg_2_ ( .D(datapath_FIR_Reg_Sample6_n5), 
        .CK(clk), .Q(datapath_FIR_x6[2]) );
  DFF_X1 datapath_FIR_Reg_Sample6_q_reg_3_ ( .D(datapath_FIR_Reg_Sample6_n4), 
        .CK(clk), .Q(datapath_FIR_x6[3]) );
  DFF_X1 datapath_FIR_Reg_Sample6_q_reg_4_ ( .D(datapath_FIR_Reg_Sample6_n3), 
        .CK(clk), .Q(datapath_FIR_x6[4]) );
  DFF_X1 datapath_FIR_Reg_Sample6_q_reg_5_ ( .D(datapath_FIR_Reg_Sample6_n2), 
        .CK(clk), .Q(datapath_FIR_x6[5]) );
  DFF_X1 datapath_FIR_Reg_Sample6_q_reg_6_ ( .D(datapath_FIR_Reg_Sample6_n1), 
        .CK(clk), .Q(datapath_FIR_x6[6]) );
  AOI22_X1 datapath_FIR_Reg_Sample7_U20 ( .A1(datapath_FIR_x6[0]), .A2(
        datapath_FIR_Reg_Sample7_n28), .B1(datapath_FIR_x7[0]), .B2(
        datapath_FIR_Reg_Sample7_n27), .ZN(datapath_FIR_Reg_Sample7_n29) );
  AOI22_X1 datapath_FIR_Reg_Sample7_U19 ( .A1(datapath_FIR_x6[4]), .A2(
        datapath_FIR_Reg_Sample7_n28), .B1(datapath_FIR_x7[4]), .B2(
        datapath_FIR_Reg_Sample7_n27), .ZN(datapath_FIR_Reg_Sample7_n23) );
  AOI22_X1 datapath_FIR_Reg_Sample7_U18 ( .A1(datapath_FIR_x6[5]), .A2(
        datapath_FIR_Reg_Sample7_n28), .B1(datapath_FIR_x7[5]), .B2(
        datapath_FIR_Reg_Sample7_n27), .ZN(datapath_FIR_Reg_Sample7_n22) );
  AOI22_X1 datapath_FIR_Reg_Sample7_U17 ( .A1(datapath_FIR_x6[1]), .A2(
        datapath_FIR_Reg_Sample7_n28), .B1(datapath_FIR_Reg_Sample7_n2), .B2(
        datapath_FIR_Reg_Sample7_n27), .ZN(datapath_FIR_Reg_Sample7_n26) );
  AOI22_X1 datapath_FIR_Reg_Sample7_U16 ( .A1(datapath_FIR_x6[2]), .A2(
        datapath_FIR_Reg_Sample7_n28), .B1(datapath_FIR_x7[2]), .B2(
        datapath_FIR_Reg_Sample7_n27), .ZN(datapath_FIR_Reg_Sample7_n25) );
  INV_X1 datapath_FIR_Reg_Sample7_U15 ( .A(datapath_FIR_Reg_Sample7_n22), .ZN(
        datapath_FIR_Reg_Sample7_n5) );
  INV_X1 datapath_FIR_Reg_Sample7_U14 ( .A(datapath_FIR_Reg_Sample7_n23), .ZN(
        datapath_FIR_Reg_Sample7_n6) );
  AOI22_X1 datapath_FIR_Reg_Sample7_U13 ( .A1(datapath_FIR_x6[3]), .A2(
        datapath_FIR_Reg_Sample7_n28), .B1(datapath_FIR_x7[3]), .B2(
        datapath_FIR_Reg_Sample7_n27), .ZN(datapath_FIR_Reg_Sample7_n24) );
  AOI22_X1 datapath_FIR_Reg_Sample7_U12 ( .A1(datapath_FIR_x6[6]), .A2(
        datapath_FIR_Reg_Sample7_n28), .B1(datapath_FIR_x7[6]), .B2(
        datapath_FIR_Reg_Sample7_n27), .ZN(datapath_FIR_Reg_Sample7_n21) );
  INV_X1 datapath_FIR_Reg_Sample7_U11 ( .A(datapath_FIR_Reg_Sample7_n21), .ZN(
        datapath_FIR_Reg_Sample7_n4) );
  INV_X1 datapath_FIR_Reg_Sample7_U10 ( .A(datapath_FIR_Reg_Sample7_n25), .ZN(
        datapath_FIR_Reg_Sample7_n8) );
  INV_X1 datapath_FIR_Reg_Sample7_U9 ( .A(datapath_FIR_Reg_Sample7_n26), .ZN(
        datapath_FIR_Reg_Sample7_n18) );
  INV_X1 datapath_FIR_Reg_Sample7_U8 ( .A(datapath_FIR_Reg_Sample7_n29), .ZN(
        datapath_FIR_Reg_Sample7_n19) );
  INV_X1 datapath_FIR_Reg_Sample7_U7 ( .A(datapath_FIR_Reg_Sample7_n24), .ZN(
        datapath_FIR_Reg_Sample7_n7) );
  INV_X1 datapath_FIR_Reg_Sample7_U6 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_Sample7_n20) );
  NOR2_X1 datapath_FIR_Reg_Sample7_U5 ( .A1(datapath_FIR_Reg_Sample7_n20), 
        .A2(datapath_FIR_Reg_Sample7_n27), .ZN(datapath_FIR_Reg_Sample7_n28)
         );
  NOR2_X1 datapath_FIR_Reg_Sample7_U4 ( .A1(reg_out_en), .A2(
        datapath_FIR_Reg_Sample7_n20), .ZN(datapath_FIR_Reg_Sample7_n27) );
  INV_X1 datapath_FIR_Reg_Sample7_U3 ( .A(datapath_FIR_Reg_Sample7_n1), .ZN(
        datapath_FIR_Reg_Sample7_n2) );
  DFF_X1 datapath_FIR_Reg_Sample7_q_reg_3_ ( .D(datapath_FIR_Reg_Sample7_n7), 
        .CK(clk), .Q(datapath_FIR_x7[3]) );
  DFF_X1 datapath_FIR_Reg_Sample7_q_reg_5_ ( .D(datapath_FIR_Reg_Sample7_n5), 
        .CK(clk), .Q(datapath_FIR_x7[5]) );
  DFF_X1 datapath_FIR_Reg_Sample7_q_reg_0_ ( .D(datapath_FIR_Reg_Sample7_n19), 
        .CK(clk), .Q(datapath_FIR_x7[0]) );
  DFF_X1 datapath_FIR_Reg_Sample7_q_reg_1_ ( .D(datapath_FIR_Reg_Sample7_n18), 
        .CK(clk), .Q(datapath_FIR_x7[1]), .QN(datapath_FIR_Reg_Sample7_n1) );
  DFF_X1 datapath_FIR_Reg_Sample7_q_reg_2_ ( .D(datapath_FIR_Reg_Sample7_n8), 
        .CK(clk), .Q(datapath_FIR_x7[2]) );
  DFF_X1 datapath_FIR_Reg_Sample7_q_reg_4_ ( .D(datapath_FIR_Reg_Sample7_n6), 
        .CK(clk), .Q(datapath_FIR_x7[4]) );
  DFF_X1 datapath_FIR_Reg_Sample7_q_reg_6_ ( .D(datapath_FIR_Reg_Sample7_n4), 
        .CK(clk), .Q(datapath_FIR_x7[6]) );
  AOI22_X1 datapath_FIR_Reg_Sample8_U21 ( .A1(datapath_FIR_n1), .A2(
        datapath_FIR_Reg_Sample8_n29), .B1(datapath_FIR_Reg_Sample8_n2), .B2(
        datapath_FIR_Reg_Sample8_n28), .ZN(datapath_FIR_Reg_Sample8_n30) );
  AOI22_X1 datapath_FIR_Reg_Sample8_U20 ( .A1(datapath_FIR_x7[1]), .A2(
        datapath_FIR_Reg_Sample8_n29), .B1(datapath_FIR_Reg_Sample8_n4), .B2(
        datapath_FIR_Reg_Sample8_n28), .ZN(datapath_FIR_Reg_Sample8_n27) );
  AOI22_X1 datapath_FIR_Reg_Sample8_U19 ( .A1(datapath_FIR_x7[5]), .A2(
        datapath_FIR_Reg_Sample8_n29), .B1(datapath_FIR_x8[5]), .B2(
        datapath_FIR_Reg_Sample8_n28), .ZN(datapath_FIR_Reg_Sample8_n23) );
  AOI22_X1 datapath_FIR_Reg_Sample8_U18 ( .A1(datapath_FIR_x7[4]), .A2(
        datapath_FIR_Reg_Sample8_n29), .B1(datapath_FIR_x8[4]), .B2(
        datapath_FIR_Reg_Sample8_n28), .ZN(datapath_FIR_Reg_Sample8_n24) );
  AOI22_X1 datapath_FIR_Reg_Sample8_U17 ( .A1(datapath_FIR_x7[2]), .A2(
        datapath_FIR_Reg_Sample8_n29), .B1(datapath_FIR_x8[2]), .B2(
        datapath_FIR_Reg_Sample8_n28), .ZN(datapath_FIR_Reg_Sample8_n26) );
  INV_X1 datapath_FIR_Reg_Sample8_U16 ( .A(datapath_FIR_Reg_Sample8_n27), .ZN(
        datapath_FIR_Reg_Sample8_n19) );
  AOI22_X1 datapath_FIR_Reg_Sample8_U15 ( .A1(datapath_FIR_x7[3]), .A2(
        datapath_FIR_Reg_Sample8_n29), .B1(datapath_FIR_x8[3]), .B2(
        datapath_FIR_Reg_Sample8_n28), .ZN(datapath_FIR_Reg_Sample8_n25) );
  AOI22_X1 datapath_FIR_Reg_Sample8_U14 ( .A1(datapath_FIR_x7[6]), .A2(
        datapath_FIR_Reg_Sample8_n29), .B1(datapath_FIR_x8[6]), .B2(
        datapath_FIR_Reg_Sample8_n28), .ZN(datapath_FIR_Reg_Sample8_n22) );
  INV_X1 datapath_FIR_Reg_Sample8_U13 ( .A(datapath_FIR_Reg_Sample8_n22), .ZN(
        datapath_FIR_Reg_Sample8_n5) );
  INV_X1 datapath_FIR_Reg_Sample8_U12 ( .A(datapath_FIR_Reg_Sample8_n25), .ZN(
        datapath_FIR_Reg_Sample8_n8) );
  INV_X1 datapath_FIR_Reg_Sample8_U11 ( .A(datapath_FIR_Reg_Sample8_n26), .ZN(
        datapath_FIR_Reg_Sample8_n18) );
  INV_X1 datapath_FIR_Reg_Sample8_U10 ( .A(datapath_FIR_Reg_Sample8_n30), .ZN(
        datapath_FIR_Reg_Sample8_n20) );
  INV_X1 datapath_FIR_Reg_Sample8_U9 ( .A(datapath_FIR_Reg_Sample8_n24), .ZN(
        datapath_FIR_Reg_Sample8_n7) );
  INV_X1 datapath_FIR_Reg_Sample8_U8 ( .A(datapath_FIR_Reg_Sample8_n23), .ZN(
        datapath_FIR_Reg_Sample8_n6) );
  INV_X1 datapath_FIR_Reg_Sample8_U7 ( .A(reg_rst_n), .ZN(
        datapath_FIR_Reg_Sample8_n21) );
  NOR2_X1 datapath_FIR_Reg_Sample8_U6 ( .A1(datapath_FIR_Reg_Sample8_n21), 
        .A2(datapath_FIR_Reg_Sample8_n28), .ZN(datapath_FIR_Reg_Sample8_n29)
         );
  NOR2_X1 datapath_FIR_Reg_Sample8_U5 ( .A1(reg_out_en), .A2(
        datapath_FIR_Reg_Sample8_n21), .ZN(datapath_FIR_Reg_Sample8_n28) );
  INV_X1 datapath_FIR_Reg_Sample8_U4 ( .A(datapath_FIR_Reg_Sample8_n3), .ZN(
        datapath_FIR_Reg_Sample8_n4) );
  INV_X1 datapath_FIR_Reg_Sample8_U3 ( .A(datapath_FIR_Reg_Sample8_n1), .ZN(
        datapath_FIR_Reg_Sample8_n2) );
  DFF_X1 datapath_FIR_Reg_Sample8_q_reg_5_ ( .D(datapath_FIR_Reg_Sample8_n6), 
        .CK(clk), .Q(datapath_FIR_x8[5]) );
  DFF_X1 datapath_FIR_Reg_Sample8_q_reg_4_ ( .D(datapath_FIR_Reg_Sample8_n7), 
        .CK(clk), .Q(datapath_FIR_x8[4]) );
  DFF_X1 datapath_FIR_Reg_Sample8_q_reg_0_ ( .D(datapath_FIR_Reg_Sample8_n20), 
        .CK(clk), .Q(datapath_FIR_x8[0]), .QN(datapath_FIR_Reg_Sample8_n1) );
  DFF_X1 datapath_FIR_Reg_Sample8_q_reg_1_ ( .D(datapath_FIR_Reg_Sample8_n19), 
        .CK(clk), .Q(datapath_FIR_x8[1]), .QN(datapath_FIR_Reg_Sample8_n3) );
  DFF_X1 datapath_FIR_Reg_Sample8_q_reg_2_ ( .D(datapath_FIR_Reg_Sample8_n18), 
        .CK(clk), .Q(datapath_FIR_x8[2]) );
  DFF_X1 datapath_FIR_Reg_Sample8_q_reg_3_ ( .D(datapath_FIR_Reg_Sample8_n8), 
        .CK(clk), .Q(datapath_FIR_x8[3]) );
  DFF_X1 datapath_FIR_Reg_Sample8_q_reg_6_ ( .D(datapath_FIR_Reg_Sample8_n5), 
        .CK(clk), .Q(datapath_FIR_x8[6]) );
  AOI22_X1 datapath_FIR_Reg_out_U19 ( .A1(datapath_FIR_Y[6]), .A2(
        datapath_FIR_Reg_out_n25), .B1(DOUT[7]), .B2(datapath_FIR_Reg_out_n24), 
        .ZN(datapath_FIR_Reg_out_n18) );
  INV_X1 datapath_FIR_Reg_out_U18 ( .A(datapath_FIR_Reg_out_n18), .ZN(
        datapath_FIR_Reg_out_n1) );
  AOI22_X1 datapath_FIR_Reg_out_U17 ( .A1(datapath_FIR_Y[2]), .A2(
        datapath_FIR_Reg_out_n25), .B1(DOUT[3]), .B2(datapath_FIR_Reg_out_n24), 
        .ZN(datapath_FIR_Reg_out_n22) );
  INV_X1 datapath_FIR_Reg_out_U16 ( .A(datapath_FIR_Reg_out_n22), .ZN(
        datapath_FIR_Reg_out_n5) );
  AOI22_X1 datapath_FIR_Reg_out_U15 ( .A1(datapath_FIR_Y[1]), .A2(
        datapath_FIR_Reg_out_n25), .B1(DOUT[2]), .B2(datapath_FIR_Reg_out_n24), 
        .ZN(datapath_FIR_Reg_out_n23) );
  INV_X1 datapath_FIR_Reg_out_U14 ( .A(datapath_FIR_Reg_out_n23), .ZN(
        datapath_FIR_Reg_out_n6) );
  AOI22_X1 datapath_FIR_Reg_out_U13 ( .A1(datapath_FIR_Y[0]), .A2(
        datapath_FIR_Reg_out_n25), .B1(DOUT[1]), .B2(datapath_FIR_Reg_out_n24), 
        .ZN(datapath_FIR_Reg_out_n26) );
  INV_X1 datapath_FIR_Reg_out_U12 ( .A(datapath_FIR_Reg_out_n26), .ZN(
        datapath_FIR_Reg_out_n7) );
  AOI22_X1 datapath_FIR_Reg_out_U11 ( .A1(datapath_FIR_Y[4]), .A2(
        datapath_FIR_Reg_out_n25), .B1(DOUT[5]), .B2(datapath_FIR_Reg_out_n24), 
        .ZN(datapath_FIR_Reg_out_n20) );
  INV_X1 datapath_FIR_Reg_out_U10 ( .A(datapath_FIR_Reg_out_n20), .ZN(
        datapath_FIR_Reg_out_n3) );
  AOI22_X1 datapath_FIR_Reg_out_U9 ( .A1(datapath_FIR_Y[3]), .A2(
        datapath_FIR_Reg_out_n25), .B1(DOUT[4]), .B2(datapath_FIR_Reg_out_n24), 
        .ZN(datapath_FIR_Reg_out_n21) );
  INV_X1 datapath_FIR_Reg_out_U8 ( .A(datapath_FIR_Reg_out_n21), .ZN(
        datapath_FIR_Reg_out_n4) );
  AOI22_X1 datapath_FIR_Reg_out_U7 ( .A1(datapath_FIR_Y[5]), .A2(
        datapath_FIR_Reg_out_n25), .B1(DOUT[6]), .B2(datapath_FIR_Reg_out_n24), 
        .ZN(datapath_FIR_Reg_out_n19) );
  INV_X1 datapath_FIR_Reg_out_U6 ( .A(datapath_FIR_Reg_out_n19), .ZN(
        datapath_FIR_Reg_out_n2) );
  INV_X1 datapath_FIR_Reg_out_U5 ( .A(reg_rst_n), .ZN(datapath_FIR_Reg_out_n8)
         );
  NOR2_X1 datapath_FIR_Reg_out_U4 ( .A1(datapath_FIR_Reg_out_n8), .A2(
        datapath_FIR_Reg_out_n24), .ZN(datapath_FIR_Reg_out_n25) );
  NOR2_X1 datapath_FIR_Reg_out_U3 ( .A1(reg_out_en), .A2(
        datapath_FIR_Reg_out_n8), .ZN(datapath_FIR_Reg_out_n24) );
  DFF_X1 datapath_FIR_Reg_out_q_reg_0_ ( .D(datapath_FIR_Reg_out_n7), .CK(clk), 
        .Q(DOUT[1]) );
  DFF_X1 datapath_FIR_Reg_out_q_reg_1_ ( .D(datapath_FIR_Reg_out_n6), .CK(clk), 
        .Q(DOUT[2]) );
  DFF_X1 datapath_FIR_Reg_out_q_reg_2_ ( .D(datapath_FIR_Reg_out_n5), .CK(clk), 
        .Q(DOUT[3]) );
  DFF_X1 datapath_FIR_Reg_out_q_reg_3_ ( .D(datapath_FIR_Reg_out_n4), .CK(clk), 
        .Q(DOUT[4]) );
  DFF_X1 datapath_FIR_Reg_out_q_reg_4_ ( .D(datapath_FIR_Reg_out_n3), .CK(clk), 
        .Q(DOUT[5]) );
  DFF_X1 datapath_FIR_Reg_out_q_reg_5_ ( .D(datapath_FIR_Reg_out_n2), .CK(clk), 
        .Q(DOUT[6]) );
  DFF_X1 datapath_FIR_Reg_out_q_reg_6_ ( .D(datapath_FIR_Reg_out_n1), .CK(clk), 
        .Q(DOUT[7]) );
  NOR2_X1 datapath_FIR_mult_205_U179 ( .A1(datapath_FIR_mult_205_n172), .A2(
        datapath_FIR_mult_205_n169), .ZN(datapath_FIR_mult_205_n100) );
  NAND2_X1 datapath_FIR_mult_205_U178 ( .A1(datapath_FIR_x0[2]), .A2(
        datapath_FIR_bq0[6]), .ZN(datapath_FIR_mult_205_n101) );
  NOR2_X1 datapath_FIR_mult_205_U177 ( .A1(datapath_FIR_mult_205_n161), .A2(
        datapath_FIR_mult_205_n173), .ZN(datapath_FIR_mult_205_n102) );
  NOR2_X1 datapath_FIR_mult_205_U176 ( .A1(datapath_FIR_mult_205_n162), .A2(
        datapath_FIR_mult_205_n173), .ZN(datapath_FIR_mult_205_n103) );
  NOR2_X1 datapath_FIR_mult_205_U175 ( .A1(datapath_FIR_mult_205_n165), .A2(
        datapath_FIR_mult_205_n173), .ZN(datapath_FIR_mult_205_n104) );
  NOR2_X1 datapath_FIR_mult_205_U174 ( .A1(datapath_FIR_mult_205_n166), .A2(
        datapath_FIR_mult_205_n173), .ZN(datapath_FIR_mult_205_n105) );
  NOR2_X1 datapath_FIR_mult_205_U173 ( .A1(datapath_FIR_mult_205_n168), .A2(
        datapath_FIR_mult_205_n173), .ZN(datapath_FIR_mult_205_n106) );
  NAND2_X1 datapath_FIR_mult_205_U172 ( .A1(datapath_FIR_x0[1]), .A2(
        datapath_FIR_bq0[6]), .ZN(datapath_FIR_mult_205_n108) );
  NOR2_X1 datapath_FIR_mult_205_U171 ( .A1(datapath_FIR_mult_205_n161), .A2(
        datapath_FIR_mult_205_n174), .ZN(datapath_FIR_mult_205_n109) );
  NOR2_X1 datapath_FIR_mult_205_U170 ( .A1(datapath_FIR_mult_205_n162), .A2(
        datapath_FIR_mult_205_n174), .ZN(datapath_FIR_mult_205_n110) );
  NOR2_X1 datapath_FIR_mult_205_U169 ( .A1(datapath_FIR_mult_205_n165), .A2(
        datapath_FIR_mult_205_n174), .ZN(datapath_FIR_mult_205_n111) );
  NOR2_X1 datapath_FIR_mult_205_U168 ( .A1(datapath_FIR_mult_205_n166), .A2(
        datapath_FIR_mult_205_n174), .ZN(datapath_FIR_mult_205_n112) );
  NOR2_X1 datapath_FIR_mult_205_U167 ( .A1(datapath_FIR_mult_205_n168), .A2(
        datapath_FIR_mult_205_n174), .ZN(datapath_FIR_mult_205_n113) );
  NAND2_X1 datapath_FIR_mult_205_U166 ( .A1(datapath_FIR_x0[0]), .A2(
        datapath_FIR_bq0[6]), .ZN(datapath_FIR_mult_205_n115) );
  NOR2_X1 datapath_FIR_mult_205_U165 ( .A1(datapath_FIR_mult_205_n161), .A2(
        datapath_FIR_mult_205_n175), .ZN(datapath_FIR_mult_205_n116) );
  NOR2_X1 datapath_FIR_mult_205_U164 ( .A1(datapath_FIR_mult_205_n162), .A2(
        datapath_FIR_mult_205_n175), .ZN(datapath_FIR_mult_205_n117) );
  NOR2_X1 datapath_FIR_mult_205_U163 ( .A1(datapath_FIR_mult_205_n165), .A2(
        datapath_FIR_mult_205_n175), .ZN(datapath_FIR_mult_205_n118) );
  NOR2_X1 datapath_FIR_mult_205_U162 ( .A1(datapath_FIR_mult_205_n166), .A2(
        datapath_FIR_mult_205_n175), .ZN(datapath_FIR_mult_205_n119) );
  NAND2_X1 datapath_FIR_mult_205_U161 ( .A1(datapath_FIR_bq0[4]), .A2(
        datapath_FIR_x0[3]), .ZN(datapath_FIR_mult_205_n184) );
  NAND2_X1 datapath_FIR_mult_205_U160 ( .A1(datapath_FIR_x0[5]), .A2(
        datapath_FIR_bq0[2]), .ZN(datapath_FIR_mult_205_n183) );
  NAND2_X1 datapath_FIR_mult_205_U159 ( .A1(datapath_FIR_mult_205_n184), .A2(
        datapath_FIR_mult_205_n183), .ZN(datapath_FIR_mult_205_n41) );
  XNOR2_X1 datapath_FIR_mult_205_U158 ( .A(datapath_FIR_mult_205_n183), .B(
        datapath_FIR_mult_205_n184), .ZN(datapath_FIR_mult_205_n42) );
  NAND2_X1 datapath_FIR_mult_205_U157 ( .A1(datapath_FIR_bq0[5]), .A2(
        datapath_FIR_x0[6]), .ZN(datapath_FIR_mult_205_n74) );
  NAND2_X1 datapath_FIR_mult_205_U156 ( .A1(datapath_FIR_bq0[4]), .A2(
        datapath_FIR_x0[6]), .ZN(datapath_FIR_mult_205_n75) );
  NAND2_X1 datapath_FIR_mult_205_U155 ( .A1(datapath_FIR_bq0[3]), .A2(
        datapath_FIR_x0[6]), .ZN(datapath_FIR_mult_205_n76) );
  NAND2_X1 datapath_FIR_mult_205_U154 ( .A1(datapath_FIR_bq0[2]), .A2(
        datapath_FIR_x0[6]), .ZN(datapath_FIR_mult_205_n77) );
  NAND2_X1 datapath_FIR_mult_205_U153 ( .A1(datapath_FIR_bq0[1]), .A2(
        datapath_FIR_x0[6]), .ZN(datapath_FIR_mult_205_n78) );
  NAND2_X1 datapath_FIR_mult_205_U152 ( .A1(datapath_FIR_bq0[0]), .A2(
        datapath_FIR_x0[6]), .ZN(datapath_FIR_mult_205_n79) );
  NOR4_X1 datapath_FIR_mult_205_U151 ( .A1(datapath_FIR_mult_205_n174), .A2(
        datapath_FIR_mult_205_n175), .A3(datapath_FIR_mult_205_n169), .A4(
        datapath_FIR_mult_205_n168), .ZN(datapath_FIR_mult_205_n181) );
  NOR2_X1 datapath_FIR_mult_205_U150 ( .A1(datapath_FIR_mult_205_n173), .A2(
        datapath_FIR_mult_205_n169), .ZN(datapath_FIR_mult_205_n182) );
  AOI222_X1 datapath_FIR_mult_205_U149 ( .A1(datapath_FIR_mult_205_n72), .A2(
        datapath_FIR_mult_205_n181), .B1(datapath_FIR_mult_205_n182), .B2(
        datapath_FIR_mult_205_n72), .C1(datapath_FIR_mult_205_n182), .C2(
        datapath_FIR_mult_205_n181), .ZN(datapath_FIR_mult_205_n180) );
  OAI222_X1 datapath_FIR_mult_205_U148 ( .A1(datapath_FIR_mult_205_n180), .A2(
        datapath_FIR_mult_205_n164), .B1(datapath_FIR_mult_205_n164), .B2(
        datapath_FIR_mult_205_n167), .C1(datapath_FIR_mult_205_n180), .C2(
        datapath_FIR_mult_205_n167), .ZN(datapath_FIR_mult_205_n179) );
  AOI222_X1 datapath_FIR_mult_205_U147 ( .A1(datapath_FIR_mult_205_n179), .A2(
        datapath_FIR_mult_205_n62), .B1(datapath_FIR_mult_205_n179), .B2(
        datapath_FIR_mult_205_n64), .C1(datapath_FIR_mult_205_n64), .C2(
        datapath_FIR_mult_205_n62), .ZN(datapath_FIR_mult_205_n178) );
  OAI222_X1 datapath_FIR_mult_205_U146 ( .A1(datapath_FIR_mult_205_n178), .A2(
        datapath_FIR_mult_205_n160), .B1(datapath_FIR_mult_205_n178), .B2(
        datapath_FIR_mult_205_n163), .C1(datapath_FIR_mult_205_n163), .C2(
        datapath_FIR_mult_205_n160), .ZN(datapath_FIR_mult_205_n8) );
  NAND2_X1 datapath_FIR_mult_205_U145 ( .A1(datapath_FIR_x0[5]), .A2(
        datapath_FIR_bq0[6]), .ZN(datapath_FIR_mult_205_n80) );
  NOR2_X1 datapath_FIR_mult_205_U144 ( .A1(datapath_FIR_mult_205_n161), .A2(
        datapath_FIR_mult_205_n170), .ZN(datapath_FIR_mult_205_n81) );
  NOR2_X1 datapath_FIR_mult_205_U143 ( .A1(datapath_FIR_mult_205_n162), .A2(
        datapath_FIR_mult_205_n170), .ZN(datapath_FIR_mult_205_n82) );
  NOR2_X1 datapath_FIR_mult_205_U142 ( .A1(datapath_FIR_mult_205_n165), .A2(
        datapath_FIR_mult_205_n170), .ZN(datapath_FIR_mult_205_n83) );
  NOR2_X1 datapath_FIR_mult_205_U141 ( .A1(datapath_FIR_mult_205_n168), .A2(
        datapath_FIR_mult_205_n170), .ZN(datapath_FIR_mult_205_n85) );
  NOR2_X1 datapath_FIR_mult_205_U140 ( .A1(datapath_FIR_mult_205_n169), .A2(
        datapath_FIR_mult_205_n170), .ZN(datapath_FIR_mult_205_n86) );
  NAND2_X1 datapath_FIR_mult_205_U139 ( .A1(datapath_FIR_x0[4]), .A2(
        datapath_FIR_bq0[6]), .ZN(datapath_FIR_mult_205_n87) );
  NOR2_X1 datapath_FIR_mult_205_U138 ( .A1(datapath_FIR_mult_205_n161), .A2(
        datapath_FIR_mult_205_n171), .ZN(datapath_FIR_mult_205_n88) );
  NOR2_X1 datapath_FIR_mult_205_U137 ( .A1(datapath_FIR_mult_205_n171), .A2(
        datapath_FIR_mult_205_n162), .ZN(datapath_FIR_mult_205_n89) );
  NOR2_X1 datapath_FIR_mult_205_U136 ( .A1(datapath_FIR_mult_205_n165), .A2(
        datapath_FIR_mult_205_n171), .ZN(datapath_FIR_mult_205_n90) );
  NOR2_X1 datapath_FIR_mult_205_U135 ( .A1(datapath_FIR_mult_205_n166), .A2(
        datapath_FIR_mult_205_n171), .ZN(datapath_FIR_mult_205_n91) );
  NOR2_X1 datapath_FIR_mult_205_U134 ( .A1(datapath_FIR_mult_205_n168), .A2(
        datapath_FIR_mult_205_n171), .ZN(datapath_FIR_mult_205_n92) );
  NOR2_X1 datapath_FIR_mult_205_U133 ( .A1(datapath_FIR_mult_205_n171), .A2(
        datapath_FIR_mult_205_n169), .ZN(datapath_FIR_mult_205_n93) );
  NAND2_X1 datapath_FIR_mult_205_U132 ( .A1(datapath_FIR_x0[3]), .A2(
        datapath_FIR_bq0[6]), .ZN(datapath_FIR_mult_205_n94) );
  NOR2_X1 datapath_FIR_mult_205_U131 ( .A1(datapath_FIR_mult_205_n172), .A2(
        datapath_FIR_mult_205_n161), .ZN(datapath_FIR_mult_205_n95) );
  NOR2_X1 datapath_FIR_mult_205_U130 ( .A1(datapath_FIR_mult_205_n172), .A2(
        datapath_FIR_mult_205_n165), .ZN(datapath_FIR_mult_205_n97) );
  NOR2_X1 datapath_FIR_mult_205_U129 ( .A1(datapath_FIR_mult_205_n172), .A2(
        datapath_FIR_mult_205_n166), .ZN(datapath_FIR_mult_205_n98) );
  NOR2_X1 datapath_FIR_mult_205_U128 ( .A1(datapath_FIR_mult_205_n172), .A2(
        datapath_FIR_mult_205_n168), .ZN(datapath_FIR_mult_205_n99) );
  NAND2_X1 datapath_FIR_mult_205_U127 ( .A1(datapath_FIR_bq0[6]), .A2(
        datapath_FIR_x0[6]), .ZN(datapath_FIR_mult_205_n176) );
  XNOR2_X1 datapath_FIR_mult_205_U126 ( .A(datapath_FIR_mult_205_n2), .B(
        datapath_FIR_mult_205_n13), .ZN(datapath_FIR_mult_205_n177) );
  XOR2_X1 datapath_FIR_mult_205_U125 ( .A(datapath_FIR_mult_205_n176), .B(
        datapath_FIR_mult_205_n177), .Z(datapath_FIR_M0_12_) );
  INV_X1 datapath_FIR_mult_205_U124 ( .A(datapath_FIR_bq0[0]), .ZN(
        datapath_FIR_mult_205_n169) );
  INV_X1 datapath_FIR_mult_205_U123 ( .A(datapath_FIR_x0[0]), .ZN(
        datapath_FIR_mult_205_n175) );
  INV_X1 datapath_FIR_mult_205_U122 ( .A(datapath_FIR_x0[5]), .ZN(
        datapath_FIR_mult_205_n170) );
  INV_X1 datapath_FIR_mult_205_U121 ( .A(datapath_FIR_bq0[2]), .ZN(
        datapath_FIR_mult_205_n166) );
  INV_X1 datapath_FIR_mult_205_U120 ( .A(datapath_FIR_bq0[4]), .ZN(
        datapath_FIR_mult_205_n162) );
  INV_X1 datapath_FIR_mult_205_U119 ( .A(datapath_FIR_x0[3]), .ZN(
        datapath_FIR_mult_205_n172) );
  INV_X1 datapath_FIR_mult_205_U118 ( .A(datapath_FIR_x0[2]), .ZN(
        datapath_FIR_mult_205_n173) );
  INV_X1 datapath_FIR_mult_205_U117 ( .A(datapath_FIR_x0[1]), .ZN(
        datapath_FIR_mult_205_n174) );
  INV_X1 datapath_FIR_mult_205_U116 ( .A(datapath_FIR_x0[4]), .ZN(
        datapath_FIR_mult_205_n171) );
  INV_X1 datapath_FIR_mult_205_U115 ( .A(datapath_FIR_bq0[1]), .ZN(
        datapath_FIR_mult_205_n168) );
  INV_X1 datapath_FIR_mult_205_U114 ( .A(datapath_FIR_bq0[3]), .ZN(
        datapath_FIR_mult_205_n165) );
  INV_X1 datapath_FIR_mult_205_U113 ( .A(datapath_FIR_bq0[5]), .ZN(
        datapath_FIR_mult_205_n161) );
  INV_X1 datapath_FIR_mult_205_U112 ( .A(datapath_FIR_mult_205_n68), .ZN(
        datapath_FIR_mult_205_n164) );
  INV_X1 datapath_FIR_mult_205_U111 ( .A(datapath_FIR_mult_205_n54), .ZN(
        datapath_FIR_mult_205_n160) );
  INV_X1 datapath_FIR_mult_205_U110 ( .A(datapath_FIR_mult_205_n61), .ZN(
        datapath_FIR_mult_205_n163) );
  INV_X1 datapath_FIR_mult_205_U109 ( .A(datapath_FIR_mult_205_n70), .ZN(
        datapath_FIR_mult_205_n167) );
  HA_X1 datapath_FIR_mult_205_U44 ( .A(datapath_FIR_mult_205_n113), .B(
        datapath_FIR_mult_205_n119), .CO(datapath_FIR_mult_205_n71), .S(
        datapath_FIR_mult_205_n72) );
  HA_X1 datapath_FIR_mult_205_U43 ( .A(datapath_FIR_mult_205_n100), .B(
        datapath_FIR_mult_205_n106), .CO(datapath_FIR_mult_205_n69), .S(
        datapath_FIR_mult_205_n70) );
  FA_X1 datapath_FIR_mult_205_U42 ( .A(datapath_FIR_mult_205_n112), .B(
        datapath_FIR_mult_205_n118), .CI(datapath_FIR_mult_205_n71), .CO(
        datapath_FIR_mult_205_n67), .S(datapath_FIR_mult_205_n68) );
  HA_X1 datapath_FIR_mult_205_U41 ( .A(datapath_FIR_mult_205_n93), .B(
        datapath_FIR_mult_205_n99), .CO(datapath_FIR_mult_205_n65), .S(
        datapath_FIR_mult_205_n66) );
  FA_X1 datapath_FIR_mult_205_U40 ( .A(datapath_FIR_mult_205_n105), .B(
        datapath_FIR_mult_205_n117), .CI(datapath_FIR_mult_205_n111), .CO(
        datapath_FIR_mult_205_n63), .S(datapath_FIR_mult_205_n64) );
  FA_X1 datapath_FIR_mult_205_U39 ( .A(datapath_FIR_mult_205_n66), .B(
        datapath_FIR_mult_205_n69), .CI(datapath_FIR_mult_205_n67), .CO(
        datapath_FIR_mult_205_n61), .S(datapath_FIR_mult_205_n62) );
  HA_X1 datapath_FIR_mult_205_U38 ( .A(datapath_FIR_mult_205_n86), .B(
        datapath_FIR_mult_205_n92), .CO(datapath_FIR_mult_205_n59), .S(
        datapath_FIR_mult_205_n60) );
  FA_X1 datapath_FIR_mult_205_U37 ( .A(datapath_FIR_mult_205_n98), .B(
        datapath_FIR_mult_205_n116), .CI(datapath_FIR_mult_205_n104), .CO(
        datapath_FIR_mult_205_n57), .S(datapath_FIR_mult_205_n58) );
  FA_X1 datapath_FIR_mult_205_U36 ( .A(datapath_FIR_mult_205_n65), .B(
        datapath_FIR_mult_205_n110), .CI(datapath_FIR_mult_205_n60), .CO(
        datapath_FIR_mult_205_n55), .S(datapath_FIR_mult_205_n56) );
  FA_X1 datapath_FIR_mult_205_U35 ( .A(datapath_FIR_mult_205_n58), .B(
        datapath_FIR_mult_205_n63), .CI(datapath_FIR_mult_205_n56), .CO(
        datapath_FIR_mult_205_n53), .S(datapath_FIR_mult_205_n54) );
  HA_X1 datapath_FIR_mult_205_U34 ( .A(datapath_FIR_mult_205_n97), .B(
        datapath_FIR_mult_205_n91), .CO(datapath_FIR_mult_205_n51), .S(
        datapath_FIR_mult_205_n52) );
  FA_X1 datapath_FIR_mult_205_U33 ( .A(datapath_FIR_mult_205_n85), .B(
        datapath_FIR_mult_205_n103), .CI(datapath_FIR_mult_205_n109), .CO(
        datapath_FIR_mult_205_n49), .S(datapath_FIR_mult_205_n50) );
  FA_X1 datapath_FIR_mult_205_U32 ( .A(datapath_FIR_mult_205_n79), .B(
        datapath_FIR_mult_205_n115), .CI(datapath_FIR_mult_205_n59), .CO(
        datapath_FIR_mult_205_n47), .S(datapath_FIR_mult_205_n48) );
  FA_X1 datapath_FIR_mult_205_U31 ( .A(datapath_FIR_mult_205_n57), .B(
        datapath_FIR_mult_205_n52), .CI(datapath_FIR_mult_205_n50), .CO(
        datapath_FIR_mult_205_n45), .S(datapath_FIR_mult_205_n46) );
  FA_X1 datapath_FIR_mult_205_U30 ( .A(datapath_FIR_mult_205_n48), .B(
        datapath_FIR_mult_205_n55), .CI(datapath_FIR_mult_205_n46), .CO(
        datapath_FIR_mult_205_n43), .S(datapath_FIR_mult_205_n44) );
  FA_X1 datapath_FIR_mult_205_U27 ( .A(datapath_FIR_mult_205_n102), .B(
        datapath_FIR_mult_205_n90), .CI(datapath_FIR_mult_205_n108), .CO(
        datapath_FIR_mult_205_n39), .S(datapath_FIR_mult_205_n40) );
  FA_X1 datapath_FIR_mult_205_U26 ( .A(datapath_FIR_mult_205_n51), .B(
        datapath_FIR_mult_205_n78), .CI(datapath_FIR_mult_205_n42), .CO(
        datapath_FIR_mult_205_n37), .S(datapath_FIR_mult_205_n38) );
  FA_X1 datapath_FIR_mult_205_U25 ( .A(datapath_FIR_mult_205_n47), .B(
        datapath_FIR_mult_205_n49), .CI(datapath_FIR_mult_205_n40), .CO(
        datapath_FIR_mult_205_n35), .S(datapath_FIR_mult_205_n36) );
  FA_X1 datapath_FIR_mult_205_U24 ( .A(datapath_FIR_mult_205_n45), .B(
        datapath_FIR_mult_205_n38), .CI(datapath_FIR_mult_205_n36), .CO(
        datapath_FIR_mult_205_n33), .S(datapath_FIR_mult_205_n34) );
  FA_X1 datapath_FIR_mult_205_U23 ( .A(datapath_FIR_mult_205_n83), .B(
        datapath_FIR_mult_205_n89), .CI(datapath_FIR_mult_205_n95), .CO(
        datapath_FIR_mult_205_n31), .S(datapath_FIR_mult_205_n32) );
  FA_X1 datapath_FIR_mult_205_U22 ( .A(datapath_FIR_mult_205_n77), .B(
        datapath_FIR_mult_205_n101), .CI(datapath_FIR_mult_205_n41), .CO(
        datapath_FIR_mult_205_n29), .S(datapath_FIR_mult_205_n30) );
  FA_X1 datapath_FIR_mult_205_U21 ( .A(datapath_FIR_mult_205_n32), .B(
        datapath_FIR_mult_205_n39), .CI(datapath_FIR_mult_205_n37), .CO(
        datapath_FIR_mult_205_n27), .S(datapath_FIR_mult_205_n28) );
  FA_X1 datapath_FIR_mult_205_U20 ( .A(datapath_FIR_mult_205_n35), .B(
        datapath_FIR_mult_205_n30), .CI(datapath_FIR_mult_205_n28), .CO(
        datapath_FIR_mult_205_n25), .S(datapath_FIR_mult_205_n26) );
  FA_X1 datapath_FIR_mult_205_U19 ( .A(datapath_FIR_mult_205_n82), .B(
        datapath_FIR_mult_205_n88), .CI(datapath_FIR_mult_205_n94), .CO(
        datapath_FIR_mult_205_n23), .S(datapath_FIR_mult_205_n24) );
  FA_X1 datapath_FIR_mult_205_U18 ( .A(datapath_FIR_mult_205_n31), .B(
        datapath_FIR_mult_205_n76), .CI(datapath_FIR_mult_205_n29), .CO(
        datapath_FIR_mult_205_n21), .S(datapath_FIR_mult_205_n22) );
  FA_X1 datapath_FIR_mult_205_U17 ( .A(datapath_FIR_mult_205_n27), .B(
        datapath_FIR_mult_205_n24), .CI(datapath_FIR_mult_205_n22), .CO(
        datapath_FIR_mult_205_n19), .S(datapath_FIR_mult_205_n20) );
  FA_X1 datapath_FIR_mult_205_U16 ( .A(datapath_FIR_mult_205_n87), .B(
        datapath_FIR_mult_205_n81), .CI(datapath_FIR_mult_205_n75), .CO(
        datapath_FIR_mult_205_n17), .S(datapath_FIR_mult_205_n18) );
  FA_X1 datapath_FIR_mult_205_U15 ( .A(datapath_FIR_mult_205_n18), .B(
        datapath_FIR_mult_205_n23), .CI(datapath_FIR_mult_205_n21), .CO(
        datapath_FIR_mult_205_n15), .S(datapath_FIR_mult_205_n16) );
  FA_X1 datapath_FIR_mult_205_U14 ( .A(datapath_FIR_mult_205_n74), .B(
        datapath_FIR_mult_205_n80), .CI(datapath_FIR_mult_205_n17), .CO(
        datapath_FIR_mult_205_n13), .S(datapath_FIR_mult_205_n14) );
  FA_X1 datapath_FIR_mult_205_U8 ( .A(datapath_FIR_mult_205_n44), .B(
        datapath_FIR_mult_205_n53), .CI(datapath_FIR_mult_205_n8), .CO(
        datapath_FIR_mult_205_n7), .S(datapath_FIR_M0_6_) );
  FA_X1 datapath_FIR_mult_205_U7 ( .A(datapath_FIR_mult_205_n34), .B(
        datapath_FIR_mult_205_n43), .CI(datapath_FIR_mult_205_n7), .CO(
        datapath_FIR_mult_205_n6), .S(datapath_FIR_M0_7_) );
  FA_X1 datapath_FIR_mult_205_U6 ( .A(datapath_FIR_mult_205_n26), .B(
        datapath_FIR_mult_205_n33), .CI(datapath_FIR_mult_205_n6), .CO(
        datapath_FIR_mult_205_n5), .S(datapath_FIR_M0_8_) );
  FA_X1 datapath_FIR_mult_205_U5 ( .A(datapath_FIR_mult_205_n20), .B(
        datapath_FIR_mult_205_n25), .CI(datapath_FIR_mult_205_n5), .CO(
        datapath_FIR_mult_205_n4), .S(datapath_FIR_M0_9_) );
  FA_X1 datapath_FIR_mult_205_U4 ( .A(datapath_FIR_mult_205_n16), .B(
        datapath_FIR_mult_205_n19), .CI(datapath_FIR_mult_205_n4), .CO(
        datapath_FIR_mult_205_n3), .S(datapath_FIR_M0_10_) );
  FA_X1 datapath_FIR_mult_205_U3 ( .A(datapath_FIR_mult_205_n15), .B(
        datapath_FIR_mult_205_n14), .CI(datapath_FIR_mult_205_n3), .CO(
        datapath_FIR_mult_205_n2), .S(datapath_FIR_M0_11_) );
  NOR2_X1 datapath_FIR_mult_206_U183 ( .A1(datapath_FIR_mult_206_n177), .A2(
        datapath_FIR_mult_206_n174), .ZN(datapath_FIR_mult_206_n100) );
  NAND2_X1 datapath_FIR_mult_206_U182 ( .A1(datapath_FIR_x1[2]), .A2(
        datapath_FIR_bq1[6]), .ZN(datapath_FIR_mult_206_n101) );
  NOR2_X1 datapath_FIR_mult_206_U181 ( .A1(datapath_FIR_mult_206_n166), .A2(
        datapath_FIR_mult_206_n178), .ZN(datapath_FIR_mult_206_n102) );
  NOR2_X1 datapath_FIR_mult_206_U180 ( .A1(datapath_FIR_mult_206_n167), .A2(
        datapath_FIR_mult_206_n178), .ZN(datapath_FIR_mult_206_n103) );
  NOR2_X1 datapath_FIR_mult_206_U179 ( .A1(datapath_FIR_mult_206_n170), .A2(
        datapath_FIR_mult_206_n178), .ZN(datapath_FIR_mult_206_n104) );
  NOR2_X1 datapath_FIR_mult_206_U178 ( .A1(datapath_FIR_mult_206_n171), .A2(
        datapath_FIR_mult_206_n178), .ZN(datapath_FIR_mult_206_n105) );
  NOR2_X1 datapath_FIR_mult_206_U177 ( .A1(datapath_FIR_mult_206_n173), .A2(
        datapath_FIR_mult_206_n178), .ZN(datapath_FIR_mult_206_n106) );
  NAND2_X1 datapath_FIR_mult_206_U176 ( .A1(datapath_FIR_x1[1]), .A2(
        datapath_FIR_bq1[6]), .ZN(datapath_FIR_mult_206_n108) );
  NOR2_X1 datapath_FIR_mult_206_U175 ( .A1(datapath_FIR_mult_206_n166), .A2(
        datapath_FIR_mult_206_n179), .ZN(datapath_FIR_mult_206_n109) );
  NOR2_X1 datapath_FIR_mult_206_U174 ( .A1(datapath_FIR_mult_206_n167), .A2(
        datapath_FIR_mult_206_n179), .ZN(datapath_FIR_mult_206_n110) );
  NOR2_X1 datapath_FIR_mult_206_U173 ( .A1(datapath_FIR_mult_206_n170), .A2(
        datapath_FIR_mult_206_n179), .ZN(datapath_FIR_mult_206_n111) );
  NOR2_X1 datapath_FIR_mult_206_U172 ( .A1(datapath_FIR_mult_206_n171), .A2(
        datapath_FIR_mult_206_n179), .ZN(datapath_FIR_mult_206_n112) );
  NOR2_X1 datapath_FIR_mult_206_U171 ( .A1(datapath_FIR_mult_206_n173), .A2(
        datapath_FIR_mult_206_n179), .ZN(datapath_FIR_mult_206_n113) );
  NAND2_X1 datapath_FIR_mult_206_U170 ( .A1(datapath_FIR_x1[0]), .A2(
        datapath_FIR_bq1[6]), .ZN(datapath_FIR_mult_206_n115) );
  NOR2_X1 datapath_FIR_mult_206_U169 ( .A1(datapath_FIR_mult_206_n166), .A2(
        datapath_FIR_mult_206_n180), .ZN(datapath_FIR_mult_206_n116) );
  NOR2_X1 datapath_FIR_mult_206_U168 ( .A1(datapath_FIR_mult_206_n167), .A2(
        datapath_FIR_mult_206_n180), .ZN(datapath_FIR_mult_206_n117) );
  NOR2_X1 datapath_FIR_mult_206_U167 ( .A1(datapath_FIR_mult_206_n170), .A2(
        datapath_FIR_mult_206_n180), .ZN(datapath_FIR_mult_206_n118) );
  NOR2_X1 datapath_FIR_mult_206_U166 ( .A1(datapath_FIR_mult_206_n171), .A2(
        datapath_FIR_mult_206_n180), .ZN(datapath_FIR_mult_206_n119) );
  NAND2_X1 datapath_FIR_mult_206_U165 ( .A1(datapath_FIR_bq1[4]), .A2(
        datapath_FIR_x1[3]), .ZN(datapath_FIR_mult_206_n188) );
  NAND2_X1 datapath_FIR_mult_206_U164 ( .A1(datapath_FIR_x1[5]), .A2(
        datapath_FIR_bq1[2]), .ZN(datapath_FIR_mult_206_n187) );
  NAND2_X1 datapath_FIR_mult_206_U163 ( .A1(datapath_FIR_mult_206_n188), .A2(
        datapath_FIR_mult_206_n187), .ZN(datapath_FIR_mult_206_n41) );
  XNOR2_X1 datapath_FIR_mult_206_U162 ( .A(datapath_FIR_mult_206_n187), .B(
        datapath_FIR_mult_206_n188), .ZN(datapath_FIR_mult_206_n42) );
  NAND2_X1 datapath_FIR_mult_206_U161 ( .A1(datapath_FIR_bq1[5]), .A2(
        datapath_FIR_x1[6]), .ZN(datapath_FIR_mult_206_n74) );
  NAND2_X1 datapath_FIR_mult_206_U160 ( .A1(datapath_FIR_bq1[4]), .A2(
        datapath_FIR_x1[6]), .ZN(datapath_FIR_mult_206_n75) );
  NAND2_X1 datapath_FIR_mult_206_U159 ( .A1(datapath_FIR_bq1[3]), .A2(
        datapath_FIR_x1[6]), .ZN(datapath_FIR_mult_206_n76) );
  NAND2_X1 datapath_FIR_mult_206_U158 ( .A1(datapath_FIR_bq1[2]), .A2(
        datapath_FIR_x1[6]), .ZN(datapath_FIR_mult_206_n77) );
  NAND2_X1 datapath_FIR_mult_206_U157 ( .A1(datapath_FIR_bq1[1]), .A2(
        datapath_FIR_x1[6]), .ZN(datapath_FIR_mult_206_n78) );
  NAND2_X1 datapath_FIR_mult_206_U156 ( .A1(datapath_FIR_bq1[0]), .A2(
        datapath_FIR_x1[6]), .ZN(datapath_FIR_mult_206_n79) );
  NOR4_X1 datapath_FIR_mult_206_U155 ( .A1(datapath_FIR_mult_206_n179), .A2(
        datapath_FIR_mult_206_n180), .A3(datapath_FIR_mult_206_n174), .A4(
        datapath_FIR_mult_206_n173), .ZN(datapath_FIR_mult_206_n185) );
  NOR2_X1 datapath_FIR_mult_206_U154 ( .A1(datapath_FIR_mult_206_n178), .A2(
        datapath_FIR_mult_206_n174), .ZN(datapath_FIR_mult_206_n186) );
  AOI222_X1 datapath_FIR_mult_206_U153 ( .A1(datapath_FIR_mult_206_n72), .A2(
        datapath_FIR_mult_206_n185), .B1(datapath_FIR_mult_206_n186), .B2(
        datapath_FIR_mult_206_n72), .C1(datapath_FIR_mult_206_n186), .C2(
        datapath_FIR_mult_206_n185), .ZN(datapath_FIR_mult_206_n184) );
  OAI222_X1 datapath_FIR_mult_206_U152 ( .A1(datapath_FIR_mult_206_n184), .A2(
        datapath_FIR_mult_206_n169), .B1(datapath_FIR_mult_206_n169), .B2(
        datapath_FIR_mult_206_n172), .C1(datapath_FIR_mult_206_n184), .C2(
        datapath_FIR_mult_206_n172), .ZN(datapath_FIR_mult_206_n183) );
  OAI222_X1 datapath_FIR_mult_206_U151 ( .A1(datapath_FIR_mult_206_n182), .A2(
        datapath_FIR_mult_206_n165), .B1(datapath_FIR_mult_206_n182), .B2(
        datapath_FIR_mult_206_n168), .C1(datapath_FIR_mult_206_n168), .C2(
        datapath_FIR_mult_206_n165), .ZN(datapath_FIR_mult_206_n8) );
  NAND2_X1 datapath_FIR_mult_206_U150 ( .A1(datapath_FIR_x1[5]), .A2(
        datapath_FIR_bq1[6]), .ZN(datapath_FIR_mult_206_n80) );
  NOR2_X1 datapath_FIR_mult_206_U149 ( .A1(datapath_FIR_mult_206_n166), .A2(
        datapath_FIR_mult_206_n175), .ZN(datapath_FIR_mult_206_n81) );
  NOR2_X1 datapath_FIR_mult_206_U148 ( .A1(datapath_FIR_mult_206_n167), .A2(
        datapath_FIR_mult_206_n175), .ZN(datapath_FIR_mult_206_n82) );
  NOR2_X1 datapath_FIR_mult_206_U147 ( .A1(datapath_FIR_mult_206_n170), .A2(
        datapath_FIR_mult_206_n175), .ZN(datapath_FIR_mult_206_n83) );
  NOR2_X1 datapath_FIR_mult_206_U146 ( .A1(datapath_FIR_mult_206_n173), .A2(
        datapath_FIR_mult_206_n175), .ZN(datapath_FIR_mult_206_n85) );
  NOR2_X1 datapath_FIR_mult_206_U145 ( .A1(datapath_FIR_mult_206_n174), .A2(
        datapath_FIR_mult_206_n175), .ZN(datapath_FIR_mult_206_n86) );
  NAND2_X1 datapath_FIR_mult_206_U144 ( .A1(datapath_FIR_x1[4]), .A2(
        datapath_FIR_bq1[6]), .ZN(datapath_FIR_mult_206_n87) );
  NOR2_X1 datapath_FIR_mult_206_U143 ( .A1(datapath_FIR_mult_206_n166), .A2(
        datapath_FIR_mult_206_n176), .ZN(datapath_FIR_mult_206_n88) );
  NOR2_X1 datapath_FIR_mult_206_U142 ( .A1(datapath_FIR_mult_206_n176), .A2(
        datapath_FIR_mult_206_n167), .ZN(datapath_FIR_mult_206_n89) );
  NOR2_X1 datapath_FIR_mult_206_U141 ( .A1(datapath_FIR_mult_206_n170), .A2(
        datapath_FIR_mult_206_n176), .ZN(datapath_FIR_mult_206_n90) );
  NOR2_X1 datapath_FIR_mult_206_U140 ( .A1(datapath_FIR_mult_206_n171), .A2(
        datapath_FIR_mult_206_n176), .ZN(datapath_FIR_mult_206_n91) );
  NOR2_X1 datapath_FIR_mult_206_U139 ( .A1(datapath_FIR_mult_206_n173), .A2(
        datapath_FIR_mult_206_n176), .ZN(datapath_FIR_mult_206_n92) );
  NOR2_X1 datapath_FIR_mult_206_U138 ( .A1(datapath_FIR_mult_206_n176), .A2(
        datapath_FIR_mult_206_n174), .ZN(datapath_FIR_mult_206_n93) );
  NAND2_X1 datapath_FIR_mult_206_U137 ( .A1(datapath_FIR_x1[3]), .A2(
        datapath_FIR_bq1[6]), .ZN(datapath_FIR_mult_206_n94) );
  NOR2_X1 datapath_FIR_mult_206_U136 ( .A1(datapath_FIR_mult_206_n177), .A2(
        datapath_FIR_mult_206_n166), .ZN(datapath_FIR_mult_206_n95) );
  NOR2_X1 datapath_FIR_mult_206_U135 ( .A1(datapath_FIR_mult_206_n177), .A2(
        datapath_FIR_mult_206_n170), .ZN(datapath_FIR_mult_206_n97) );
  NOR2_X1 datapath_FIR_mult_206_U134 ( .A1(datapath_FIR_mult_206_n177), .A2(
        datapath_FIR_mult_206_n171), .ZN(datapath_FIR_mult_206_n98) );
  NOR2_X1 datapath_FIR_mult_206_U133 ( .A1(datapath_FIR_mult_206_n177), .A2(
        datapath_FIR_mult_206_n173), .ZN(datapath_FIR_mult_206_n99) );
  NAND2_X1 datapath_FIR_mult_206_U132 ( .A1(datapath_FIR_bq1[6]), .A2(
        datapath_FIR_x1[6]), .ZN(datapath_FIR_mult_206_n181) );
  INV_X1 datapath_FIR_mult_206_U131 ( .A(datapath_FIR_bq1[0]), .ZN(
        datapath_FIR_mult_206_n174) );
  INV_X1 datapath_FIR_mult_206_U130 ( .A(datapath_FIR_x1[0]), .ZN(
        datapath_FIR_mult_206_n180) );
  INV_X1 datapath_FIR_mult_206_U129 ( .A(datapath_FIR_x1[5]), .ZN(
        datapath_FIR_mult_206_n175) );
  INV_X1 datapath_FIR_mult_206_U128 ( .A(datapath_FIR_bq1[2]), .ZN(
        datapath_FIR_mult_206_n171) );
  INV_X1 datapath_FIR_mult_206_U127 ( .A(datapath_FIR_bq1[4]), .ZN(
        datapath_FIR_mult_206_n167) );
  INV_X1 datapath_FIR_mult_206_U126 ( .A(datapath_FIR_x1[3]), .ZN(
        datapath_FIR_mult_206_n177) );
  INV_X1 datapath_FIR_mult_206_U125 ( .A(datapath_FIR_x1[2]), .ZN(
        datapath_FIR_mult_206_n178) );
  INV_X1 datapath_FIR_mult_206_U124 ( .A(datapath_FIR_x1[1]), .ZN(
        datapath_FIR_mult_206_n179) );
  INV_X1 datapath_FIR_mult_206_U123 ( .A(datapath_FIR_x1[4]), .ZN(
        datapath_FIR_mult_206_n176) );
  INV_X1 datapath_FIR_mult_206_U122 ( .A(datapath_FIR_bq1[1]), .ZN(
        datapath_FIR_mult_206_n173) );
  INV_X1 datapath_FIR_mult_206_U121 ( .A(datapath_FIR_bq1[5]), .ZN(
        datapath_FIR_mult_206_n166) );
  INV_X1 datapath_FIR_mult_206_U120 ( .A(datapath_FIR_bq1[3]), .ZN(
        datapath_FIR_mult_206_n170) );
  XNOR2_X1 datapath_FIR_mult_206_U119 ( .A(datapath_FIR_mult_206_n181), .B(
        datapath_FIR_mult_206_n164), .ZN(datapath_FIR_M1_12_) );
  INV_X1 datapath_FIR_mult_206_U118 ( .A(datapath_FIR_mult_206_n68), .ZN(
        datapath_FIR_mult_206_n169) );
  INV_X1 datapath_FIR_mult_206_U117 ( .A(datapath_FIR_mult_206_n54), .ZN(
        datapath_FIR_mult_206_n165) );
  INV_X1 datapath_FIR_mult_206_U116 ( .A(datapath_FIR_mult_206_n61), .ZN(
        datapath_FIR_mult_206_n168) );
  INV_X1 datapath_FIR_mult_206_U115 ( .A(datapath_FIR_mult_206_n70), .ZN(
        datapath_FIR_mult_206_n172) );
  XNOR2_X1 datapath_FIR_mult_206_U114 ( .A(datapath_FIR_mult_206_n2), .B(
        datapath_FIR_mult_206_n163), .ZN(datapath_FIR_mult_206_n164) );
  AND3_X1 datapath_FIR_mult_206_U113 ( .A1(datapath_FIR_mult_206_n160), .A2(
        datapath_FIR_mult_206_n161), .A3(datapath_FIR_mult_206_n162), .ZN(
        datapath_FIR_mult_206_n182) );
  NAND2_X1 datapath_FIR_mult_206_U112 ( .A1(datapath_FIR_mult_206_n64), .A2(
        datapath_FIR_mult_206_n62), .ZN(datapath_FIR_mult_206_n162) );
  NAND2_X1 datapath_FIR_mult_206_U111 ( .A1(datapath_FIR_mult_206_n183), .A2(
        datapath_FIR_mult_206_n64), .ZN(datapath_FIR_mult_206_n161) );
  NAND2_X1 datapath_FIR_mult_206_U110 ( .A1(datapath_FIR_mult_206_n183), .A2(
        datapath_FIR_mult_206_n62), .ZN(datapath_FIR_mult_206_n160) );
  INV_X1 datapath_FIR_mult_206_U109 ( .A(datapath_FIR_mult_206_n13), .ZN(
        datapath_FIR_mult_206_n163) );
  HA_X1 datapath_FIR_mult_206_U44 ( .A(datapath_FIR_mult_206_n113), .B(
        datapath_FIR_mult_206_n119), .CO(datapath_FIR_mult_206_n71), .S(
        datapath_FIR_mult_206_n72) );
  HA_X1 datapath_FIR_mult_206_U43 ( .A(datapath_FIR_mult_206_n100), .B(
        datapath_FIR_mult_206_n106), .CO(datapath_FIR_mult_206_n69), .S(
        datapath_FIR_mult_206_n70) );
  FA_X1 datapath_FIR_mult_206_U42 ( .A(datapath_FIR_mult_206_n112), .B(
        datapath_FIR_mult_206_n118), .CI(datapath_FIR_mult_206_n71), .CO(
        datapath_FIR_mult_206_n67), .S(datapath_FIR_mult_206_n68) );
  HA_X1 datapath_FIR_mult_206_U41 ( .A(datapath_FIR_mult_206_n93), .B(
        datapath_FIR_mult_206_n99), .CO(datapath_FIR_mult_206_n65), .S(
        datapath_FIR_mult_206_n66) );
  FA_X1 datapath_FIR_mult_206_U40 ( .A(datapath_FIR_mult_206_n105), .B(
        datapath_FIR_mult_206_n117), .CI(datapath_FIR_mult_206_n111), .CO(
        datapath_FIR_mult_206_n63), .S(datapath_FIR_mult_206_n64) );
  FA_X1 datapath_FIR_mult_206_U39 ( .A(datapath_FIR_mult_206_n66), .B(
        datapath_FIR_mult_206_n69), .CI(datapath_FIR_mult_206_n67), .CO(
        datapath_FIR_mult_206_n61), .S(datapath_FIR_mult_206_n62) );
  HA_X1 datapath_FIR_mult_206_U38 ( .A(datapath_FIR_mult_206_n86), .B(
        datapath_FIR_mult_206_n92), .CO(datapath_FIR_mult_206_n59), .S(
        datapath_FIR_mult_206_n60) );
  FA_X1 datapath_FIR_mult_206_U37 ( .A(datapath_FIR_mult_206_n98), .B(
        datapath_FIR_mult_206_n116), .CI(datapath_FIR_mult_206_n104), .CO(
        datapath_FIR_mult_206_n57), .S(datapath_FIR_mult_206_n58) );
  FA_X1 datapath_FIR_mult_206_U36 ( .A(datapath_FIR_mult_206_n65), .B(
        datapath_FIR_mult_206_n110), .CI(datapath_FIR_mult_206_n60), .CO(
        datapath_FIR_mult_206_n55), .S(datapath_FIR_mult_206_n56) );
  FA_X1 datapath_FIR_mult_206_U35 ( .A(datapath_FIR_mult_206_n58), .B(
        datapath_FIR_mult_206_n63), .CI(datapath_FIR_mult_206_n56), .CO(
        datapath_FIR_mult_206_n53), .S(datapath_FIR_mult_206_n54) );
  HA_X1 datapath_FIR_mult_206_U34 ( .A(datapath_FIR_mult_206_n97), .B(
        datapath_FIR_mult_206_n91), .CO(datapath_FIR_mult_206_n51), .S(
        datapath_FIR_mult_206_n52) );
  FA_X1 datapath_FIR_mult_206_U33 ( .A(datapath_FIR_mult_206_n85), .B(
        datapath_FIR_mult_206_n103), .CI(datapath_FIR_mult_206_n109), .CO(
        datapath_FIR_mult_206_n49), .S(datapath_FIR_mult_206_n50) );
  FA_X1 datapath_FIR_mult_206_U32 ( .A(datapath_FIR_mult_206_n79), .B(
        datapath_FIR_mult_206_n115), .CI(datapath_FIR_mult_206_n59), .CO(
        datapath_FIR_mult_206_n47), .S(datapath_FIR_mult_206_n48) );
  FA_X1 datapath_FIR_mult_206_U31 ( .A(datapath_FIR_mult_206_n57), .B(
        datapath_FIR_mult_206_n52), .CI(datapath_FIR_mult_206_n50), .CO(
        datapath_FIR_mult_206_n45), .S(datapath_FIR_mult_206_n46) );
  FA_X1 datapath_FIR_mult_206_U30 ( .A(datapath_FIR_mult_206_n48), .B(
        datapath_FIR_mult_206_n55), .CI(datapath_FIR_mult_206_n46), .CO(
        datapath_FIR_mult_206_n43), .S(datapath_FIR_mult_206_n44) );
  FA_X1 datapath_FIR_mult_206_U27 ( .A(datapath_FIR_mult_206_n102), .B(
        datapath_FIR_mult_206_n90), .CI(datapath_FIR_mult_206_n108), .CO(
        datapath_FIR_mult_206_n39), .S(datapath_FIR_mult_206_n40) );
  FA_X1 datapath_FIR_mult_206_U26 ( .A(datapath_FIR_mult_206_n51), .B(
        datapath_FIR_mult_206_n78), .CI(datapath_FIR_mult_206_n42), .CO(
        datapath_FIR_mult_206_n37), .S(datapath_FIR_mult_206_n38) );
  FA_X1 datapath_FIR_mult_206_U25 ( .A(datapath_FIR_mult_206_n47), .B(
        datapath_FIR_mult_206_n49), .CI(datapath_FIR_mult_206_n40), .CO(
        datapath_FIR_mult_206_n35), .S(datapath_FIR_mult_206_n36) );
  FA_X1 datapath_FIR_mult_206_U24 ( .A(datapath_FIR_mult_206_n45), .B(
        datapath_FIR_mult_206_n38), .CI(datapath_FIR_mult_206_n36), .CO(
        datapath_FIR_mult_206_n33), .S(datapath_FIR_mult_206_n34) );
  FA_X1 datapath_FIR_mult_206_U23 ( .A(datapath_FIR_mult_206_n83), .B(
        datapath_FIR_mult_206_n89), .CI(datapath_FIR_mult_206_n95), .CO(
        datapath_FIR_mult_206_n31), .S(datapath_FIR_mult_206_n32) );
  FA_X1 datapath_FIR_mult_206_U22 ( .A(datapath_FIR_mult_206_n77), .B(
        datapath_FIR_mult_206_n101), .CI(datapath_FIR_mult_206_n41), .CO(
        datapath_FIR_mult_206_n29), .S(datapath_FIR_mult_206_n30) );
  FA_X1 datapath_FIR_mult_206_U21 ( .A(datapath_FIR_mult_206_n32), .B(
        datapath_FIR_mult_206_n39), .CI(datapath_FIR_mult_206_n37), .CO(
        datapath_FIR_mult_206_n27), .S(datapath_FIR_mult_206_n28) );
  FA_X1 datapath_FIR_mult_206_U20 ( .A(datapath_FIR_mult_206_n35), .B(
        datapath_FIR_mult_206_n30), .CI(datapath_FIR_mult_206_n28), .CO(
        datapath_FIR_mult_206_n25), .S(datapath_FIR_mult_206_n26) );
  FA_X1 datapath_FIR_mult_206_U19 ( .A(datapath_FIR_mult_206_n82), .B(
        datapath_FIR_mult_206_n88), .CI(datapath_FIR_mult_206_n94), .CO(
        datapath_FIR_mult_206_n23), .S(datapath_FIR_mult_206_n24) );
  FA_X1 datapath_FIR_mult_206_U18 ( .A(datapath_FIR_mult_206_n31), .B(
        datapath_FIR_mult_206_n76), .CI(datapath_FIR_mult_206_n29), .CO(
        datapath_FIR_mult_206_n21), .S(datapath_FIR_mult_206_n22) );
  FA_X1 datapath_FIR_mult_206_U17 ( .A(datapath_FIR_mult_206_n27), .B(
        datapath_FIR_mult_206_n24), .CI(datapath_FIR_mult_206_n22), .CO(
        datapath_FIR_mult_206_n19), .S(datapath_FIR_mult_206_n20) );
  FA_X1 datapath_FIR_mult_206_U16 ( .A(datapath_FIR_mult_206_n87), .B(
        datapath_FIR_mult_206_n81), .CI(datapath_FIR_mult_206_n75), .CO(
        datapath_FIR_mult_206_n17), .S(datapath_FIR_mult_206_n18) );
  FA_X1 datapath_FIR_mult_206_U15 ( .A(datapath_FIR_mult_206_n18), .B(
        datapath_FIR_mult_206_n23), .CI(datapath_FIR_mult_206_n21), .CO(
        datapath_FIR_mult_206_n15), .S(datapath_FIR_mult_206_n16) );
  FA_X1 datapath_FIR_mult_206_U14 ( .A(datapath_FIR_mult_206_n74), .B(
        datapath_FIR_mult_206_n80), .CI(datapath_FIR_mult_206_n17), .CO(
        datapath_FIR_mult_206_n13), .S(datapath_FIR_mult_206_n14) );
  FA_X1 datapath_FIR_mult_206_U8 ( .A(datapath_FIR_mult_206_n44), .B(
        datapath_FIR_mult_206_n53), .CI(datapath_FIR_mult_206_n8), .CO(
        datapath_FIR_mult_206_n7), .S(datapath_FIR_M1_6_) );
  FA_X1 datapath_FIR_mult_206_U7 ( .A(datapath_FIR_mult_206_n34), .B(
        datapath_FIR_mult_206_n43), .CI(datapath_FIR_mult_206_n7), .CO(
        datapath_FIR_mult_206_n6), .S(datapath_FIR_M1_7_) );
  FA_X1 datapath_FIR_mult_206_U6 ( .A(datapath_FIR_mult_206_n26), .B(
        datapath_FIR_mult_206_n33), .CI(datapath_FIR_mult_206_n6), .CO(
        datapath_FIR_mult_206_n5), .S(datapath_FIR_M1_8_) );
  FA_X1 datapath_FIR_mult_206_U5 ( .A(datapath_FIR_mult_206_n20), .B(
        datapath_FIR_mult_206_n25), .CI(datapath_FIR_mult_206_n5), .CO(
        datapath_FIR_mult_206_n4), .S(datapath_FIR_M1_9_) );
  FA_X1 datapath_FIR_mult_206_U4 ( .A(datapath_FIR_mult_206_n16), .B(
        datapath_FIR_mult_206_n19), .CI(datapath_FIR_mult_206_n4), .CO(
        datapath_FIR_mult_206_n3), .S(datapath_FIR_M1_10_) );
  FA_X1 datapath_FIR_mult_206_U3 ( .A(datapath_FIR_mult_206_n15), .B(
        datapath_FIR_mult_206_n14), .CI(datapath_FIR_mult_206_n3), .CO(
        datapath_FIR_mult_206_n2), .S(datapath_FIR_M1_11_) );
  NOR2_X1 datapath_FIR_mult_213_U229 ( .A1(datapath_FIR_mult_213_n213), .A2(
        datapath_FIR_mult_213_n210), .ZN(datapath_FIR_mult_213_n100) );
  NAND2_X1 datapath_FIR_mult_213_U228 ( .A1(datapath_FIR_x8[2]), .A2(
        datapath_FIR_bq8[6]), .ZN(datapath_FIR_mult_213_n101) );
  NOR2_X1 datapath_FIR_mult_213_U227 ( .A1(datapath_FIR_mult_213_n161), .A2(
        datapath_FIR_mult_213_n214), .ZN(datapath_FIR_mult_213_n102) );
  NOR2_X1 datapath_FIR_mult_213_U226 ( .A1(datapath_FIR_mult_213_n207), .A2(
        datapath_FIR_mult_213_n214), .ZN(datapath_FIR_mult_213_n104) );
  NOR2_X1 datapath_FIR_mult_213_U225 ( .A1(datapath_FIR_mult_213_n208), .A2(
        datapath_FIR_mult_213_n214), .ZN(datapath_FIR_mult_213_n105) );
  NAND2_X1 datapath_FIR_mult_213_U224 ( .A1(datapath_FIR_mult_213_n170), .A2(
        datapath_FIR_bq8[6]), .ZN(datapath_FIR_mult_213_n108) );
  NOR2_X1 datapath_FIR_mult_213_U223 ( .A1(datapath_FIR_mult_213_n204), .A2(
        datapath_FIR_mult_213_n215), .ZN(datapath_FIR_mult_213_n110) );
  NOR2_X1 datapath_FIR_mult_213_U222 ( .A1(datapath_FIR_mult_213_n207), .A2(
        datapath_FIR_mult_213_n215), .ZN(datapath_FIR_mult_213_n111) );
  NOR2_X1 datapath_FIR_mult_213_U221 ( .A1(datapath_FIR_mult_213_n208), .A2(
        datapath_FIR_mult_213_n215), .ZN(datapath_FIR_mult_213_n112) );
  NAND2_X1 datapath_FIR_mult_213_U220 ( .A1(datapath_FIR_mult_213_n172), .A2(
        datapath_FIR_bq8[6]), .ZN(datapath_FIR_mult_213_n115) );
  NOR2_X1 datapath_FIR_mult_213_U219 ( .A1(datapath_FIR_mult_213_n161), .A2(
        datapath_FIR_mult_213_n216), .ZN(datapath_FIR_mult_213_n116) );
  NOR2_X1 datapath_FIR_mult_213_U218 ( .A1(datapath_FIR_mult_213_n204), .A2(
        datapath_FIR_mult_213_n216), .ZN(datapath_FIR_mult_213_n117) );
  NAND2_X1 datapath_FIR_mult_213_U217 ( .A1(datapath_FIR_bq8[4]), .A2(
        datapath_FIR_x8[3]), .ZN(datapath_FIR_mult_213_n224) );
  NAND2_X1 datapath_FIR_mult_213_U216 ( .A1(datapath_FIR_x8[5]), .A2(
        datapath_FIR_mult_213_n171), .ZN(datapath_FIR_mult_213_n223) );
  NAND2_X1 datapath_FIR_mult_213_U215 ( .A1(datapath_FIR_mult_213_n224), .A2(
        datapath_FIR_mult_213_n223), .ZN(datapath_FIR_mult_213_n41) );
  XNOR2_X1 datapath_FIR_mult_213_U214 ( .A(datapath_FIR_mult_213_n223), .B(
        datapath_FIR_mult_213_n224), .ZN(datapath_FIR_mult_213_n42) );
  NAND2_X1 datapath_FIR_mult_213_U213 ( .A1(datapath_FIR_bq8[5]), .A2(
        datapath_FIR_x8[6]), .ZN(datapath_FIR_mult_213_n74) );
  NAND2_X1 datapath_FIR_mult_213_U212 ( .A1(datapath_FIR_bq8[4]), .A2(
        datapath_FIR_x8[6]), .ZN(datapath_FIR_mult_213_n75) );
  NAND2_X1 datapath_FIR_mult_213_U211 ( .A1(datapath_FIR_bq8[3]), .A2(
        datapath_FIR_x8[6]), .ZN(datapath_FIR_mult_213_n76) );
  NAND2_X1 datapath_FIR_mult_213_U210 ( .A1(datapath_FIR_mult_213_n171), .A2(
        datapath_FIR_x8[6]), .ZN(datapath_FIR_mult_213_n77) );
  NAND2_X1 datapath_FIR_mult_213_U209 ( .A1(datapath_FIR_mult_213_n197), .A2(
        datapath_FIR_x8[6]), .ZN(datapath_FIR_mult_213_n78) );
  NAND2_X1 datapath_FIR_mult_213_U208 ( .A1(datapath_FIR_bq8[0]), .A2(
        datapath_FIR_x8[6]), .ZN(datapath_FIR_mult_213_n79) );
  NOR2_X1 datapath_FIR_mult_213_U207 ( .A1(datapath_FIR_mult_213_n214), .A2(
        datapath_FIR_mult_213_n210), .ZN(datapath_FIR_mult_213_n222) );
  AOI222_X1 datapath_FIR_mult_213_U206 ( .A1(datapath_FIR_mult_213_n72), .A2(
        datapath_FIR_mult_213_n221), .B1(datapath_FIR_mult_213_n222), .B2(
        datapath_FIR_mult_213_n72), .C1(datapath_FIR_mult_213_n222), .C2(
        datapath_FIR_mult_213_n221), .ZN(datapath_FIR_mult_213_n220) );
  OAI222_X1 datapath_FIR_mult_213_U205 ( .A1(datapath_FIR_mult_213_n220), .A2(
        datapath_FIR_mult_213_n206), .B1(datapath_FIR_mult_213_n206), .B2(
        datapath_FIR_mult_213_n209), .C1(datapath_FIR_mult_213_n220), .C2(
        datapath_FIR_mult_213_n209), .ZN(datapath_FIR_mult_213_n219) );
  OAI222_X1 datapath_FIR_mult_213_U204 ( .A1(datapath_FIR_mult_213_n173), .A2(
        datapath_FIR_mult_213_n174), .B1(datapath_FIR_mult_213_n218), .B2(
        datapath_FIR_mult_213_n205), .C1(datapath_FIR_mult_213_n205), .C2(
        datapath_FIR_mult_213_n174), .ZN(datapath_FIR_mult_213_n8) );
  NAND2_X1 datapath_FIR_mult_213_U203 ( .A1(datapath_FIR_x8[5]), .A2(
        datapath_FIR_bq8[6]), .ZN(datapath_FIR_mult_213_n80) );
  NOR2_X1 datapath_FIR_mult_213_U202 ( .A1(datapath_FIR_mult_213_n161), .A2(
        datapath_FIR_mult_213_n211), .ZN(datapath_FIR_mult_213_n81) );
  NOR2_X1 datapath_FIR_mult_213_U201 ( .A1(datapath_FIR_mult_213_n204), .A2(
        datapath_FIR_mult_213_n211), .ZN(datapath_FIR_mult_213_n82) );
  NOR2_X1 datapath_FIR_mult_213_U200 ( .A1(datapath_FIR_mult_213_n207), .A2(
        datapath_FIR_mult_213_n211), .ZN(datapath_FIR_mult_213_n83) );
  NAND2_X1 datapath_FIR_mult_213_U199 ( .A1(datapath_FIR_mult_213_n183), .A2(
        datapath_FIR_bq8[6]), .ZN(datapath_FIR_mult_213_n87) );
  NOR2_X1 datapath_FIR_mult_213_U198 ( .A1(datapath_FIR_mult_213_n161), .A2(
        datapath_FIR_mult_213_n212), .ZN(datapath_FIR_mult_213_n88) );
  NOR2_X1 datapath_FIR_mult_213_U197 ( .A1(datapath_FIR_mult_213_n212), .A2(
        datapath_FIR_mult_213_n204), .ZN(datapath_FIR_mult_213_n89) );
  NOR2_X1 datapath_FIR_mult_213_U196 ( .A1(datapath_FIR_mult_213_n207), .A2(
        datapath_FIR_mult_213_n212), .ZN(datapath_FIR_mult_213_n90) );
  NOR2_X1 datapath_FIR_mult_213_U195 ( .A1(datapath_FIR_mult_213_n208), .A2(
        datapath_FIR_mult_213_n212), .ZN(datapath_FIR_mult_213_n91) );
  NAND2_X1 datapath_FIR_mult_213_U194 ( .A1(datapath_FIR_x8[3]), .A2(
        datapath_FIR_bq8[6]), .ZN(datapath_FIR_mult_213_n94) );
  NOR2_X1 datapath_FIR_mult_213_U193 ( .A1(datapath_FIR_mult_213_n198), .A2(
        datapath_FIR_mult_213_n161), .ZN(datapath_FIR_mult_213_n95) );
  NOR2_X1 datapath_FIR_mult_213_U192 ( .A1(datapath_FIR_mult_213_n198), .A2(
        datapath_FIR_mult_213_n207), .ZN(datapath_FIR_mult_213_n97) );
  NOR2_X1 datapath_FIR_mult_213_U191 ( .A1(datapath_FIR_mult_213_n198), .A2(
        datapath_FIR_mult_213_n208), .ZN(datapath_FIR_mult_213_n98) );
  XNOR2_X1 datapath_FIR_mult_213_U190 ( .A(datapath_FIR_mult_213_n2), .B(
        datapath_FIR_mult_213_n13), .ZN(datapath_FIR_mult_213_n217) );
  INV_X1 datapath_FIR_mult_213_U189 ( .A(datapath_FIR_mult_213_n68), .ZN(
        datapath_FIR_mult_213_n206) );
  INV_X1 datapath_FIR_mult_213_U188 ( .A(datapath_FIR_bq8[2]), .ZN(
        datapath_FIR_mult_213_n208) );
  INV_X1 datapath_FIR_mult_213_U187 ( .A(datapath_FIR_x8[1]), .ZN(
        datapath_FIR_mult_213_n215) );
  AND2_X1 datapath_FIR_mult_213_U186 ( .A1(datapath_FIR_bq8[6]), .A2(
        datapath_FIR_x8[6]), .ZN(datapath_FIR_mult_213_n203) );
  XNOR2_X1 datapath_FIR_mult_213_U185 ( .A(datapath_FIR_mult_213_n203), .B(
        datapath_FIR_mult_213_n217), .ZN(datapath_FIR_M8_12_) );
  INV_X1 datapath_FIR_mult_213_U184 ( .A(datapath_FIR_x8[5]), .ZN(
        datapath_FIR_mult_213_n211) );
  NAND3_X1 datapath_FIR_mult_213_U183 ( .A1(datapath_FIR_mult_213_n200), .A2(
        datapath_FIR_mult_213_n201), .A3(datapath_FIR_mult_213_n202), .ZN(
        datapath_FIR_mult_213_n7) );
  NAND2_X1 datapath_FIR_mult_213_U182 ( .A1(datapath_FIR_mult_213_n44), .A2(
        datapath_FIR_mult_213_n53), .ZN(datapath_FIR_mult_213_n202) );
  NAND2_X1 datapath_FIR_mult_213_U181 ( .A1(datapath_FIR_mult_213_n8), .A2(
        datapath_FIR_mult_213_n53), .ZN(datapath_FIR_mult_213_n201) );
  NAND2_X1 datapath_FIR_mult_213_U180 ( .A1(datapath_FIR_mult_213_n192), .A2(
        datapath_FIR_mult_213_n44), .ZN(datapath_FIR_mult_213_n200) );
  INV_X1 datapath_FIR_mult_213_U179 ( .A(datapath_FIR_x8[4]), .ZN(
        datapath_FIR_mult_213_n212) );
  INV_X1 datapath_FIR_mult_213_U178 ( .A(datapath_FIR_x8[0]), .ZN(
        datapath_FIR_mult_213_n216) );
  INV_X1 datapath_FIR_mult_213_U177 ( .A(datapath_FIR_bq8[0]), .ZN(
        datapath_FIR_mult_213_n210) );
  AND2_X1 datapath_FIR_mult_213_U176 ( .A1(datapath_FIR_x8[0]), .A2(
        datapath_FIR_bq8[2]), .ZN(datapath_FIR_mult_213_n119) );
  AND2_X1 datapath_FIR_mult_213_U175 ( .A1(datapath_FIR_bq8[1]), .A2(
        datapath_FIR_x8[1]), .ZN(datapath_FIR_mult_213_n113) );
  XNOR2_X1 datapath_FIR_mult_213_U174 ( .A(datapath_FIR_mult_213_n44), .B(
        datapath_FIR_mult_213_n53), .ZN(datapath_FIR_mult_213_n199) );
  XNOR2_X1 datapath_FIR_mult_213_U173 ( .A(datapath_FIR_mult_213_n196), .B(
        datapath_FIR_mult_213_n199), .ZN(datapath_FIR_M8_6_) );
  INV_X1 datapath_FIR_mult_213_U172 ( .A(datapath_FIR_x8[3]), .ZN(
        datapath_FIR_mult_213_n213) );
  INV_X1 datapath_FIR_mult_213_U171 ( .A(datapath_FIR_x8[3]), .ZN(
        datapath_FIR_mult_213_n198) );
  AND2_X1 datapath_FIR_mult_213_U170 ( .A1(datapath_FIR_x8[4]), .A2(
        datapath_FIR_bq8[0]), .ZN(datapath_FIR_mult_213_n93) );
  CLKBUF_X1 datapath_FIR_mult_213_U169 ( .A(datapath_FIR_bq8[1]), .Z(
        datapath_FIR_mult_213_n197) );
  INV_X1 datapath_FIR_mult_213_U168 ( .A(datapath_FIR_bq8[4]), .ZN(
        datapath_FIR_mult_213_n204) );
  INV_X1 datapath_FIR_mult_213_U167 ( .A(datapath_FIR_x8[2]), .ZN(
        datapath_FIR_mult_213_n214) );
  INV_X1 datapath_FIR_mult_213_U166 ( .A(datapath_FIR_bq8[3]), .ZN(
        datapath_FIR_mult_213_n207) );
  INV_X1 datapath_FIR_mult_213_U165 ( .A(datapath_FIR_mult_213_n70), .ZN(
        datapath_FIR_mult_213_n209) );
  INV_X1 datapath_FIR_mult_213_U164 ( .A(datapath_FIR_mult_213_n61), .ZN(
        datapath_FIR_mult_213_n205) );
  CLKBUF_X1 datapath_FIR_mult_213_U163 ( .A(datapath_FIR_mult_213_n192), .Z(
        datapath_FIR_mult_213_n196) );
  AND2_X1 datapath_FIR_mult_213_U162 ( .A1(datapath_FIR_mult_213_n197), .A2(
        datapath_FIR_x8[2]), .ZN(datapath_FIR_mult_213_n106) );
  NAND2_X1 datapath_FIR_mult_213_U161 ( .A1(datapath_FIR_mult_213_n64), .A2(
        datapath_FIR_mult_213_n62), .ZN(datapath_FIR_mult_213_n195) );
  NAND2_X1 datapath_FIR_mult_213_U160 ( .A1(datapath_FIR_mult_213_n219), .A2(
        datapath_FIR_mult_213_n64), .ZN(datapath_FIR_mult_213_n194) );
  NAND2_X1 datapath_FIR_mult_213_U159 ( .A1(datapath_FIR_mult_213_n219), .A2(
        datapath_FIR_mult_213_n62), .ZN(datapath_FIR_mult_213_n193) );
  OAI222_X1 datapath_FIR_mult_213_U158 ( .A1(datapath_FIR_mult_213_n173), .A2(
        datapath_FIR_mult_213_n174), .B1(datapath_FIR_mult_213_n218), .B2(
        datapath_FIR_mult_213_n205), .C1(datapath_FIR_mult_213_n174), .C2(
        datapath_FIR_mult_213_n205), .ZN(datapath_FIR_mult_213_n192) );
  AND2_X1 datapath_FIR_mult_213_U157 ( .A1(datapath_FIR_x8[3]), .A2(
        datapath_FIR_bq8[1]), .ZN(datapath_FIR_mult_213_n99) );
  INV_X1 datapath_FIR_mult_213_U156 ( .A(datapath_FIR_mult_213_n92), .ZN(
        datapath_FIR_mult_213_n189) );
  INV_X1 datapath_FIR_mult_213_U155 ( .A(datapath_FIR_mult_213_n86), .ZN(
        datapath_FIR_mult_213_n188) );
  NAND2_X1 datapath_FIR_mult_213_U154 ( .A1(datapath_FIR_mult_213_n190), .A2(
        datapath_FIR_mult_213_n191), .ZN(datapath_FIR_mult_213_n60) );
  NAND2_X1 datapath_FIR_mult_213_U153 ( .A1(datapath_FIR_mult_213_n188), .A2(
        datapath_FIR_mult_213_n92), .ZN(datapath_FIR_mult_213_n191) );
  NAND2_X1 datapath_FIR_mult_213_U152 ( .A1(datapath_FIR_mult_213_n86), .A2(
        datapath_FIR_mult_213_n189), .ZN(datapath_FIR_mult_213_n190) );
  NAND3_X1 datapath_FIR_mult_213_U151 ( .A1(datapath_FIR_mult_213_n185), .A2(
        datapath_FIR_mult_213_n186), .A3(datapath_FIR_mult_213_n187), .ZN(
        datapath_FIR_mult_213_n5) );
  NAND2_X1 datapath_FIR_mult_213_U150 ( .A1(datapath_FIR_mult_213_n26), .A2(
        datapath_FIR_mult_213_n33), .ZN(datapath_FIR_mult_213_n187) );
  NAND2_X1 datapath_FIR_mult_213_U149 ( .A1(datapath_FIR_mult_213_n6), .A2(
        datapath_FIR_mult_213_n33), .ZN(datapath_FIR_mult_213_n186) );
  NAND2_X1 datapath_FIR_mult_213_U148 ( .A1(datapath_FIR_mult_213_n164), .A2(
        datapath_FIR_mult_213_n26), .ZN(datapath_FIR_mult_213_n185) );
  XOR2_X1 datapath_FIR_mult_213_U147 ( .A(datapath_FIR_mult_213_n165), .B(
        datapath_FIR_mult_213_n184), .Z(datapath_FIR_M8_8_) );
  XOR2_X1 datapath_FIR_mult_213_U146 ( .A(datapath_FIR_mult_213_n26), .B(
        datapath_FIR_mult_213_n33), .Z(datapath_FIR_mult_213_n184) );
  INV_X1 datapath_FIR_mult_213_U145 ( .A(datapath_FIR_mult_213_n212), .ZN(
        datapath_FIR_mult_213_n183) );
  NAND3_X1 datapath_FIR_mult_213_U144 ( .A1(datapath_FIR_mult_213_n180), .A2(
        datapath_FIR_mult_213_n181), .A3(datapath_FIR_mult_213_n182), .ZN(
        datapath_FIR_mult_213_n53) );
  NAND2_X1 datapath_FIR_mult_213_U143 ( .A1(datapath_FIR_mult_213_n63), .A2(
        datapath_FIR_mult_213_n56), .ZN(datapath_FIR_mult_213_n182) );
  NAND2_X1 datapath_FIR_mult_213_U142 ( .A1(datapath_FIR_mult_213_n58), .A2(
        datapath_FIR_mult_213_n56), .ZN(datapath_FIR_mult_213_n181) );
  NAND2_X1 datapath_FIR_mult_213_U141 ( .A1(datapath_FIR_mult_213_n58), .A2(
        datapath_FIR_mult_213_n63), .ZN(datapath_FIR_mult_213_n180) );
  NAND3_X1 datapath_FIR_mult_213_U140 ( .A1(datapath_FIR_mult_213_n177), .A2(
        datapath_FIR_mult_213_n178), .A3(datapath_FIR_mult_213_n179), .ZN(
        datapath_FIR_mult_213_n55) );
  NAND2_X1 datapath_FIR_mult_213_U139 ( .A1(datapath_FIR_mult_213_n110), .A2(
        datapath_FIR_mult_213_n60), .ZN(datapath_FIR_mult_213_n179) );
  NAND2_X1 datapath_FIR_mult_213_U138 ( .A1(datapath_FIR_mult_213_n65), .A2(
        datapath_FIR_mult_213_n60), .ZN(datapath_FIR_mult_213_n178) );
  NAND2_X1 datapath_FIR_mult_213_U137 ( .A1(datapath_FIR_mult_213_n65), .A2(
        datapath_FIR_mult_213_n110), .ZN(datapath_FIR_mult_213_n177) );
  XOR2_X1 datapath_FIR_mult_213_U136 ( .A(datapath_FIR_mult_213_n58), .B(
        datapath_FIR_mult_213_n63), .Z(datapath_FIR_mult_213_n176) );
  XOR2_X1 datapath_FIR_mult_213_U135 ( .A(datapath_FIR_mult_213_n175), .B(
        datapath_FIR_mult_213_n60), .Z(datapath_FIR_mult_213_n56) );
  XOR2_X1 datapath_FIR_mult_213_U134 ( .A(datapath_FIR_mult_213_n65), .B(
        datapath_FIR_mult_213_n110), .Z(datapath_FIR_mult_213_n175) );
  AND2_X1 datapath_FIR_mult_213_U133 ( .A1(datapath_FIR_bq8[4]), .A2(
        datapath_FIR_x8[2]), .ZN(datapath_FIR_mult_213_n103) );
  AND4_X1 datapath_FIR_mult_213_U132 ( .A1(datapath_FIR_mult_213_n170), .A2(
        datapath_FIR_mult_213_n172), .A3(datapath_FIR_bq8[0]), .A4(
        datapath_FIR_mult_213_n197), .ZN(datapath_FIR_mult_213_n221) );
  XNOR2_X1 datapath_FIR_mult_213_U131 ( .A(datapath_FIR_mult_213_n176), .B(
        datapath_FIR_mult_213_n56), .ZN(datapath_FIR_mult_213_n174) );
  AND2_X1 datapath_FIR_mult_213_U130 ( .A1(datapath_FIR_bq8[1]), .A2(
        datapath_FIR_x8[5]), .ZN(datapath_FIR_mult_213_n85) );
  AND2_X1 datapath_FIR_mult_213_U129 ( .A1(datapath_FIR_bq8[5]), .A2(
        datapath_FIR_x8[1]), .ZN(datapath_FIR_mult_213_n109) );
  AND3_X1 datapath_FIR_mult_213_U128 ( .A1(datapath_FIR_mult_213_n193), .A2(
        datapath_FIR_mult_213_n194), .A3(datapath_FIR_mult_213_n195), .ZN(
        datapath_FIR_mult_213_n173) );
  CLKBUF_X1 datapath_FIR_mult_213_U127 ( .A(datapath_FIR_x8[0]), .Z(
        datapath_FIR_mult_213_n172) );
  CLKBUF_X1 datapath_FIR_mult_213_U126 ( .A(datapath_FIR_bq8[2]), .Z(
        datapath_FIR_mult_213_n171) );
  CLKBUF_X1 datapath_FIR_mult_213_U125 ( .A(datapath_FIR_x8[1]), .Z(
        datapath_FIR_mult_213_n170) );
  AND2_X1 datapath_FIR_mult_213_U124 ( .A1(datapath_FIR_bq8[3]), .A2(
        datapath_FIR_x8[0]), .ZN(datapath_FIR_mult_213_n118) );
  AND2_X1 datapath_FIR_mult_213_U123 ( .A1(datapath_FIR_bq8[1]), .A2(
        datapath_FIR_x8[4]), .ZN(datapath_FIR_mult_213_n92) );
  NAND3_X1 datapath_FIR_mult_213_U122 ( .A1(datapath_FIR_mult_213_n167), .A2(
        datapath_FIR_mult_213_n168), .A3(datapath_FIR_mult_213_n169), .ZN(
        datapath_FIR_mult_213_n6) );
  NAND2_X1 datapath_FIR_mult_213_U121 ( .A1(datapath_FIR_mult_213_n34), .A2(
        datapath_FIR_mult_213_n43), .ZN(datapath_FIR_mult_213_n169) );
  NAND2_X1 datapath_FIR_mult_213_U120 ( .A1(datapath_FIR_mult_213_n7), .A2(
        datapath_FIR_mult_213_n43), .ZN(datapath_FIR_mult_213_n168) );
  NAND2_X1 datapath_FIR_mult_213_U119 ( .A1(datapath_FIR_mult_213_n162), .A2(
        datapath_FIR_mult_213_n34), .ZN(datapath_FIR_mult_213_n167) );
  XOR2_X1 datapath_FIR_mult_213_U118 ( .A(datapath_FIR_mult_213_n163), .B(
        datapath_FIR_mult_213_n166), .Z(datapath_FIR_M8_7_) );
  XOR2_X1 datapath_FIR_mult_213_U117 ( .A(datapath_FIR_mult_213_n34), .B(
        datapath_FIR_mult_213_n43), .Z(datapath_FIR_mult_213_n166) );
  NAND3_X1 datapath_FIR_mult_213_U116 ( .A1(datapath_FIR_mult_213_n167), .A2(
        datapath_FIR_mult_213_n168), .A3(datapath_FIR_mult_213_n169), .ZN(
        datapath_FIR_mult_213_n165) );
  NAND3_X1 datapath_FIR_mult_213_U115 ( .A1(datapath_FIR_mult_213_n167), .A2(
        datapath_FIR_mult_213_n168), .A3(datapath_FIR_mult_213_n169), .ZN(
        datapath_FIR_mult_213_n164) );
  NAND3_X1 datapath_FIR_mult_213_U114 ( .A1(datapath_FIR_mult_213_n200), .A2(
        datapath_FIR_mult_213_n201), .A3(datapath_FIR_mult_213_n202), .ZN(
        datapath_FIR_mult_213_n163) );
  NAND3_X1 datapath_FIR_mult_213_U113 ( .A1(datapath_FIR_mult_213_n200), .A2(
        datapath_FIR_mult_213_n201), .A3(datapath_FIR_mult_213_n202), .ZN(
        datapath_FIR_mult_213_n162) );
  INV_X1 datapath_FIR_mult_213_U112 ( .A(datapath_FIR_bq8[5]), .ZN(
        datapath_FIR_mult_213_n161) );
  AND2_X1 datapath_FIR_mult_213_U111 ( .A1(datapath_FIR_mult_213_n86), .A2(
        datapath_FIR_mult_213_n92), .ZN(datapath_FIR_mult_213_n160) );
  AND2_X1 datapath_FIR_mult_213_U110 ( .A1(datapath_FIR_bq8[0]), .A2(
        datapath_FIR_x8[5]), .ZN(datapath_FIR_mult_213_n86) );
  AND3_X2 datapath_FIR_mult_213_U109 ( .A1(datapath_FIR_mult_213_n193), .A2(
        datapath_FIR_mult_213_n194), .A3(datapath_FIR_mult_213_n195), .ZN(
        datapath_FIR_mult_213_n218) );
  HA_X1 datapath_FIR_mult_213_U44 ( .A(datapath_FIR_mult_213_n113), .B(
        datapath_FIR_mult_213_n119), .CO(datapath_FIR_mult_213_n71), .S(
        datapath_FIR_mult_213_n72) );
  HA_X1 datapath_FIR_mult_213_U43 ( .A(datapath_FIR_mult_213_n100), .B(
        datapath_FIR_mult_213_n106), .CO(datapath_FIR_mult_213_n69), .S(
        datapath_FIR_mult_213_n70) );
  FA_X1 datapath_FIR_mult_213_U42 ( .A(datapath_FIR_mult_213_n112), .B(
        datapath_FIR_mult_213_n118), .CI(datapath_FIR_mult_213_n71), .CO(
        datapath_FIR_mult_213_n67), .S(datapath_FIR_mult_213_n68) );
  HA_X1 datapath_FIR_mult_213_U41 ( .A(datapath_FIR_mult_213_n99), .B(
        datapath_FIR_mult_213_n93), .CO(datapath_FIR_mult_213_n65), .S(
        datapath_FIR_mult_213_n66) );
  FA_X1 datapath_FIR_mult_213_U40 ( .A(datapath_FIR_mult_213_n105), .B(
        datapath_FIR_mult_213_n117), .CI(datapath_FIR_mult_213_n111), .CO(
        datapath_FIR_mult_213_n63), .S(datapath_FIR_mult_213_n64) );
  FA_X1 datapath_FIR_mult_213_U39 ( .A(datapath_FIR_mult_213_n66), .B(
        datapath_FIR_mult_213_n69), .CI(datapath_FIR_mult_213_n67), .CO(
        datapath_FIR_mult_213_n61), .S(datapath_FIR_mult_213_n62) );
  FA_X1 datapath_FIR_mult_213_U37 ( .A(datapath_FIR_mult_213_n98), .B(
        datapath_FIR_mult_213_n116), .CI(datapath_FIR_mult_213_n104), .CO(
        datapath_FIR_mult_213_n57), .S(datapath_FIR_mult_213_n58) );
  HA_X1 datapath_FIR_mult_213_U34 ( .A(datapath_FIR_mult_213_n97), .B(
        datapath_FIR_mult_213_n91), .CO(datapath_FIR_mult_213_n51), .S(
        datapath_FIR_mult_213_n52) );
  FA_X1 datapath_FIR_mult_213_U33 ( .A(datapath_FIR_mult_213_n85), .B(
        datapath_FIR_mult_213_n103), .CI(datapath_FIR_mult_213_n109), .CO(
        datapath_FIR_mult_213_n49), .S(datapath_FIR_mult_213_n50) );
  FA_X1 datapath_FIR_mult_213_U32 ( .A(datapath_FIR_mult_213_n79), .B(
        datapath_FIR_mult_213_n115), .CI(datapath_FIR_mult_213_n160), .CO(
        datapath_FIR_mult_213_n47), .S(datapath_FIR_mult_213_n48) );
  FA_X1 datapath_FIR_mult_213_U31 ( .A(datapath_FIR_mult_213_n57), .B(
        datapath_FIR_mult_213_n52), .CI(datapath_FIR_mult_213_n50), .CO(
        datapath_FIR_mult_213_n45), .S(datapath_FIR_mult_213_n46) );
  FA_X1 datapath_FIR_mult_213_U30 ( .A(datapath_FIR_mult_213_n48), .B(
        datapath_FIR_mult_213_n55), .CI(datapath_FIR_mult_213_n46), .CO(
        datapath_FIR_mult_213_n43), .S(datapath_FIR_mult_213_n44) );
  FA_X1 datapath_FIR_mult_213_U27 ( .A(datapath_FIR_mult_213_n102), .B(
        datapath_FIR_mult_213_n90), .CI(datapath_FIR_mult_213_n108), .CO(
        datapath_FIR_mult_213_n39), .S(datapath_FIR_mult_213_n40) );
  FA_X1 datapath_FIR_mult_213_U26 ( .A(datapath_FIR_mult_213_n51), .B(
        datapath_FIR_mult_213_n78), .CI(datapath_FIR_mult_213_n42), .CO(
        datapath_FIR_mult_213_n37), .S(datapath_FIR_mult_213_n38) );
  FA_X1 datapath_FIR_mult_213_U25 ( .A(datapath_FIR_mult_213_n47), .B(
        datapath_FIR_mult_213_n49), .CI(datapath_FIR_mult_213_n40), .CO(
        datapath_FIR_mult_213_n35), .S(datapath_FIR_mult_213_n36) );
  FA_X1 datapath_FIR_mult_213_U24 ( .A(datapath_FIR_mult_213_n45), .B(
        datapath_FIR_mult_213_n38), .CI(datapath_FIR_mult_213_n36), .CO(
        datapath_FIR_mult_213_n33), .S(datapath_FIR_mult_213_n34) );
  FA_X1 datapath_FIR_mult_213_U23 ( .A(datapath_FIR_mult_213_n83), .B(
        datapath_FIR_mult_213_n89), .CI(datapath_FIR_mult_213_n95), .CO(
        datapath_FIR_mult_213_n31), .S(datapath_FIR_mult_213_n32) );
  FA_X1 datapath_FIR_mult_213_U22 ( .A(datapath_FIR_mult_213_n77), .B(
        datapath_FIR_mult_213_n101), .CI(datapath_FIR_mult_213_n41), .CO(
        datapath_FIR_mult_213_n29), .S(datapath_FIR_mult_213_n30) );
  FA_X1 datapath_FIR_mult_213_U21 ( .A(datapath_FIR_mult_213_n32), .B(
        datapath_FIR_mult_213_n39), .CI(datapath_FIR_mult_213_n37), .CO(
        datapath_FIR_mult_213_n27), .S(datapath_FIR_mult_213_n28) );
  FA_X1 datapath_FIR_mult_213_U20 ( .A(datapath_FIR_mult_213_n35), .B(
        datapath_FIR_mult_213_n30), .CI(datapath_FIR_mult_213_n28), .CO(
        datapath_FIR_mult_213_n25), .S(datapath_FIR_mult_213_n26) );
  FA_X1 datapath_FIR_mult_213_U19 ( .A(datapath_FIR_mult_213_n82), .B(
        datapath_FIR_mult_213_n88), .CI(datapath_FIR_mult_213_n94), .CO(
        datapath_FIR_mult_213_n23), .S(datapath_FIR_mult_213_n24) );
  FA_X1 datapath_FIR_mult_213_U18 ( .A(datapath_FIR_mult_213_n31), .B(
        datapath_FIR_mult_213_n76), .CI(datapath_FIR_mult_213_n29), .CO(
        datapath_FIR_mult_213_n21), .S(datapath_FIR_mult_213_n22) );
  FA_X1 datapath_FIR_mult_213_U17 ( .A(datapath_FIR_mult_213_n27), .B(
        datapath_FIR_mult_213_n24), .CI(datapath_FIR_mult_213_n22), .CO(
        datapath_FIR_mult_213_n19), .S(datapath_FIR_mult_213_n20) );
  FA_X1 datapath_FIR_mult_213_U16 ( .A(datapath_FIR_mult_213_n87), .B(
        datapath_FIR_mult_213_n81), .CI(datapath_FIR_mult_213_n75), .CO(
        datapath_FIR_mult_213_n17), .S(datapath_FIR_mult_213_n18) );
  FA_X1 datapath_FIR_mult_213_U15 ( .A(datapath_FIR_mult_213_n18), .B(
        datapath_FIR_mult_213_n23), .CI(datapath_FIR_mult_213_n21), .CO(
        datapath_FIR_mult_213_n15), .S(datapath_FIR_mult_213_n16) );
  FA_X1 datapath_FIR_mult_213_U14 ( .A(datapath_FIR_mult_213_n74), .B(
        datapath_FIR_mult_213_n80), .CI(datapath_FIR_mult_213_n17), .CO(
        datapath_FIR_mult_213_n13), .S(datapath_FIR_mult_213_n14) );
  FA_X1 datapath_FIR_mult_213_U5 ( .A(datapath_FIR_mult_213_n20), .B(
        datapath_FIR_mult_213_n25), .CI(datapath_FIR_mult_213_n5), .CO(
        datapath_FIR_mult_213_n4), .S(datapath_FIR_M8_9_) );
  FA_X1 datapath_FIR_mult_213_U4 ( .A(datapath_FIR_mult_213_n16), .B(
        datapath_FIR_mult_213_n19), .CI(datapath_FIR_mult_213_n4), .CO(
        datapath_FIR_mult_213_n3), .S(datapath_FIR_M8_10_) );
  FA_X1 datapath_FIR_mult_213_U3 ( .A(datapath_FIR_mult_213_n15), .B(
        datapath_FIR_mult_213_n14), .CI(datapath_FIR_mult_213_n3), .CO(
        datapath_FIR_mult_213_n2), .S(datapath_FIR_M8_11_) );
  NOR2_X1 datapath_FIR_mult_210_U237 ( .A1(datapath_FIR_mult_210_n218), .A2(
        datapath_FIR_mult_210_n215), .ZN(datapath_FIR_mult_210_n100) );
  NAND2_X1 datapath_FIR_mult_210_U236 ( .A1(datapath_FIR_x5[2]), .A2(
        datapath_FIR_bq5[6]), .ZN(datapath_FIR_mult_210_n101) );
  NOR2_X1 datapath_FIR_mult_210_U235 ( .A1(datapath_FIR_mult_210_n219), .A2(
        datapath_FIR_mult_210_n208), .ZN(datapath_FIR_mult_210_n102) );
  NOR2_X1 datapath_FIR_mult_210_U234 ( .A1(datapath_FIR_mult_210_n212), .A2(
        datapath_FIR_mult_210_n219), .ZN(datapath_FIR_mult_210_n104) );
  NOR2_X1 datapath_FIR_mult_210_U233 ( .A1(datapath_FIR_mult_210_n213), .A2(
        datapath_FIR_mult_210_n219), .ZN(datapath_FIR_mult_210_n105) );
  NOR2_X1 datapath_FIR_mult_210_U232 ( .A1(datapath_FIR_mult_210_n169), .A2(
        datapath_FIR_mult_210_n219), .ZN(datapath_FIR_mult_210_n106) );
  NAND2_X1 datapath_FIR_mult_210_U231 ( .A1(datapath_FIR_mult_210_n165), .A2(
        datapath_FIR_bq5[6]), .ZN(datapath_FIR_mult_210_n108) );
  NOR2_X1 datapath_FIR_mult_210_U230 ( .A1(datapath_FIR_mult_210_n209), .A2(
        datapath_FIR_mult_210_n220), .ZN(datapath_FIR_mult_210_n110) );
  NOR2_X1 datapath_FIR_mult_210_U229 ( .A1(datapath_FIR_mult_210_n212), .A2(
        datapath_FIR_mult_210_n220), .ZN(datapath_FIR_mult_210_n111) );
  NAND2_X1 datapath_FIR_mult_210_U228 ( .A1(datapath_FIR_mult_210_n177), .A2(
        datapath_FIR_bq5[6]), .ZN(datapath_FIR_mult_210_n115) );
  NOR2_X1 datapath_FIR_mult_210_U227 ( .A1(datapath_FIR_mult_210_n208), .A2(
        datapath_FIR_mult_210_n221), .ZN(datapath_FIR_mult_210_n116) );
  NOR2_X1 datapath_FIR_mult_210_U226 ( .A1(datapath_FIR_mult_210_n209), .A2(
        datapath_FIR_mult_210_n221), .ZN(datapath_FIR_mult_210_n117) );
  NAND2_X1 datapath_FIR_mult_210_U225 ( .A1(datapath_FIR_bq5[4]), .A2(
        datapath_FIR_x5[3]), .ZN(datapath_FIR_mult_210_n229) );
  NAND2_X1 datapath_FIR_mult_210_U224 ( .A1(datapath_FIR_mult_210_n164), .A2(
        datapath_FIR_mult_210_n166), .ZN(datapath_FIR_mult_210_n228) );
  NAND2_X1 datapath_FIR_mult_210_U223 ( .A1(datapath_FIR_mult_210_n229), .A2(
        datapath_FIR_mult_210_n228), .ZN(datapath_FIR_mult_210_n41) );
  XNOR2_X1 datapath_FIR_mult_210_U222 ( .A(datapath_FIR_mult_210_n228), .B(
        datapath_FIR_mult_210_n229), .ZN(datapath_FIR_mult_210_n42) );
  NAND2_X1 datapath_FIR_mult_210_U221 ( .A1(datapath_FIR_bq5[5]), .A2(
        datapath_FIR_x5[6]), .ZN(datapath_FIR_mult_210_n74) );
  NAND2_X1 datapath_FIR_mult_210_U220 ( .A1(datapath_FIR_bq5[4]), .A2(
        datapath_FIR_x5[6]), .ZN(datapath_FIR_mult_210_n75) );
  NAND2_X1 datapath_FIR_mult_210_U219 ( .A1(datapath_FIR_bq5[3]), .A2(
        datapath_FIR_x5[6]), .ZN(datapath_FIR_mult_210_n76) );
  NAND2_X1 datapath_FIR_mult_210_U218 ( .A1(datapath_FIR_mult_210_n166), .A2(
        datapath_FIR_x5[6]), .ZN(datapath_FIR_mult_210_n77) );
  NAND2_X1 datapath_FIR_mult_210_U217 ( .A1(datapath_FIR_mult_210_n167), .A2(
        datapath_FIR_x5[6]), .ZN(datapath_FIR_mult_210_n78) );
  NAND2_X1 datapath_FIR_mult_210_U216 ( .A1(datapath_FIR_bq5[0]), .A2(
        datapath_FIR_x5[6]), .ZN(datapath_FIR_mult_210_n79) );
  NOR4_X1 datapath_FIR_mult_210_U215 ( .A1(datapath_FIR_mult_210_n220), .A2(
        datapath_FIR_mult_210_n221), .A3(datapath_FIR_mult_210_n215), .A4(
        datapath_FIR_mult_210_n169), .ZN(datapath_FIR_mult_210_n226) );
  NOR2_X1 datapath_FIR_mult_210_U214 ( .A1(datapath_FIR_mult_210_n219), .A2(
        datapath_FIR_mult_210_n215), .ZN(datapath_FIR_mult_210_n227) );
  OAI222_X1 datapath_FIR_mult_210_U213 ( .A1(datapath_FIR_mult_210_n225), .A2(
        datapath_FIR_mult_210_n211), .B1(datapath_FIR_mult_210_n211), .B2(
        datapath_FIR_mult_210_n214), .C1(datapath_FIR_mult_210_n225), .C2(
        datapath_FIR_mult_210_n214), .ZN(datapath_FIR_mult_210_n224) );
  OAI222_X1 datapath_FIR_mult_210_U212 ( .A1(datapath_FIR_mult_210_n223), .A2(
        datapath_FIR_mult_210_n171), .B1(datapath_FIR_mult_210_n223), .B2(
        datapath_FIR_mult_210_n210), .C1(datapath_FIR_mult_210_n210), .C2(
        datapath_FIR_mult_210_n207), .ZN(datapath_FIR_mult_210_n8) );
  NAND2_X1 datapath_FIR_mult_210_U211 ( .A1(datapath_FIR_mult_210_n164), .A2(
        datapath_FIR_bq5[6]), .ZN(datapath_FIR_mult_210_n80) );
  NOR2_X1 datapath_FIR_mult_210_U210 ( .A1(datapath_FIR_mult_210_n208), .A2(
        datapath_FIR_mult_210_n176), .ZN(datapath_FIR_mult_210_n81) );
  NOR2_X1 datapath_FIR_mult_210_U209 ( .A1(datapath_FIR_mult_210_n209), .A2(
        datapath_FIR_mult_210_n176), .ZN(datapath_FIR_mult_210_n82) );
  NOR2_X1 datapath_FIR_mult_210_U208 ( .A1(datapath_FIR_mult_210_n212), .A2(
        datapath_FIR_mult_210_n176), .ZN(datapath_FIR_mult_210_n83) );
  NOR2_X1 datapath_FIR_mult_210_U207 ( .A1(datapath_FIR_mult_210_n169), .A2(
        datapath_FIR_mult_210_n216), .ZN(datapath_FIR_mult_210_n85) );
  NAND2_X1 datapath_FIR_mult_210_U206 ( .A1(datapath_FIR_x5[4]), .A2(
        datapath_FIR_bq5[6]), .ZN(datapath_FIR_mult_210_n87) );
  NOR2_X1 datapath_FIR_mult_210_U205 ( .A1(datapath_FIR_mult_210_n208), .A2(
        datapath_FIR_mult_210_n168), .ZN(datapath_FIR_mult_210_n88) );
  NOR2_X1 datapath_FIR_mult_210_U204 ( .A1(datapath_FIR_mult_210_n168), .A2(
        datapath_FIR_mult_210_n209), .ZN(datapath_FIR_mult_210_n89) );
  NOR2_X1 datapath_FIR_mult_210_U203 ( .A1(datapath_FIR_mult_210_n212), .A2(
        datapath_FIR_mult_210_n217), .ZN(datapath_FIR_mult_210_n90) );
  NOR2_X1 datapath_FIR_mult_210_U202 ( .A1(datapath_FIR_mult_210_n213), .A2(
        datapath_FIR_mult_210_n217), .ZN(datapath_FIR_mult_210_n91) );
  NAND2_X1 datapath_FIR_mult_210_U201 ( .A1(datapath_FIR_x5[3]), .A2(
        datapath_FIR_bq5[6]), .ZN(datapath_FIR_mult_210_n94) );
  NOR2_X1 datapath_FIR_mult_210_U200 ( .A1(datapath_FIR_mult_210_n170), .A2(
        datapath_FIR_mult_210_n208), .ZN(datapath_FIR_mult_210_n95) );
  NOR2_X1 datapath_FIR_mult_210_U199 ( .A1(datapath_FIR_mult_210_n170), .A2(
        datapath_FIR_mult_210_n212), .ZN(datapath_FIR_mult_210_n97) );
  NOR2_X1 datapath_FIR_mult_210_U198 ( .A1(datapath_FIR_mult_210_n170), .A2(
        datapath_FIR_mult_210_n213), .ZN(datapath_FIR_mult_210_n98) );
  XNOR2_X1 datapath_FIR_mult_210_U197 ( .A(datapath_FIR_mult_210_n2), .B(
        datapath_FIR_mult_210_n13), .ZN(datapath_FIR_mult_210_n222) );
  INV_X1 datapath_FIR_mult_210_U196 ( .A(datapath_FIR_mult_210_n68), .ZN(
        datapath_FIR_mult_210_n211) );
  INV_X1 datapath_FIR_mult_210_U195 ( .A(datapath_FIR_mult_210_n54), .ZN(
        datapath_FIR_mult_210_n207) );
  INV_X1 datapath_FIR_mult_210_U194 ( .A(datapath_FIR_x5[0]), .ZN(
        datapath_FIR_mult_210_n221) );
  INV_X1 datapath_FIR_mult_210_U193 ( .A(datapath_FIR_x5[1]), .ZN(
        datapath_FIR_mult_210_n220) );
  INV_X1 datapath_FIR_mult_210_U192 ( .A(datapath_FIR_x5[5]), .ZN(
        datapath_FIR_mult_210_n216) );
  INV_X1 datapath_FIR_mult_210_U191 ( .A(datapath_FIR_bq5[2]), .ZN(
        datapath_FIR_mult_210_n213) );
  INV_X1 datapath_FIR_mult_210_U190 ( .A(datapath_FIR_x5[4]), .ZN(
        datapath_FIR_mult_210_n217) );
  AND2_X1 datapath_FIR_mult_210_U189 ( .A1(datapath_FIR_x5[1]), .A2(
        datapath_FIR_bq5[1]), .ZN(datapath_FIR_mult_210_n113) );
  NAND3_X1 datapath_FIR_mult_210_U188 ( .A1(datapath_FIR_mult_210_n204), .A2(
        datapath_FIR_mult_210_n205), .A3(datapath_FIR_mult_210_n206), .ZN(
        datapath_FIR_mult_210_n6) );
  NAND2_X1 datapath_FIR_mult_210_U187 ( .A1(datapath_FIR_mult_210_n43), .A2(
        datapath_FIR_mult_210_n199), .ZN(datapath_FIR_mult_210_n206) );
  NAND2_X1 datapath_FIR_mult_210_U186 ( .A1(datapath_FIR_mult_210_n34), .A2(
        datapath_FIR_mult_210_n199), .ZN(datapath_FIR_mult_210_n205) );
  NAND2_X1 datapath_FIR_mult_210_U185 ( .A1(datapath_FIR_mult_210_n34), .A2(
        datapath_FIR_mult_210_n43), .ZN(datapath_FIR_mult_210_n204) );
  NAND2_X1 datapath_FIR_mult_210_U184 ( .A1(datapath_FIR_mult_210_n174), .A2(
        datapath_FIR_mult_210_n53), .ZN(datapath_FIR_mult_210_n203) );
  NAND2_X1 datapath_FIR_mult_210_U183 ( .A1(datapath_FIR_mult_210_n8), .A2(
        datapath_FIR_mult_210_n44), .ZN(datapath_FIR_mult_210_n202) );
  NAND2_X1 datapath_FIR_mult_210_U182 ( .A1(datapath_FIR_mult_210_n44), .A2(
        datapath_FIR_mult_210_n53), .ZN(datapath_FIR_mult_210_n201) );
  NAND3_X1 datapath_FIR_mult_210_U181 ( .A1(datapath_FIR_mult_210_n203), .A2(
        datapath_FIR_mult_210_n202), .A3(datapath_FIR_mult_210_n201), .ZN(
        datapath_FIR_mult_210_n200) );
  NAND3_X1 datapath_FIR_mult_210_U180 ( .A1(datapath_FIR_mult_210_n202), .A2(
        datapath_FIR_mult_210_n203), .A3(datapath_FIR_mult_210_n201), .ZN(
        datapath_FIR_mult_210_n199) );
  NAND3_X1 datapath_FIR_mult_210_U179 ( .A1(datapath_FIR_mult_210_n196), .A2(
        datapath_FIR_mult_210_n197), .A3(datapath_FIR_mult_210_n198), .ZN(
        datapath_FIR_mult_210_n2) );
  NAND2_X1 datapath_FIR_mult_210_U178 ( .A1(datapath_FIR_mult_210_n14), .A2(
        datapath_FIR_mult_210_n3), .ZN(datapath_FIR_mult_210_n198) );
  NAND2_X1 datapath_FIR_mult_210_U177 ( .A1(datapath_FIR_mult_210_n15), .A2(
        datapath_FIR_mult_210_n189), .ZN(datapath_FIR_mult_210_n197) );
  NAND2_X1 datapath_FIR_mult_210_U176 ( .A1(datapath_FIR_mult_210_n15), .A2(
        datapath_FIR_mult_210_n14), .ZN(datapath_FIR_mult_210_n196) );
  XOR2_X1 datapath_FIR_mult_210_U175 ( .A(datapath_FIR_mult_210_n195), .B(
        datapath_FIR_mult_210_n190), .Z(datapath_FIR_M5_11_) );
  XOR2_X1 datapath_FIR_mult_210_U174 ( .A(datapath_FIR_mult_210_n15), .B(
        datapath_FIR_mult_210_n14), .Z(datapath_FIR_mult_210_n195) );
  NAND3_X1 datapath_FIR_mult_210_U173 ( .A1(datapath_FIR_mult_210_n192), .A2(
        datapath_FIR_mult_210_n193), .A3(datapath_FIR_mult_210_n194), .ZN(
        datapath_FIR_mult_210_n3) );
  NAND2_X1 datapath_FIR_mult_210_U172 ( .A1(datapath_FIR_mult_210_n19), .A2(
        datapath_FIR_mult_210_n4), .ZN(datapath_FIR_mult_210_n194) );
  NAND2_X1 datapath_FIR_mult_210_U171 ( .A1(datapath_FIR_mult_210_n16), .A2(
        datapath_FIR_mult_210_n4), .ZN(datapath_FIR_mult_210_n193) );
  NAND2_X1 datapath_FIR_mult_210_U170 ( .A1(datapath_FIR_mult_210_n16), .A2(
        datapath_FIR_mult_210_n19), .ZN(datapath_FIR_mult_210_n192) );
  XOR2_X1 datapath_FIR_mult_210_U169 ( .A(datapath_FIR_mult_210_n191), .B(
        datapath_FIR_mult_210_n4), .Z(datapath_FIR_M5_10_) );
  XOR2_X1 datapath_FIR_mult_210_U168 ( .A(datapath_FIR_mult_210_n16), .B(
        datapath_FIR_mult_210_n19), .Z(datapath_FIR_mult_210_n191) );
  NAND3_X1 datapath_FIR_mult_210_U167 ( .A1(datapath_FIR_mult_210_n192), .A2(
        datapath_FIR_mult_210_n193), .A3(datapath_FIR_mult_210_n194), .ZN(
        datapath_FIR_mult_210_n190) );
  NAND3_X1 datapath_FIR_mult_210_U166 ( .A1(datapath_FIR_mult_210_n192), .A2(
        datapath_FIR_mult_210_n193), .A3(datapath_FIR_mult_210_n194), .ZN(
        datapath_FIR_mult_210_n189) );
  INV_X1 datapath_FIR_mult_210_U165 ( .A(datapath_FIR_x5[2]), .ZN(
        datapath_FIR_mult_210_n219) );
  NAND3_X1 datapath_FIR_mult_210_U164 ( .A1(datapath_FIR_mult_210_n186), .A2(
        datapath_FIR_mult_210_n187), .A3(datapath_FIR_mult_210_n188), .ZN(
        datapath_FIR_mult_210_n5) );
  NAND2_X1 datapath_FIR_mult_210_U163 ( .A1(datapath_FIR_mult_210_n26), .A2(
        datapath_FIR_mult_210_n33), .ZN(datapath_FIR_mult_210_n188) );
  NAND2_X1 datapath_FIR_mult_210_U162 ( .A1(datapath_FIR_mult_210_n6), .A2(
        datapath_FIR_mult_210_n33), .ZN(datapath_FIR_mult_210_n187) );
  NAND2_X1 datapath_FIR_mult_210_U161 ( .A1(datapath_FIR_mult_210_n183), .A2(
        datapath_FIR_mult_210_n26), .ZN(datapath_FIR_mult_210_n186) );
  XNOR2_X1 datapath_FIR_mult_210_U160 ( .A(datapath_FIR_mult_210_n44), .B(
        datapath_FIR_mult_210_n53), .ZN(datapath_FIR_mult_210_n185) );
  XNOR2_X1 datapath_FIR_mult_210_U159 ( .A(datapath_FIR_mult_210_n185), .B(
        datapath_FIR_mult_210_n175), .ZN(datapath_FIR_M5_6_) );
  NAND3_X1 datapath_FIR_mult_210_U158 ( .A1(datapath_FIR_mult_210_n204), .A2(
        datapath_FIR_mult_210_n205), .A3(datapath_FIR_mult_210_n206), .ZN(
        datapath_FIR_mult_210_n184) );
  NAND3_X1 datapath_FIR_mult_210_U157 ( .A1(datapath_FIR_mult_210_n204), .A2(
        datapath_FIR_mult_210_n205), .A3(datapath_FIR_mult_210_n206), .ZN(
        datapath_FIR_mult_210_n183) );
  XNOR2_X1 datapath_FIR_mult_210_U156 ( .A(datapath_FIR_mult_210_n34), .B(
        datapath_FIR_mult_210_n43), .ZN(datapath_FIR_mult_210_n182) );
  XNOR2_X1 datapath_FIR_mult_210_U155 ( .A(datapath_FIR_mult_210_n200), .B(
        datapath_FIR_mult_210_n182), .ZN(datapath_FIR_M5_7_) );
  NAND3_X1 datapath_FIR_mult_210_U154 ( .A1(datapath_FIR_mult_210_n179), .A2(
        datapath_FIR_mult_210_n180), .A3(datapath_FIR_mult_210_n181), .ZN(
        datapath_FIR_mult_210_n4) );
  NAND2_X1 datapath_FIR_mult_210_U153 ( .A1(datapath_FIR_mult_210_n20), .A2(
        datapath_FIR_mult_210_n25), .ZN(datapath_FIR_mult_210_n181) );
  NAND2_X1 datapath_FIR_mult_210_U152 ( .A1(datapath_FIR_mult_210_n5), .A2(
        datapath_FIR_mult_210_n25), .ZN(datapath_FIR_mult_210_n180) );
  NAND2_X1 datapath_FIR_mult_210_U151 ( .A1(datapath_FIR_mult_210_n5), .A2(
        datapath_FIR_mult_210_n20), .ZN(datapath_FIR_mult_210_n179) );
  XOR2_X1 datapath_FIR_mult_210_U150 ( .A(datapath_FIR_mult_210_n5), .B(
        datapath_FIR_mult_210_n178), .Z(datapath_FIR_M5_9_) );
  XOR2_X1 datapath_FIR_mult_210_U149 ( .A(datapath_FIR_mult_210_n20), .B(
        datapath_FIR_mult_210_n25), .Z(datapath_FIR_mult_210_n178) );
  INV_X1 datapath_FIR_mult_210_U148 ( .A(datapath_FIR_mult_210_n221), .ZN(
        datapath_FIR_mult_210_n177) );
  AND2_X1 datapath_FIR_mult_210_U147 ( .A1(datapath_FIR_bq5[1]), .A2(
        datapath_FIR_x5[4]), .ZN(datapath_FIR_mult_210_n92) );
  INV_X1 datapath_FIR_mult_210_U146 ( .A(datapath_FIR_x5[5]), .ZN(
        datapath_FIR_mult_210_n176) );
  AOI222_X4 datapath_FIR_mult_210_U145 ( .A1(datapath_FIR_mult_210_n224), .A2(
        datapath_FIR_mult_210_n62), .B1(datapath_FIR_mult_210_n224), .B2(
        datapath_FIR_mult_210_n64), .C1(datapath_FIR_mult_210_n62), .C2(
        datapath_FIR_mult_210_n64), .ZN(datapath_FIR_mult_210_n223) );
  OAI222_X1 datapath_FIR_mult_210_U144 ( .A1(datapath_FIR_mult_210_n223), .A2(
        datapath_FIR_mult_210_n171), .B1(datapath_FIR_mult_210_n223), .B2(
        datapath_FIR_mult_210_n210), .C1(datapath_FIR_mult_210_n210), .C2(
        datapath_FIR_mult_210_n171), .ZN(datapath_FIR_mult_210_n175) );
  OAI222_X1 datapath_FIR_mult_210_U143 ( .A1(datapath_FIR_mult_210_n223), .A2(
        datapath_FIR_mult_210_n171), .B1(datapath_FIR_mult_210_n223), .B2(
        datapath_FIR_mult_210_n210), .C1(datapath_FIR_mult_210_n210), .C2(
        datapath_FIR_mult_210_n207), .ZN(datapath_FIR_mult_210_n174) );
  INV_X1 datapath_FIR_mult_210_U142 ( .A(datapath_FIR_bq5[0]), .ZN(
        datapath_FIR_mult_210_n215) );
  INV_X1 datapath_FIR_mult_210_U141 ( .A(datapath_FIR_bq5[4]), .ZN(
        datapath_FIR_mult_210_n209) );
  INV_X1 datapath_FIR_mult_210_U140 ( .A(datapath_FIR_x5[3]), .ZN(
        datapath_FIR_mult_210_n218) );
  INV_X1 datapath_FIR_mult_210_U139 ( .A(datapath_FIR_bq5[3]), .ZN(
        datapath_FIR_mult_210_n212) );
  INV_X1 datapath_FIR_mult_210_U138 ( .A(datapath_FIR_bq5[5]), .ZN(
        datapath_FIR_mult_210_n208) );
  INV_X1 datapath_FIR_mult_210_U137 ( .A(datapath_FIR_mult_210_n70), .ZN(
        datapath_FIR_mult_210_n214) );
  INV_X1 datapath_FIR_mult_210_U136 ( .A(datapath_FIR_mult_210_n61), .ZN(
        datapath_FIR_mult_210_n210) );
  AND2_X1 datapath_FIR_mult_210_U135 ( .A1(datapath_FIR_bq5[6]), .A2(
        datapath_FIR_x5[6]), .ZN(datapath_FIR_mult_210_n173) );
  XNOR2_X1 datapath_FIR_mult_210_U134 ( .A(datapath_FIR_mult_210_n173), .B(
        datapath_FIR_mult_210_n222), .ZN(datapath_FIR_M5_12_) );
  AND2_X1 datapath_FIR_mult_210_U133 ( .A1(datapath_FIR_bq5[2]), .A2(
        datapath_FIR_x5[0]), .ZN(datapath_FIR_mult_210_n119) );
  XNOR2_X1 datapath_FIR_mult_210_U132 ( .A(datapath_FIR_mult_210_n26), .B(
        datapath_FIR_mult_210_n33), .ZN(datapath_FIR_mult_210_n172) );
  XNOR2_X1 datapath_FIR_mult_210_U131 ( .A(datapath_FIR_mult_210_n184), .B(
        datapath_FIR_mult_210_n172), .ZN(datapath_FIR_M5_8_) );
  INV_X1 datapath_FIR_mult_210_U130 ( .A(datapath_FIR_mult_210_n54), .ZN(
        datapath_FIR_mult_210_n171) );
  INV_X1 datapath_FIR_mult_210_U129 ( .A(datapath_FIR_x5[3]), .ZN(
        datapath_FIR_mult_210_n170) );
  INV_X1 datapath_FIR_mult_210_U128 ( .A(datapath_FIR_bq5[1]), .ZN(
        datapath_FIR_mult_210_n169) );
  AND2_X1 datapath_FIR_mult_210_U127 ( .A1(datapath_FIR_bq5[4]), .A2(
        datapath_FIR_x5[2]), .ZN(datapath_FIR_mult_210_n103) );
  AND2_X1 datapath_FIR_mult_210_U126 ( .A1(datapath_FIR_bq5[0]), .A2(
        datapath_FIR_x5[5]), .ZN(datapath_FIR_mult_210_n86) );
  CLKBUF_X1 datapath_FIR_mult_210_U125 ( .A(datapath_FIR_mult_210_n217), .Z(
        datapath_FIR_mult_210_n168) );
  INV_X1 datapath_FIR_mult_210_U124 ( .A(datapath_FIR_mult_210_n169), .ZN(
        datapath_FIR_mult_210_n167) );
  AND2_X1 datapath_FIR_mult_210_U123 ( .A1(datapath_FIR_x5[4]), .A2(
        datapath_FIR_bq5[0]), .ZN(datapath_FIR_mult_210_n93) );
  CLKBUF_X1 datapath_FIR_mult_210_U122 ( .A(datapath_FIR_bq5[2]), .Z(
        datapath_FIR_mult_210_n166) );
  INV_X1 datapath_FIR_mult_210_U121 ( .A(datapath_FIR_mult_210_n220), .ZN(
        datapath_FIR_mult_210_n165) );
  AND2_X1 datapath_FIR_mult_210_U120 ( .A1(datapath_FIR_mult_210_n113), .A2(
        datapath_FIR_mult_210_n119), .ZN(datapath_FIR_mult_210_n71) );
  AND2_X1 datapath_FIR_mult_210_U119 ( .A1(datapath_FIR_x5[3]), .A2(
        datapath_FIR_bq5[1]), .ZN(datapath_FIR_mult_210_n99) );
  XOR2_X1 datapath_FIR_mult_210_U118 ( .A(datapath_FIR_mult_210_n160), .B(
        datapath_FIR_mult_210_n119), .Z(datapath_FIR_mult_210_n72) );
  AND2_X1 datapath_FIR_mult_210_U117 ( .A1(datapath_FIR_bq5[2]), .A2(
        datapath_FIR_x5[1]), .ZN(datapath_FIR_mult_210_n112) );
  INV_X1 datapath_FIR_mult_210_U116 ( .A(datapath_FIR_mult_210_n176), .ZN(
        datapath_FIR_mult_210_n164) );
  AND2_X1 datapath_FIR_mult_210_U115 ( .A1(datapath_FIR_bq5[5]), .A2(
        datapath_FIR_x5[1]), .ZN(datapath_FIR_mult_210_n109) );
  AND2_X1 datapath_FIR_mult_210_U114 ( .A1(datapath_FIR_bq5[3]), .A2(
        datapath_FIR_x5[0]), .ZN(datapath_FIR_mult_210_n118) );
  AND3_X1 datapath_FIR_mult_210_U113 ( .A1(datapath_FIR_mult_210_n161), .A2(
        datapath_FIR_mult_210_n162), .A3(datapath_FIR_mult_210_n163), .ZN(
        datapath_FIR_mult_210_n225) );
  NAND2_X1 datapath_FIR_mult_210_U112 ( .A1(datapath_FIR_mult_210_n227), .A2(
        datapath_FIR_mult_210_n226), .ZN(datapath_FIR_mult_210_n163) );
  NAND2_X1 datapath_FIR_mult_210_U111 ( .A1(datapath_FIR_mult_210_n227), .A2(
        datapath_FIR_mult_210_n72), .ZN(datapath_FIR_mult_210_n162) );
  NAND2_X1 datapath_FIR_mult_210_U110 ( .A1(datapath_FIR_mult_210_n72), .A2(
        datapath_FIR_mult_210_n226), .ZN(datapath_FIR_mult_210_n161) );
  CLKBUF_X1 datapath_FIR_mult_210_U109 ( .A(datapath_FIR_mult_210_n113), .Z(
        datapath_FIR_mult_210_n160) );
  HA_X1 datapath_FIR_mult_210_U43 ( .A(datapath_FIR_mult_210_n106), .B(
        datapath_FIR_mult_210_n100), .CO(datapath_FIR_mult_210_n69), .S(
        datapath_FIR_mult_210_n70) );
  FA_X1 datapath_FIR_mult_210_U42 ( .A(datapath_FIR_mult_210_n112), .B(
        datapath_FIR_mult_210_n118), .CI(datapath_FIR_mult_210_n71), .CO(
        datapath_FIR_mult_210_n67), .S(datapath_FIR_mult_210_n68) );
  HA_X1 datapath_FIR_mult_210_U41 ( .A(datapath_FIR_mult_210_n99), .B(
        datapath_FIR_mult_210_n93), .CO(datapath_FIR_mult_210_n65), .S(
        datapath_FIR_mult_210_n66) );
  FA_X1 datapath_FIR_mult_210_U40 ( .A(datapath_FIR_mult_210_n105), .B(
        datapath_FIR_mult_210_n117), .CI(datapath_FIR_mult_210_n111), .CO(
        datapath_FIR_mult_210_n63), .S(datapath_FIR_mult_210_n64) );
  FA_X1 datapath_FIR_mult_210_U39 ( .A(datapath_FIR_mult_210_n66), .B(
        datapath_FIR_mult_210_n69), .CI(datapath_FIR_mult_210_n67), .CO(
        datapath_FIR_mult_210_n61), .S(datapath_FIR_mult_210_n62) );
  HA_X1 datapath_FIR_mult_210_U38 ( .A(datapath_FIR_mult_210_n86), .B(
        datapath_FIR_mult_210_n92), .CO(datapath_FIR_mult_210_n59), .S(
        datapath_FIR_mult_210_n60) );
  FA_X1 datapath_FIR_mult_210_U37 ( .A(datapath_FIR_mult_210_n98), .B(
        datapath_FIR_mult_210_n116), .CI(datapath_FIR_mult_210_n104), .CO(
        datapath_FIR_mult_210_n57), .S(datapath_FIR_mult_210_n58) );
  FA_X1 datapath_FIR_mult_210_U36 ( .A(datapath_FIR_mult_210_n65), .B(
        datapath_FIR_mult_210_n110), .CI(datapath_FIR_mult_210_n60), .CO(
        datapath_FIR_mult_210_n55), .S(datapath_FIR_mult_210_n56) );
  FA_X1 datapath_FIR_mult_210_U35 ( .A(datapath_FIR_mult_210_n58), .B(
        datapath_FIR_mult_210_n63), .CI(datapath_FIR_mult_210_n56), .CO(
        datapath_FIR_mult_210_n53), .S(datapath_FIR_mult_210_n54) );
  HA_X1 datapath_FIR_mult_210_U34 ( .A(datapath_FIR_mult_210_n97), .B(
        datapath_FIR_mult_210_n91), .CO(datapath_FIR_mult_210_n51), .S(
        datapath_FIR_mult_210_n52) );
  FA_X1 datapath_FIR_mult_210_U33 ( .A(datapath_FIR_mult_210_n109), .B(
        datapath_FIR_mult_210_n103), .CI(datapath_FIR_mult_210_n85), .CO(
        datapath_FIR_mult_210_n49), .S(datapath_FIR_mult_210_n50) );
  FA_X1 datapath_FIR_mult_210_U32 ( .A(datapath_FIR_mult_210_n79), .B(
        datapath_FIR_mult_210_n115), .CI(datapath_FIR_mult_210_n59), .CO(
        datapath_FIR_mult_210_n47), .S(datapath_FIR_mult_210_n48) );
  FA_X1 datapath_FIR_mult_210_U31 ( .A(datapath_FIR_mult_210_n57), .B(
        datapath_FIR_mult_210_n52), .CI(datapath_FIR_mult_210_n50), .CO(
        datapath_FIR_mult_210_n45), .S(datapath_FIR_mult_210_n46) );
  FA_X1 datapath_FIR_mult_210_U30 ( .A(datapath_FIR_mult_210_n48), .B(
        datapath_FIR_mult_210_n55), .CI(datapath_FIR_mult_210_n46), .CO(
        datapath_FIR_mult_210_n43), .S(datapath_FIR_mult_210_n44) );
  FA_X1 datapath_FIR_mult_210_U27 ( .A(datapath_FIR_mult_210_n102), .B(
        datapath_FIR_mult_210_n90), .CI(datapath_FIR_mult_210_n108), .CO(
        datapath_FIR_mult_210_n39), .S(datapath_FIR_mult_210_n40) );
  FA_X1 datapath_FIR_mult_210_U26 ( .A(datapath_FIR_mult_210_n51), .B(
        datapath_FIR_mult_210_n78), .CI(datapath_FIR_mult_210_n42), .CO(
        datapath_FIR_mult_210_n37), .S(datapath_FIR_mult_210_n38) );
  FA_X1 datapath_FIR_mult_210_U25 ( .A(datapath_FIR_mult_210_n47), .B(
        datapath_FIR_mult_210_n49), .CI(datapath_FIR_mult_210_n40), .CO(
        datapath_FIR_mult_210_n35), .S(datapath_FIR_mult_210_n36) );
  FA_X1 datapath_FIR_mult_210_U24 ( .A(datapath_FIR_mult_210_n45), .B(
        datapath_FIR_mult_210_n38), .CI(datapath_FIR_mult_210_n36), .CO(
        datapath_FIR_mult_210_n33), .S(datapath_FIR_mult_210_n34) );
  FA_X1 datapath_FIR_mult_210_U23 ( .A(datapath_FIR_mult_210_n83), .B(
        datapath_FIR_mult_210_n89), .CI(datapath_FIR_mult_210_n95), .CO(
        datapath_FIR_mult_210_n31), .S(datapath_FIR_mult_210_n32) );
  FA_X1 datapath_FIR_mult_210_U22 ( .A(datapath_FIR_mult_210_n77), .B(
        datapath_FIR_mult_210_n101), .CI(datapath_FIR_mult_210_n41), .CO(
        datapath_FIR_mult_210_n29), .S(datapath_FIR_mult_210_n30) );
  FA_X1 datapath_FIR_mult_210_U21 ( .A(datapath_FIR_mult_210_n32), .B(
        datapath_FIR_mult_210_n39), .CI(datapath_FIR_mult_210_n37), .CO(
        datapath_FIR_mult_210_n27), .S(datapath_FIR_mult_210_n28) );
  FA_X1 datapath_FIR_mult_210_U20 ( .A(datapath_FIR_mult_210_n35), .B(
        datapath_FIR_mult_210_n30), .CI(datapath_FIR_mult_210_n28), .CO(
        datapath_FIR_mult_210_n25), .S(datapath_FIR_mult_210_n26) );
  FA_X1 datapath_FIR_mult_210_U19 ( .A(datapath_FIR_mult_210_n82), .B(
        datapath_FIR_mult_210_n88), .CI(datapath_FIR_mult_210_n94), .CO(
        datapath_FIR_mult_210_n23), .S(datapath_FIR_mult_210_n24) );
  FA_X1 datapath_FIR_mult_210_U18 ( .A(datapath_FIR_mult_210_n31), .B(
        datapath_FIR_mult_210_n76), .CI(datapath_FIR_mult_210_n29), .CO(
        datapath_FIR_mult_210_n21), .S(datapath_FIR_mult_210_n22) );
  FA_X1 datapath_FIR_mult_210_U17 ( .A(datapath_FIR_mult_210_n27), .B(
        datapath_FIR_mult_210_n24), .CI(datapath_FIR_mult_210_n22), .CO(
        datapath_FIR_mult_210_n19), .S(datapath_FIR_mult_210_n20) );
  FA_X1 datapath_FIR_mult_210_U16 ( .A(datapath_FIR_mult_210_n87), .B(
        datapath_FIR_mult_210_n81), .CI(datapath_FIR_mult_210_n75), .CO(
        datapath_FIR_mult_210_n17), .S(datapath_FIR_mult_210_n18) );
  FA_X1 datapath_FIR_mult_210_U15 ( .A(datapath_FIR_mult_210_n18), .B(
        datapath_FIR_mult_210_n23), .CI(datapath_FIR_mult_210_n21), .CO(
        datapath_FIR_mult_210_n15), .S(datapath_FIR_mult_210_n16) );
  FA_X1 datapath_FIR_mult_210_U14 ( .A(datapath_FIR_mult_210_n74), .B(
        datapath_FIR_mult_210_n80), .CI(datapath_FIR_mult_210_n17), .CO(
        datapath_FIR_mult_210_n13), .S(datapath_FIR_mult_210_n14) );
  XOR2_X1 datapath_FIR_add_7_root_add_0_root_add_245_U4 ( .A(
        datapath_FIR_add_7_root_add_0_root_add_245_n2), .B(
        datapath_FIR_add_7_root_add_0_root_add_245_n1), .Z(datapath_FIR_S0_0_)
         );
  AND2_X1 datapath_FIR_add_7_root_add_0_root_add_245_U3 ( .A1(
        datapath_FIR_M5_6_), .A2(datapath_FIR_M8_6_), .ZN(
        datapath_FIR_add_7_root_add_0_root_add_245_n3) );
  CLKBUF_X1 datapath_FIR_add_7_root_add_0_root_add_245_U2 ( .A(
        datapath_FIR_M5_6_), .Z(datapath_FIR_add_7_root_add_0_root_add_245_n2)
         );
  CLKBUF_X1 datapath_FIR_add_7_root_add_0_root_add_245_U1 ( .A(
        datapath_FIR_M8_6_), .Z(datapath_FIR_add_7_root_add_0_root_add_245_n1)
         );
  FA_X1 datapath_FIR_add_7_root_add_0_root_add_245_U1_1 ( .A(
        datapath_FIR_M5_7_), .B(datapath_FIR_add_7_root_add_0_root_add_245_n3), 
        .CI(datapath_FIR_M8_7_), .CO(
        datapath_FIR_add_7_root_add_0_root_add_245_carry[2]), .S(
        datapath_FIR_S0_1_) );
  FA_X1 datapath_FIR_add_7_root_add_0_root_add_245_U1_2 ( .A(
        datapath_FIR_M5_8_), .B(datapath_FIR_M8_8_), .CI(
        datapath_FIR_add_7_root_add_0_root_add_245_carry[2]), .CO(
        datapath_FIR_add_7_root_add_0_root_add_245_carry[3]), .S(
        datapath_FIR_S0_2_) );
  FA_X1 datapath_FIR_add_7_root_add_0_root_add_245_U1_3 ( .A(
        datapath_FIR_M5_9_), .B(datapath_FIR_M8_9_), .CI(
        datapath_FIR_add_7_root_add_0_root_add_245_carry[3]), .CO(
        datapath_FIR_add_7_root_add_0_root_add_245_carry[4]), .S(
        datapath_FIR_S0_3_) );
  FA_X1 datapath_FIR_add_7_root_add_0_root_add_245_U1_4 ( .A(
        datapath_FIR_M8_10_), .B(datapath_FIR_M5_10_), .CI(
        datapath_FIR_add_7_root_add_0_root_add_245_carry[4]), .CO(
        datapath_FIR_add_7_root_add_0_root_add_245_carry[5]), .S(
        datapath_FIR_S0_4_) );
  FA_X1 datapath_FIR_add_7_root_add_0_root_add_245_U1_5 ( .A(
        datapath_FIR_M8_11_), .B(datapath_FIR_M5_11_), .CI(
        datapath_FIR_add_7_root_add_0_root_add_245_carry[5]), .CO(
        datapath_FIR_add_7_root_add_0_root_add_245_carry[6]), .S(
        datapath_FIR_S0_5_) );
  FA_X1 datapath_FIR_add_7_root_add_0_root_add_245_U1_6 ( .A(
        datapath_FIR_M5_12_), .B(datapath_FIR_M8_12_), .CI(
        datapath_FIR_add_7_root_add_0_root_add_245_carry[6]), .S(
        datapath_FIR_S0_6_) );
  NOR2_X1 datapath_FIR_mult_207_U182 ( .A1(datapath_FIR_mult_207_n175), .A2(
        datapath_FIR_mult_207_n172), .ZN(datapath_FIR_mult_207_n100) );
  NAND2_X1 datapath_FIR_mult_207_U181 ( .A1(datapath_FIR_x2[2]), .A2(
        datapath_FIR_bq2[6]), .ZN(datapath_FIR_mult_207_n101) );
  NOR2_X1 datapath_FIR_mult_207_U180 ( .A1(datapath_FIR_mult_207_n164), .A2(
        datapath_FIR_mult_207_n176), .ZN(datapath_FIR_mult_207_n102) );
  NOR2_X1 datapath_FIR_mult_207_U179 ( .A1(datapath_FIR_mult_207_n165), .A2(
        datapath_FIR_mult_207_n176), .ZN(datapath_FIR_mult_207_n103) );
  NOR2_X1 datapath_FIR_mult_207_U178 ( .A1(datapath_FIR_mult_207_n168), .A2(
        datapath_FIR_mult_207_n176), .ZN(datapath_FIR_mult_207_n104) );
  NOR2_X1 datapath_FIR_mult_207_U177 ( .A1(datapath_FIR_mult_207_n169), .A2(
        datapath_FIR_mult_207_n176), .ZN(datapath_FIR_mult_207_n105) );
  NOR2_X1 datapath_FIR_mult_207_U176 ( .A1(datapath_FIR_mult_207_n171), .A2(
        datapath_FIR_mult_207_n176), .ZN(datapath_FIR_mult_207_n106) );
  NAND2_X1 datapath_FIR_mult_207_U175 ( .A1(datapath_FIR_x2[1]), .A2(
        datapath_FIR_bq2[6]), .ZN(datapath_FIR_mult_207_n108) );
  NOR2_X1 datapath_FIR_mult_207_U174 ( .A1(datapath_FIR_mult_207_n164), .A2(
        datapath_FIR_mult_207_n177), .ZN(datapath_FIR_mult_207_n109) );
  NOR2_X1 datapath_FIR_mult_207_U173 ( .A1(datapath_FIR_mult_207_n165), .A2(
        datapath_FIR_mult_207_n177), .ZN(datapath_FIR_mult_207_n110) );
  NOR2_X1 datapath_FIR_mult_207_U172 ( .A1(datapath_FIR_mult_207_n168), .A2(
        datapath_FIR_mult_207_n177), .ZN(datapath_FIR_mult_207_n111) );
  NOR2_X1 datapath_FIR_mult_207_U171 ( .A1(datapath_FIR_mult_207_n169), .A2(
        datapath_FIR_mult_207_n177), .ZN(datapath_FIR_mult_207_n112) );
  NOR2_X1 datapath_FIR_mult_207_U170 ( .A1(datapath_FIR_mult_207_n171), .A2(
        datapath_FIR_mult_207_n177), .ZN(datapath_FIR_mult_207_n113) );
  NAND2_X1 datapath_FIR_mult_207_U169 ( .A1(datapath_FIR_x2[0]), .A2(
        datapath_FIR_bq2[6]), .ZN(datapath_FIR_mult_207_n115) );
  NOR2_X1 datapath_FIR_mult_207_U168 ( .A1(datapath_FIR_mult_207_n164), .A2(
        datapath_FIR_mult_207_n178), .ZN(datapath_FIR_mult_207_n116) );
  NOR2_X1 datapath_FIR_mult_207_U167 ( .A1(datapath_FIR_mult_207_n165), .A2(
        datapath_FIR_mult_207_n178), .ZN(datapath_FIR_mult_207_n117) );
  NOR2_X1 datapath_FIR_mult_207_U166 ( .A1(datapath_FIR_mult_207_n168), .A2(
        datapath_FIR_mult_207_n178), .ZN(datapath_FIR_mult_207_n118) );
  NOR2_X1 datapath_FIR_mult_207_U165 ( .A1(datapath_FIR_mult_207_n169), .A2(
        datapath_FIR_mult_207_n178), .ZN(datapath_FIR_mult_207_n119) );
  NAND2_X1 datapath_FIR_mult_207_U164 ( .A1(datapath_FIR_bq2[4]), .A2(
        datapath_FIR_x2[3]), .ZN(datapath_FIR_mult_207_n187) );
  NAND2_X1 datapath_FIR_mult_207_U163 ( .A1(datapath_FIR_x2[5]), .A2(
        datapath_FIR_bq2[2]), .ZN(datapath_FIR_mult_207_n186) );
  NAND2_X1 datapath_FIR_mult_207_U162 ( .A1(datapath_FIR_mult_207_n187), .A2(
        datapath_FIR_mult_207_n186), .ZN(datapath_FIR_mult_207_n41) );
  XNOR2_X1 datapath_FIR_mult_207_U161 ( .A(datapath_FIR_mult_207_n186), .B(
        datapath_FIR_mult_207_n187), .ZN(datapath_FIR_mult_207_n42) );
  NAND2_X1 datapath_FIR_mult_207_U160 ( .A1(datapath_FIR_bq2[5]), .A2(
        datapath_FIR_x2[6]), .ZN(datapath_FIR_mult_207_n74) );
  NAND2_X1 datapath_FIR_mult_207_U159 ( .A1(datapath_FIR_bq2[4]), .A2(
        datapath_FIR_x2[6]), .ZN(datapath_FIR_mult_207_n75) );
  NAND2_X1 datapath_FIR_mult_207_U158 ( .A1(datapath_FIR_bq2[3]), .A2(
        datapath_FIR_x2[6]), .ZN(datapath_FIR_mult_207_n76) );
  NAND2_X1 datapath_FIR_mult_207_U157 ( .A1(datapath_FIR_bq2[2]), .A2(
        datapath_FIR_x2[6]), .ZN(datapath_FIR_mult_207_n77) );
  NAND2_X1 datapath_FIR_mult_207_U156 ( .A1(datapath_FIR_bq2[1]), .A2(
        datapath_FIR_x2[6]), .ZN(datapath_FIR_mult_207_n78) );
  NAND2_X1 datapath_FIR_mult_207_U155 ( .A1(datapath_FIR_bq2[0]), .A2(
        datapath_FIR_x2[6]), .ZN(datapath_FIR_mult_207_n79) );
  NOR4_X1 datapath_FIR_mult_207_U154 ( .A1(datapath_FIR_mult_207_n177), .A2(
        datapath_FIR_mult_207_n178), .A3(datapath_FIR_mult_207_n172), .A4(
        datapath_FIR_mult_207_n171), .ZN(datapath_FIR_mult_207_n184) );
  NOR2_X1 datapath_FIR_mult_207_U153 ( .A1(datapath_FIR_mult_207_n176), .A2(
        datapath_FIR_mult_207_n172), .ZN(datapath_FIR_mult_207_n185) );
  AOI222_X1 datapath_FIR_mult_207_U152 ( .A1(datapath_FIR_mult_207_n72), .A2(
        datapath_FIR_mult_207_n184), .B1(datapath_FIR_mult_207_n185), .B2(
        datapath_FIR_mult_207_n72), .C1(datapath_FIR_mult_207_n185), .C2(
        datapath_FIR_mult_207_n184), .ZN(datapath_FIR_mult_207_n183) );
  OAI222_X1 datapath_FIR_mult_207_U151 ( .A1(datapath_FIR_mult_207_n183), .A2(
        datapath_FIR_mult_207_n167), .B1(datapath_FIR_mult_207_n167), .B2(
        datapath_FIR_mult_207_n170), .C1(datapath_FIR_mult_207_n183), .C2(
        datapath_FIR_mult_207_n170), .ZN(datapath_FIR_mult_207_n182) );
  OAI222_X1 datapath_FIR_mult_207_U150 ( .A1(datapath_FIR_mult_207_n181), .A2(
        datapath_FIR_mult_207_n163), .B1(datapath_FIR_mult_207_n181), .B2(
        datapath_FIR_mult_207_n166), .C1(datapath_FIR_mult_207_n166), .C2(
        datapath_FIR_mult_207_n163), .ZN(datapath_FIR_mult_207_n8) );
  NAND2_X1 datapath_FIR_mult_207_U149 ( .A1(datapath_FIR_x2[5]), .A2(
        datapath_FIR_bq2[6]), .ZN(datapath_FIR_mult_207_n80) );
  NOR2_X1 datapath_FIR_mult_207_U148 ( .A1(datapath_FIR_mult_207_n164), .A2(
        datapath_FIR_mult_207_n173), .ZN(datapath_FIR_mult_207_n81) );
  NOR2_X1 datapath_FIR_mult_207_U147 ( .A1(datapath_FIR_mult_207_n165), .A2(
        datapath_FIR_mult_207_n173), .ZN(datapath_FIR_mult_207_n82) );
  NOR2_X1 datapath_FIR_mult_207_U146 ( .A1(datapath_FIR_mult_207_n168), .A2(
        datapath_FIR_mult_207_n173), .ZN(datapath_FIR_mult_207_n83) );
  NOR2_X1 datapath_FIR_mult_207_U145 ( .A1(datapath_FIR_mult_207_n171), .A2(
        datapath_FIR_mult_207_n173), .ZN(datapath_FIR_mult_207_n85) );
  NOR2_X1 datapath_FIR_mult_207_U144 ( .A1(datapath_FIR_mult_207_n172), .A2(
        datapath_FIR_mult_207_n173), .ZN(datapath_FIR_mult_207_n86) );
  NAND2_X1 datapath_FIR_mult_207_U143 ( .A1(datapath_FIR_x2[4]), .A2(
        datapath_FIR_bq2[6]), .ZN(datapath_FIR_mult_207_n87) );
  NOR2_X1 datapath_FIR_mult_207_U142 ( .A1(datapath_FIR_mult_207_n164), .A2(
        datapath_FIR_mult_207_n174), .ZN(datapath_FIR_mult_207_n88) );
  NOR2_X1 datapath_FIR_mult_207_U141 ( .A1(datapath_FIR_mult_207_n174), .A2(
        datapath_FIR_mult_207_n165), .ZN(datapath_FIR_mult_207_n89) );
  NOR2_X1 datapath_FIR_mult_207_U140 ( .A1(datapath_FIR_mult_207_n168), .A2(
        datapath_FIR_mult_207_n174), .ZN(datapath_FIR_mult_207_n90) );
  NOR2_X1 datapath_FIR_mult_207_U139 ( .A1(datapath_FIR_mult_207_n169), .A2(
        datapath_FIR_mult_207_n174), .ZN(datapath_FIR_mult_207_n91) );
  NOR2_X1 datapath_FIR_mult_207_U138 ( .A1(datapath_FIR_mult_207_n171), .A2(
        datapath_FIR_mult_207_n174), .ZN(datapath_FIR_mult_207_n92) );
  NOR2_X1 datapath_FIR_mult_207_U137 ( .A1(datapath_FIR_mult_207_n174), .A2(
        datapath_FIR_mult_207_n172), .ZN(datapath_FIR_mult_207_n93) );
  NAND2_X1 datapath_FIR_mult_207_U136 ( .A1(datapath_FIR_x2[3]), .A2(
        datapath_FIR_bq2[6]), .ZN(datapath_FIR_mult_207_n94) );
  NOR2_X1 datapath_FIR_mult_207_U135 ( .A1(datapath_FIR_mult_207_n175), .A2(
        datapath_FIR_mult_207_n164), .ZN(datapath_FIR_mult_207_n95) );
  NOR2_X1 datapath_FIR_mult_207_U134 ( .A1(datapath_FIR_mult_207_n175), .A2(
        datapath_FIR_mult_207_n168), .ZN(datapath_FIR_mult_207_n97) );
  NOR2_X1 datapath_FIR_mult_207_U133 ( .A1(datapath_FIR_mult_207_n175), .A2(
        datapath_FIR_mult_207_n169), .ZN(datapath_FIR_mult_207_n98) );
  NOR2_X1 datapath_FIR_mult_207_U132 ( .A1(datapath_FIR_mult_207_n175), .A2(
        datapath_FIR_mult_207_n171), .ZN(datapath_FIR_mult_207_n99) );
  NAND2_X1 datapath_FIR_mult_207_U131 ( .A1(datapath_FIR_bq2[6]), .A2(
        datapath_FIR_x2[6]), .ZN(datapath_FIR_mult_207_n179) );
  XNOR2_X1 datapath_FIR_mult_207_U130 ( .A(datapath_FIR_mult_207_n2), .B(
        datapath_FIR_mult_207_n13), .ZN(datapath_FIR_mult_207_n180) );
  XOR2_X1 datapath_FIR_mult_207_U129 ( .A(datapath_FIR_mult_207_n179), .B(
        datapath_FIR_mult_207_n180), .Z(datapath_FIR_M2_12_) );
  INV_X1 datapath_FIR_mult_207_U128 ( .A(datapath_FIR_bq2[0]), .ZN(
        datapath_FIR_mult_207_n172) );
  INV_X1 datapath_FIR_mult_207_U127 ( .A(datapath_FIR_x2[0]), .ZN(
        datapath_FIR_mult_207_n178) );
  INV_X1 datapath_FIR_mult_207_U126 ( .A(datapath_FIR_x2[5]), .ZN(
        datapath_FIR_mult_207_n173) );
  INV_X1 datapath_FIR_mult_207_U125 ( .A(datapath_FIR_bq2[2]), .ZN(
        datapath_FIR_mult_207_n169) );
  INV_X1 datapath_FIR_mult_207_U124 ( .A(datapath_FIR_bq2[4]), .ZN(
        datapath_FIR_mult_207_n165) );
  INV_X1 datapath_FIR_mult_207_U123 ( .A(datapath_FIR_x2[3]), .ZN(
        datapath_FIR_mult_207_n175) );
  INV_X1 datapath_FIR_mult_207_U122 ( .A(datapath_FIR_x2[2]), .ZN(
        datapath_FIR_mult_207_n176) );
  INV_X1 datapath_FIR_mult_207_U121 ( .A(datapath_FIR_x2[1]), .ZN(
        datapath_FIR_mult_207_n177) );
  INV_X1 datapath_FIR_mult_207_U120 ( .A(datapath_FIR_x2[4]), .ZN(
        datapath_FIR_mult_207_n174) );
  INV_X1 datapath_FIR_mult_207_U119 ( .A(datapath_FIR_bq2[1]), .ZN(
        datapath_FIR_mult_207_n171) );
  INV_X1 datapath_FIR_mult_207_U118 ( .A(datapath_FIR_bq2[5]), .ZN(
        datapath_FIR_mult_207_n164) );
  INV_X1 datapath_FIR_mult_207_U117 ( .A(datapath_FIR_bq2[3]), .ZN(
        datapath_FIR_mult_207_n168) );
  INV_X1 datapath_FIR_mult_207_U116 ( .A(datapath_FIR_mult_207_n68), .ZN(
        datapath_FIR_mult_207_n167) );
  INV_X1 datapath_FIR_mult_207_U115 ( .A(datapath_FIR_mult_207_n54), .ZN(
        datapath_FIR_mult_207_n163) );
  INV_X1 datapath_FIR_mult_207_U114 ( .A(datapath_FIR_mult_207_n61), .ZN(
        datapath_FIR_mult_207_n166) );
  INV_X1 datapath_FIR_mult_207_U113 ( .A(datapath_FIR_mult_207_n70), .ZN(
        datapath_FIR_mult_207_n170) );
  AND3_X1 datapath_FIR_mult_207_U112 ( .A1(datapath_FIR_mult_207_n160), .A2(
        datapath_FIR_mult_207_n161), .A3(datapath_FIR_mult_207_n162), .ZN(
        datapath_FIR_mult_207_n181) );
  NAND2_X1 datapath_FIR_mult_207_U111 ( .A1(datapath_FIR_mult_207_n64), .A2(
        datapath_FIR_mult_207_n62), .ZN(datapath_FIR_mult_207_n162) );
  NAND2_X1 datapath_FIR_mult_207_U110 ( .A1(datapath_FIR_mult_207_n182), .A2(
        datapath_FIR_mult_207_n64), .ZN(datapath_FIR_mult_207_n161) );
  NAND2_X1 datapath_FIR_mult_207_U109 ( .A1(datapath_FIR_mult_207_n182), .A2(
        datapath_FIR_mult_207_n62), .ZN(datapath_FIR_mult_207_n160) );
  HA_X1 datapath_FIR_mult_207_U44 ( .A(datapath_FIR_mult_207_n113), .B(
        datapath_FIR_mult_207_n119), .CO(datapath_FIR_mult_207_n71), .S(
        datapath_FIR_mult_207_n72) );
  HA_X1 datapath_FIR_mult_207_U43 ( .A(datapath_FIR_mult_207_n100), .B(
        datapath_FIR_mult_207_n106), .CO(datapath_FIR_mult_207_n69), .S(
        datapath_FIR_mult_207_n70) );
  FA_X1 datapath_FIR_mult_207_U42 ( .A(datapath_FIR_mult_207_n112), .B(
        datapath_FIR_mult_207_n118), .CI(datapath_FIR_mult_207_n71), .CO(
        datapath_FIR_mult_207_n67), .S(datapath_FIR_mult_207_n68) );
  HA_X1 datapath_FIR_mult_207_U41 ( .A(datapath_FIR_mult_207_n93), .B(
        datapath_FIR_mult_207_n99), .CO(datapath_FIR_mult_207_n65), .S(
        datapath_FIR_mult_207_n66) );
  FA_X1 datapath_FIR_mult_207_U40 ( .A(datapath_FIR_mult_207_n105), .B(
        datapath_FIR_mult_207_n117), .CI(datapath_FIR_mult_207_n111), .CO(
        datapath_FIR_mult_207_n63), .S(datapath_FIR_mult_207_n64) );
  FA_X1 datapath_FIR_mult_207_U39 ( .A(datapath_FIR_mult_207_n66), .B(
        datapath_FIR_mult_207_n69), .CI(datapath_FIR_mult_207_n67), .CO(
        datapath_FIR_mult_207_n61), .S(datapath_FIR_mult_207_n62) );
  HA_X1 datapath_FIR_mult_207_U38 ( .A(datapath_FIR_mult_207_n86), .B(
        datapath_FIR_mult_207_n92), .CO(datapath_FIR_mult_207_n59), .S(
        datapath_FIR_mult_207_n60) );
  FA_X1 datapath_FIR_mult_207_U37 ( .A(datapath_FIR_mult_207_n98), .B(
        datapath_FIR_mult_207_n116), .CI(datapath_FIR_mult_207_n104), .CO(
        datapath_FIR_mult_207_n57), .S(datapath_FIR_mult_207_n58) );
  FA_X1 datapath_FIR_mult_207_U36 ( .A(datapath_FIR_mult_207_n65), .B(
        datapath_FIR_mult_207_n110), .CI(datapath_FIR_mult_207_n60), .CO(
        datapath_FIR_mult_207_n55), .S(datapath_FIR_mult_207_n56) );
  FA_X1 datapath_FIR_mult_207_U35 ( .A(datapath_FIR_mult_207_n58), .B(
        datapath_FIR_mult_207_n63), .CI(datapath_FIR_mult_207_n56), .CO(
        datapath_FIR_mult_207_n53), .S(datapath_FIR_mult_207_n54) );
  HA_X1 datapath_FIR_mult_207_U34 ( .A(datapath_FIR_mult_207_n97), .B(
        datapath_FIR_mult_207_n91), .CO(datapath_FIR_mult_207_n51), .S(
        datapath_FIR_mult_207_n52) );
  FA_X1 datapath_FIR_mult_207_U33 ( .A(datapath_FIR_mult_207_n85), .B(
        datapath_FIR_mult_207_n103), .CI(datapath_FIR_mult_207_n109), .CO(
        datapath_FIR_mult_207_n49), .S(datapath_FIR_mult_207_n50) );
  FA_X1 datapath_FIR_mult_207_U32 ( .A(datapath_FIR_mult_207_n79), .B(
        datapath_FIR_mult_207_n115), .CI(datapath_FIR_mult_207_n59), .CO(
        datapath_FIR_mult_207_n47), .S(datapath_FIR_mult_207_n48) );
  FA_X1 datapath_FIR_mult_207_U31 ( .A(datapath_FIR_mult_207_n57), .B(
        datapath_FIR_mult_207_n52), .CI(datapath_FIR_mult_207_n50), .CO(
        datapath_FIR_mult_207_n45), .S(datapath_FIR_mult_207_n46) );
  FA_X1 datapath_FIR_mult_207_U30 ( .A(datapath_FIR_mult_207_n48), .B(
        datapath_FIR_mult_207_n55), .CI(datapath_FIR_mult_207_n46), .CO(
        datapath_FIR_mult_207_n43), .S(datapath_FIR_mult_207_n44) );
  FA_X1 datapath_FIR_mult_207_U27 ( .A(datapath_FIR_mult_207_n102), .B(
        datapath_FIR_mult_207_n90), .CI(datapath_FIR_mult_207_n108), .CO(
        datapath_FIR_mult_207_n39), .S(datapath_FIR_mult_207_n40) );
  FA_X1 datapath_FIR_mult_207_U26 ( .A(datapath_FIR_mult_207_n51), .B(
        datapath_FIR_mult_207_n78), .CI(datapath_FIR_mult_207_n42), .CO(
        datapath_FIR_mult_207_n37), .S(datapath_FIR_mult_207_n38) );
  FA_X1 datapath_FIR_mult_207_U25 ( .A(datapath_FIR_mult_207_n47), .B(
        datapath_FIR_mult_207_n49), .CI(datapath_FIR_mult_207_n40), .CO(
        datapath_FIR_mult_207_n35), .S(datapath_FIR_mult_207_n36) );
  FA_X1 datapath_FIR_mult_207_U24 ( .A(datapath_FIR_mult_207_n45), .B(
        datapath_FIR_mult_207_n38), .CI(datapath_FIR_mult_207_n36), .CO(
        datapath_FIR_mult_207_n33), .S(datapath_FIR_mult_207_n34) );
  FA_X1 datapath_FIR_mult_207_U23 ( .A(datapath_FIR_mult_207_n83), .B(
        datapath_FIR_mult_207_n89), .CI(datapath_FIR_mult_207_n95), .CO(
        datapath_FIR_mult_207_n31), .S(datapath_FIR_mult_207_n32) );
  FA_X1 datapath_FIR_mult_207_U22 ( .A(datapath_FIR_mult_207_n77), .B(
        datapath_FIR_mult_207_n101), .CI(datapath_FIR_mult_207_n41), .CO(
        datapath_FIR_mult_207_n29), .S(datapath_FIR_mult_207_n30) );
  FA_X1 datapath_FIR_mult_207_U21 ( .A(datapath_FIR_mult_207_n32), .B(
        datapath_FIR_mult_207_n39), .CI(datapath_FIR_mult_207_n37), .CO(
        datapath_FIR_mult_207_n27), .S(datapath_FIR_mult_207_n28) );
  FA_X1 datapath_FIR_mult_207_U20 ( .A(datapath_FIR_mult_207_n35), .B(
        datapath_FIR_mult_207_n30), .CI(datapath_FIR_mult_207_n28), .CO(
        datapath_FIR_mult_207_n25), .S(datapath_FIR_mult_207_n26) );
  FA_X1 datapath_FIR_mult_207_U19 ( .A(datapath_FIR_mult_207_n82), .B(
        datapath_FIR_mult_207_n88), .CI(datapath_FIR_mult_207_n94), .CO(
        datapath_FIR_mult_207_n23), .S(datapath_FIR_mult_207_n24) );
  FA_X1 datapath_FIR_mult_207_U18 ( .A(datapath_FIR_mult_207_n31), .B(
        datapath_FIR_mult_207_n76), .CI(datapath_FIR_mult_207_n29), .CO(
        datapath_FIR_mult_207_n21), .S(datapath_FIR_mult_207_n22) );
  FA_X1 datapath_FIR_mult_207_U17 ( .A(datapath_FIR_mult_207_n27), .B(
        datapath_FIR_mult_207_n24), .CI(datapath_FIR_mult_207_n22), .CO(
        datapath_FIR_mult_207_n19), .S(datapath_FIR_mult_207_n20) );
  FA_X1 datapath_FIR_mult_207_U16 ( .A(datapath_FIR_mult_207_n87), .B(
        datapath_FIR_mult_207_n81), .CI(datapath_FIR_mult_207_n75), .CO(
        datapath_FIR_mult_207_n17), .S(datapath_FIR_mult_207_n18) );
  FA_X1 datapath_FIR_mult_207_U15 ( .A(datapath_FIR_mult_207_n18), .B(
        datapath_FIR_mult_207_n23), .CI(datapath_FIR_mult_207_n21), .CO(
        datapath_FIR_mult_207_n15), .S(datapath_FIR_mult_207_n16) );
  FA_X1 datapath_FIR_mult_207_U14 ( .A(datapath_FIR_mult_207_n74), .B(
        datapath_FIR_mult_207_n80), .CI(datapath_FIR_mult_207_n17), .CO(
        datapath_FIR_mult_207_n13), .S(datapath_FIR_mult_207_n14) );
  FA_X1 datapath_FIR_mult_207_U8 ( .A(datapath_FIR_mult_207_n44), .B(
        datapath_FIR_mult_207_n53), .CI(datapath_FIR_mult_207_n8), .CO(
        datapath_FIR_mult_207_n7), .S(datapath_FIR_M2_6_) );
  FA_X1 datapath_FIR_mult_207_U7 ( .A(datapath_FIR_mult_207_n34), .B(
        datapath_FIR_mult_207_n43), .CI(datapath_FIR_mult_207_n7), .CO(
        datapath_FIR_mult_207_n6), .S(datapath_FIR_M2_7_) );
  FA_X1 datapath_FIR_mult_207_U6 ( .A(datapath_FIR_mult_207_n26), .B(
        datapath_FIR_mult_207_n33), .CI(datapath_FIR_mult_207_n6), .CO(
        datapath_FIR_mult_207_n5), .S(datapath_FIR_M2_8_) );
  FA_X1 datapath_FIR_mult_207_U5 ( .A(datapath_FIR_mult_207_n20), .B(
        datapath_FIR_mult_207_n25), .CI(datapath_FIR_mult_207_n5), .CO(
        datapath_FIR_mult_207_n4), .S(datapath_FIR_M2_9_) );
  FA_X1 datapath_FIR_mult_207_U4 ( .A(datapath_FIR_mult_207_n16), .B(
        datapath_FIR_mult_207_n19), .CI(datapath_FIR_mult_207_n4), .CO(
        datapath_FIR_mult_207_n3), .S(datapath_FIR_M2_10_) );
  FA_X1 datapath_FIR_mult_207_U3 ( .A(datapath_FIR_mult_207_n15), .B(
        datapath_FIR_mult_207_n14), .CI(datapath_FIR_mult_207_n3), .CO(
        datapath_FIR_mult_207_n2), .S(datapath_FIR_M2_11_) );
  NOR2_X1 datapath_FIR_mult_208_U242 ( .A1(datapath_FIR_mult_208_n221), .A2(
        datapath_FIR_mult_208_n218), .ZN(datapath_FIR_mult_208_n100) );
  NAND2_X1 datapath_FIR_mult_208_U241 ( .A1(datapath_FIR_x3[2]), .A2(
        datapath_FIR_bq3[6]), .ZN(datapath_FIR_mult_208_n101) );
  NOR2_X1 datapath_FIR_mult_208_U240 ( .A1(datapath_FIR_mult_208_n214), .A2(
        datapath_FIR_mult_208_n222), .ZN(datapath_FIR_mult_208_n104) );
  NOR2_X1 datapath_FIR_mult_208_U239 ( .A1(datapath_FIR_mult_208_n215), .A2(
        datapath_FIR_mult_208_n222), .ZN(datapath_FIR_mult_208_n105) );
  NOR2_X1 datapath_FIR_mult_208_U238 ( .A1(datapath_FIR_mult_208_n217), .A2(
        datapath_FIR_mult_208_n222), .ZN(datapath_FIR_mult_208_n106) );
  NAND2_X1 datapath_FIR_mult_208_U237 ( .A1(datapath_FIR_mult_208_n161), .A2(
        datapath_FIR_bq3[6]), .ZN(datapath_FIR_mult_208_n108) );
  NOR2_X1 datapath_FIR_mult_208_U236 ( .A1(datapath_FIR_mult_208_n163), .A2(
        datapath_FIR_mult_208_n223), .ZN(datapath_FIR_mult_208_n109) );
  NOR2_X1 datapath_FIR_mult_208_U235 ( .A1(datapath_FIR_mult_208_n211), .A2(
        datapath_FIR_mult_208_n180), .ZN(datapath_FIR_mult_208_n110) );
  NOR2_X1 datapath_FIR_mult_208_U234 ( .A1(datapath_FIR_mult_208_n214), .A2(
        datapath_FIR_mult_208_n180), .ZN(datapath_FIR_mult_208_n111) );
  NOR2_X1 datapath_FIR_mult_208_U233 ( .A1(datapath_FIR_mult_208_n215), .A2(
        datapath_FIR_mult_208_n223), .ZN(datapath_FIR_mult_208_n112) );
  NAND2_X1 datapath_FIR_mult_208_U232 ( .A1(datapath_FIR_mult_208_n196), .A2(
        datapath_FIR_bq3[6]), .ZN(datapath_FIR_mult_208_n115) );
  NOR2_X1 datapath_FIR_mult_208_U231 ( .A1(datapath_FIR_mult_208_n163), .A2(
        datapath_FIR_mult_208_n224), .ZN(datapath_FIR_mult_208_n116) );
  NOR2_X1 datapath_FIR_mult_208_U230 ( .A1(datapath_FIR_mult_208_n211), .A2(
        datapath_FIR_mult_208_n224), .ZN(datapath_FIR_mult_208_n117) );
  NOR2_X1 datapath_FIR_mult_208_U229 ( .A1(datapath_FIR_mult_208_n214), .A2(
        datapath_FIR_mult_208_n224), .ZN(datapath_FIR_mult_208_n118) );
  NAND2_X1 datapath_FIR_mult_208_U228 ( .A1(datapath_FIR_bq3[4]), .A2(
        datapath_FIR_x3[3]), .ZN(datapath_FIR_mult_208_n232) );
  NAND2_X1 datapath_FIR_mult_208_U227 ( .A1(datapath_FIR_x3[5]), .A2(
        datapath_FIR_bq3[2]), .ZN(datapath_FIR_mult_208_n231) );
  NAND2_X1 datapath_FIR_mult_208_U226 ( .A1(datapath_FIR_mult_208_n232), .A2(
        datapath_FIR_mult_208_n231), .ZN(datapath_FIR_mult_208_n41) );
  XNOR2_X1 datapath_FIR_mult_208_U225 ( .A(datapath_FIR_mult_208_n231), .B(
        datapath_FIR_mult_208_n232), .ZN(datapath_FIR_mult_208_n42) );
  NAND2_X1 datapath_FIR_mult_208_U224 ( .A1(datapath_FIR_bq3[5]), .A2(
        datapath_FIR_x3[6]), .ZN(datapath_FIR_mult_208_n74) );
  NAND2_X1 datapath_FIR_mult_208_U223 ( .A1(datapath_FIR_bq3[4]), .A2(
        datapath_FIR_x3[6]), .ZN(datapath_FIR_mult_208_n75) );
  NAND2_X1 datapath_FIR_mult_208_U222 ( .A1(datapath_FIR_bq3[3]), .A2(
        datapath_FIR_x3[6]), .ZN(datapath_FIR_mult_208_n76) );
  NAND2_X1 datapath_FIR_mult_208_U221 ( .A1(datapath_FIR_bq3[2]), .A2(
        datapath_FIR_x3[6]), .ZN(datapath_FIR_mult_208_n77) );
  NAND2_X1 datapath_FIR_mult_208_U220 ( .A1(datapath_FIR_bq3[1]), .A2(
        datapath_FIR_x3[6]), .ZN(datapath_FIR_mult_208_n78) );
  NAND2_X1 datapath_FIR_mult_208_U219 ( .A1(datapath_FIR_bq3[0]), .A2(
        datapath_FIR_x3[6]), .ZN(datapath_FIR_mult_208_n79) );
  NOR4_X1 datapath_FIR_mult_208_U218 ( .A1(datapath_FIR_mult_208_n180), .A2(
        datapath_FIR_mult_208_n224), .A3(datapath_FIR_mult_208_n218), .A4(
        datapath_FIR_mult_208_n217), .ZN(datapath_FIR_mult_208_n229) );
  NOR2_X1 datapath_FIR_mult_208_U217 ( .A1(datapath_FIR_mult_208_n222), .A2(
        datapath_FIR_mult_208_n218), .ZN(datapath_FIR_mult_208_n230) );
  AOI222_X1 datapath_FIR_mult_208_U216 ( .A1(datapath_FIR_mult_208_n72), .A2(
        datapath_FIR_mult_208_n229), .B1(datapath_FIR_mult_208_n230), .B2(
        datapath_FIR_mult_208_n72), .C1(datapath_FIR_mult_208_n230), .C2(
        datapath_FIR_mult_208_n229), .ZN(datapath_FIR_mult_208_n228) );
  OAI222_X1 datapath_FIR_mult_208_U215 ( .A1(datapath_FIR_mult_208_n228), .A2(
        datapath_FIR_mult_208_n213), .B1(datapath_FIR_mult_208_n213), .B2(
        datapath_FIR_mult_208_n216), .C1(datapath_FIR_mult_208_n228), .C2(
        datapath_FIR_mult_208_n216), .ZN(datapath_FIR_mult_208_n227) );
  NAND2_X1 datapath_FIR_mult_208_U214 ( .A1(datapath_FIR_x3[5]), .A2(
        datapath_FIR_bq3[6]), .ZN(datapath_FIR_mult_208_n80) );
  NOR2_X1 datapath_FIR_mult_208_U213 ( .A1(datapath_FIR_mult_208_n163), .A2(
        datapath_FIR_mult_208_n219), .ZN(datapath_FIR_mult_208_n81) );
  NOR2_X1 datapath_FIR_mult_208_U212 ( .A1(datapath_FIR_mult_208_n211), .A2(
        datapath_FIR_mult_208_n219), .ZN(datapath_FIR_mult_208_n82) );
  NOR2_X1 datapath_FIR_mult_208_U211 ( .A1(datapath_FIR_mult_208_n214), .A2(
        datapath_FIR_mult_208_n219), .ZN(datapath_FIR_mult_208_n83) );
  NAND2_X1 datapath_FIR_mult_208_U210 ( .A1(datapath_FIR_x3[4]), .A2(
        datapath_FIR_bq3[6]), .ZN(datapath_FIR_mult_208_n87) );
  NOR2_X1 datapath_FIR_mult_208_U209 ( .A1(datapath_FIR_mult_208_n163), .A2(
        datapath_FIR_mult_208_n173), .ZN(datapath_FIR_mult_208_n88) );
  NOR2_X1 datapath_FIR_mult_208_U208 ( .A1(datapath_FIR_mult_208_n173), .A2(
        datapath_FIR_mult_208_n211), .ZN(datapath_FIR_mult_208_n89) );
  NOR2_X1 datapath_FIR_mult_208_U207 ( .A1(datapath_FIR_mult_208_n214), .A2(
        datapath_FIR_mult_208_n220), .ZN(datapath_FIR_mult_208_n90) );
  NOR2_X1 datapath_FIR_mult_208_U206 ( .A1(datapath_FIR_mult_208_n215), .A2(
        datapath_FIR_mult_208_n173), .ZN(datapath_FIR_mult_208_n91) );
  NOR2_X1 datapath_FIR_mult_208_U205 ( .A1(datapath_FIR_mult_208_n220), .A2(
        datapath_FIR_mult_208_n218), .ZN(datapath_FIR_mult_208_n93) );
  NAND2_X1 datapath_FIR_mult_208_U204 ( .A1(datapath_FIR_x3[3]), .A2(
        datapath_FIR_bq3[6]), .ZN(datapath_FIR_mult_208_n94) );
  NOR2_X1 datapath_FIR_mult_208_U203 ( .A1(datapath_FIR_mult_208_n221), .A2(
        datapath_FIR_mult_208_n163), .ZN(datapath_FIR_mult_208_n95) );
  NOR2_X1 datapath_FIR_mult_208_U202 ( .A1(datapath_FIR_mult_208_n221), .A2(
        datapath_FIR_mult_208_n214), .ZN(datapath_FIR_mult_208_n97) );
  NOR2_X1 datapath_FIR_mult_208_U201 ( .A1(datapath_FIR_mult_208_n221), .A2(
        datapath_FIR_mult_208_n215), .ZN(datapath_FIR_mult_208_n98) );
  NOR2_X1 datapath_FIR_mult_208_U200 ( .A1(datapath_FIR_mult_208_n221), .A2(
        datapath_FIR_mult_208_n217), .ZN(datapath_FIR_mult_208_n99) );
  XNOR2_X1 datapath_FIR_mult_208_U199 ( .A(datapath_FIR_mult_208_n2), .B(
        datapath_FIR_mult_208_n13), .ZN(datapath_FIR_mult_208_n225) );
  INV_X1 datapath_FIR_mult_208_U198 ( .A(datapath_FIR_mult_208_n68), .ZN(
        datapath_FIR_mult_208_n213) );
  NAND2_X1 datapath_FIR_mult_208_U197 ( .A1(datapath_FIR_mult_208_n44), .A2(
        datapath_FIR_mult_208_n53), .ZN(datapath_FIR_mult_208_n210) );
  NAND2_X1 datapath_FIR_mult_208_U196 ( .A1(datapath_FIR_mult_208_n8), .A2(
        datapath_FIR_mult_208_n53), .ZN(datapath_FIR_mult_208_n209) );
  NAND2_X1 datapath_FIR_mult_208_U195 ( .A1(datapath_FIR_mult_208_n188), .A2(
        datapath_FIR_mult_208_n44), .ZN(datapath_FIR_mult_208_n208) );
  INV_X1 datapath_FIR_mult_208_U194 ( .A(datapath_FIR_x3[0]), .ZN(
        datapath_FIR_mult_208_n224) );
  AND2_X1 datapath_FIR_mult_208_U193 ( .A1(datapath_FIR_bq3[6]), .A2(
        datapath_FIR_x3[6]), .ZN(datapath_FIR_mult_208_n207) );
  XNOR2_X1 datapath_FIR_mult_208_U192 ( .A(datapath_FIR_mult_208_n207), .B(
        datapath_FIR_mult_208_n225), .ZN(datapath_FIR_M3_12_) );
  INV_X1 datapath_FIR_mult_208_U191 ( .A(datapath_FIR_x3[1]), .ZN(
        datapath_FIR_mult_208_n223) );
  INV_X1 datapath_FIR_mult_208_U190 ( .A(datapath_FIR_x3[5]), .ZN(
        datapath_FIR_mult_208_n219) );
  INV_X1 datapath_FIR_mult_208_U189 ( .A(datapath_FIR_bq3[2]), .ZN(
        datapath_FIR_mult_208_n215) );
  INV_X1 datapath_FIR_mult_208_U188 ( .A(datapath_FIR_bq3[1]), .ZN(
        datapath_FIR_mult_208_n217) );
  AND2_X1 datapath_FIR_mult_208_U187 ( .A1(datapath_FIR_bq3[1]), .A2(
        datapath_FIR_x3[1]), .ZN(datapath_FIR_mult_208_n113) );
  AND2_X1 datapath_FIR_mult_208_U186 ( .A1(datapath_FIR_bq3[2]), .A2(
        datapath_FIR_x3[0]), .ZN(datapath_FIR_mult_208_n119) );
  INV_X1 datapath_FIR_mult_208_U185 ( .A(datapath_FIR_x3[2]), .ZN(
        datapath_FIR_mult_208_n222) );
  XOR2_X1 datapath_FIR_mult_208_U184 ( .A(datapath_FIR_mult_208_n86), .B(
        datapath_FIR_mult_208_n92), .Z(datapath_FIR_mult_208_n60) );
  NAND3_X1 datapath_FIR_mult_208_U183 ( .A1(datapath_FIR_mult_208_n204), .A2(
        datapath_FIR_mult_208_n205), .A3(datapath_FIR_mult_208_n206), .ZN(
        datapath_FIR_mult_208_n53) );
  NAND2_X1 datapath_FIR_mult_208_U182 ( .A1(datapath_FIR_mult_208_n63), .A2(
        datapath_FIR_mult_208_n56), .ZN(datapath_FIR_mult_208_n206) );
  NAND2_X1 datapath_FIR_mult_208_U181 ( .A1(datapath_FIR_mult_208_n58), .A2(
        datapath_FIR_mult_208_n56), .ZN(datapath_FIR_mult_208_n205) );
  NAND2_X1 datapath_FIR_mult_208_U180 ( .A1(datapath_FIR_mult_208_n58), .A2(
        datapath_FIR_mult_208_n63), .ZN(datapath_FIR_mult_208_n204) );
  NAND3_X1 datapath_FIR_mult_208_U179 ( .A1(datapath_FIR_mult_208_n201), .A2(
        datapath_FIR_mult_208_n202), .A3(datapath_FIR_mult_208_n203), .ZN(
        datapath_FIR_mult_208_n55) );
  NAND2_X1 datapath_FIR_mult_208_U178 ( .A1(datapath_FIR_mult_208_n110), .A2(
        datapath_FIR_mult_208_n60), .ZN(datapath_FIR_mult_208_n203) );
  NAND2_X1 datapath_FIR_mult_208_U177 ( .A1(datapath_FIR_mult_208_n65), .A2(
        datapath_FIR_mult_208_n60), .ZN(datapath_FIR_mult_208_n202) );
  NAND2_X1 datapath_FIR_mult_208_U176 ( .A1(datapath_FIR_mult_208_n65), .A2(
        datapath_FIR_mult_208_n110), .ZN(datapath_FIR_mult_208_n201) );
  XOR2_X1 datapath_FIR_mult_208_U175 ( .A(datapath_FIR_mult_208_n58), .B(
        datapath_FIR_mult_208_n63), .Z(datapath_FIR_mult_208_n200) );
  XNOR2_X1 datapath_FIR_mult_208_U174 ( .A(datapath_FIR_mult_208_n200), .B(
        datapath_FIR_mult_208_n56), .ZN(datapath_FIR_mult_208_n199) );
  XNOR2_X1 datapath_FIR_mult_208_U173 ( .A(datapath_FIR_mult_208_n65), .B(
        datapath_FIR_mult_208_n110), .ZN(datapath_FIR_mult_208_n198) );
  XNOR2_X1 datapath_FIR_mult_208_U172 ( .A(datapath_FIR_mult_208_n198), .B(
        datapath_FIR_mult_208_n60), .ZN(datapath_FIR_mult_208_n56) );
  XNOR2_X1 datapath_FIR_mult_208_U171 ( .A(datapath_FIR_mult_208_n44), .B(
        datapath_FIR_mult_208_n53), .ZN(datapath_FIR_mult_208_n197) );
  XNOR2_X1 datapath_FIR_mult_208_U170 ( .A(datapath_FIR_mult_208_n197), .B(
        datapath_FIR_mult_208_n195), .ZN(datapath_FIR_M3_6_) );
  AND2_X1 datapath_FIR_mult_208_U169 ( .A1(datapath_FIR_bq3[1]), .A2(
        datapath_FIR_x3[5]), .ZN(datapath_FIR_mult_208_n85) );
  INV_X1 datapath_FIR_mult_208_U168 ( .A(datapath_FIR_x3[3]), .ZN(
        datapath_FIR_mult_208_n221) );
  INV_X1 datapath_FIR_mult_208_U167 ( .A(datapath_FIR_mult_208_n224), .ZN(
        datapath_FIR_mult_208_n196) );
  INV_X1 datapath_FIR_mult_208_U166 ( .A(datapath_FIR_bq3[0]), .ZN(
        datapath_FIR_mult_208_n218) );
  CLKBUF_X1 datapath_FIR_mult_208_U165 ( .A(datapath_FIR_mult_208_n188), .Z(
        datapath_FIR_mult_208_n195) );
  INV_X1 datapath_FIR_mult_208_U164 ( .A(datapath_FIR_bq3[4]), .ZN(
        datapath_FIR_mult_208_n211) );
  INV_X1 datapath_FIR_mult_208_U163 ( .A(datapath_FIR_mult_208_n70), .ZN(
        datapath_FIR_mult_208_n216) );
  INV_X1 datapath_FIR_mult_208_U162 ( .A(datapath_FIR_mult_208_n61), .ZN(
        datapath_FIR_mult_208_n212) );
  AND3_X1 datapath_FIR_mult_208_U161 ( .A1(datapath_FIR_mult_208_n192), .A2(
        datapath_FIR_mult_208_n193), .A3(datapath_FIR_mult_208_n194), .ZN(
        datapath_FIR_mult_208_n226) );
  NAND2_X1 datapath_FIR_mult_208_U160 ( .A1(datapath_FIR_mult_208_n62), .A2(
        datapath_FIR_mult_208_n64), .ZN(datapath_FIR_mult_208_n194) );
  NAND2_X1 datapath_FIR_mult_208_U159 ( .A1(datapath_FIR_mult_208_n227), .A2(
        datapath_FIR_mult_208_n64), .ZN(datapath_FIR_mult_208_n193) );
  NAND2_X1 datapath_FIR_mult_208_U158 ( .A1(datapath_FIR_mult_208_n227), .A2(
        datapath_FIR_mult_208_n62), .ZN(datapath_FIR_mult_208_n192) );
  NAND3_X1 datapath_FIR_mult_208_U157 ( .A1(datapath_FIR_mult_208_n189), .A2(
        datapath_FIR_mult_208_n190), .A3(datapath_FIR_mult_208_n191), .ZN(
        datapath_FIR_mult_208_n8) );
  OR2_X1 datapath_FIR_mult_208_U156 ( .A1(datapath_FIR_mult_208_n212), .A2(
        datapath_FIR_mult_208_n199), .ZN(datapath_FIR_mult_208_n191) );
  OR2_X1 datapath_FIR_mult_208_U155 ( .A1(datapath_FIR_mult_208_n226), .A2(
        datapath_FIR_mult_208_n212), .ZN(datapath_FIR_mult_208_n190) );
  OR2_X1 datapath_FIR_mult_208_U154 ( .A1(datapath_FIR_mult_208_n226), .A2(
        datapath_FIR_mult_208_n199), .ZN(datapath_FIR_mult_208_n189) );
  AND2_X1 datapath_FIR_mult_208_U153 ( .A1(datapath_FIR_bq3[4]), .A2(
        datapath_FIR_x3[2]), .ZN(datapath_FIR_mult_208_n103) );
  NAND3_X1 datapath_FIR_mult_208_U152 ( .A1(datapath_FIR_mult_208_n189), .A2(
        datapath_FIR_mult_208_n190), .A3(datapath_FIR_mult_208_n191), .ZN(
        datapath_FIR_mult_208_n188) );
  NAND3_X1 datapath_FIR_mult_208_U151 ( .A1(datapath_FIR_mult_208_n185), .A2(
        datapath_FIR_mult_208_n186), .A3(datapath_FIR_mult_208_n187), .ZN(
        datapath_FIR_mult_208_n5) );
  NAND2_X1 datapath_FIR_mult_208_U150 ( .A1(datapath_FIR_mult_208_n26), .A2(
        datapath_FIR_mult_208_n33), .ZN(datapath_FIR_mult_208_n187) );
  NAND2_X1 datapath_FIR_mult_208_U149 ( .A1(datapath_FIR_mult_208_n6), .A2(
        datapath_FIR_mult_208_n33), .ZN(datapath_FIR_mult_208_n186) );
  NAND2_X1 datapath_FIR_mult_208_U148 ( .A1(datapath_FIR_mult_208_n179), .A2(
        datapath_FIR_mult_208_n26), .ZN(datapath_FIR_mult_208_n185) );
  XOR2_X1 datapath_FIR_mult_208_U147 ( .A(datapath_FIR_mult_208_n179), .B(
        datapath_FIR_mult_208_n184), .Z(datapath_FIR_M3_8_) );
  XOR2_X1 datapath_FIR_mult_208_U146 ( .A(datapath_FIR_mult_208_n26), .B(
        datapath_FIR_mult_208_n33), .Z(datapath_FIR_mult_208_n184) );
  NAND3_X1 datapath_FIR_mult_208_U145 ( .A1(datapath_FIR_mult_208_n181), .A2(
        datapath_FIR_mult_208_n182), .A3(datapath_FIR_mult_208_n183), .ZN(
        datapath_FIR_mult_208_n6) );
  NAND2_X1 datapath_FIR_mult_208_U144 ( .A1(datapath_FIR_mult_208_n34), .A2(
        datapath_FIR_mult_208_n43), .ZN(datapath_FIR_mult_208_n183) );
  NAND2_X1 datapath_FIR_mult_208_U143 ( .A1(datapath_FIR_mult_208_n178), .A2(
        datapath_FIR_mult_208_n43), .ZN(datapath_FIR_mult_208_n182) );
  NAND2_X1 datapath_FIR_mult_208_U142 ( .A1(datapath_FIR_mult_208_n178), .A2(
        datapath_FIR_mult_208_n34), .ZN(datapath_FIR_mult_208_n181) );
  INV_X1 datapath_FIR_mult_208_U141 ( .A(datapath_FIR_x3[1]), .ZN(
        datapath_FIR_mult_208_n180) );
  NAND3_X1 datapath_FIR_mult_208_U140 ( .A1(datapath_FIR_mult_208_n181), .A2(
        datapath_FIR_mult_208_n182), .A3(datapath_FIR_mult_208_n183), .ZN(
        datapath_FIR_mult_208_n179) );
  INV_X1 datapath_FIR_mult_208_U139 ( .A(datapath_FIR_x3[4]), .ZN(
        datapath_FIR_mult_208_n220) );
  AND2_X1 datapath_FIR_mult_208_U138 ( .A1(datapath_FIR_bq3[1]), .A2(
        datapath_FIR_x3[4]), .ZN(datapath_FIR_mult_208_n92) );
  NAND3_X1 datapath_FIR_mult_208_U137 ( .A1(datapath_FIR_mult_208_n208), .A2(
        datapath_FIR_mult_208_n209), .A3(datapath_FIR_mult_208_n210), .ZN(
        datapath_FIR_mult_208_n178) );
  NAND3_X1 datapath_FIR_mult_208_U136 ( .A1(datapath_FIR_mult_208_n175), .A2(
        datapath_FIR_mult_208_n176), .A3(datapath_FIR_mult_208_n177), .ZN(
        datapath_FIR_mult_208_n2) );
  NAND2_X1 datapath_FIR_mult_208_U135 ( .A1(datapath_FIR_mult_208_n15), .A2(
        datapath_FIR_mult_208_n14), .ZN(datapath_FIR_mult_208_n177) );
  NAND2_X1 datapath_FIR_mult_208_U134 ( .A1(datapath_FIR_mult_208_n3), .A2(
        datapath_FIR_mult_208_n14), .ZN(datapath_FIR_mult_208_n176) );
  NAND2_X1 datapath_FIR_mult_208_U133 ( .A1(datapath_FIR_mult_208_n3), .A2(
        datapath_FIR_mult_208_n15), .ZN(datapath_FIR_mult_208_n175) );
  XOR2_X1 datapath_FIR_mult_208_U132 ( .A(datapath_FIR_mult_208_n3), .B(
        datapath_FIR_mult_208_n174), .Z(datapath_FIR_M3_11_) );
  XOR2_X1 datapath_FIR_mult_208_U131 ( .A(datapath_FIR_mult_208_n15), .B(
        datapath_FIR_mult_208_n14), .Z(datapath_FIR_mult_208_n174) );
  AND2_X1 datapath_FIR_mult_208_U130 ( .A1(datapath_FIR_bq3[0]), .A2(
        datapath_FIR_x3[5]), .ZN(datapath_FIR_mult_208_n86) );
  INV_X1 datapath_FIR_mult_208_U129 ( .A(datapath_FIR_x3[4]), .ZN(
        datapath_FIR_mult_208_n173) );
  NAND3_X1 datapath_FIR_mult_208_U128 ( .A1(datapath_FIR_mult_208_n170), .A2(
        datapath_FIR_mult_208_n171), .A3(datapath_FIR_mult_208_n172), .ZN(
        datapath_FIR_mult_208_n3) );
  NAND2_X1 datapath_FIR_mult_208_U127 ( .A1(datapath_FIR_mult_208_n19), .A2(
        datapath_FIR_mult_208_n16), .ZN(datapath_FIR_mult_208_n172) );
  NAND2_X1 datapath_FIR_mult_208_U126 ( .A1(datapath_FIR_mult_208_n4), .A2(
        datapath_FIR_mult_208_n16), .ZN(datapath_FIR_mult_208_n171) );
  NAND2_X1 datapath_FIR_mult_208_U125 ( .A1(datapath_FIR_mult_208_n4), .A2(
        datapath_FIR_mult_208_n19), .ZN(datapath_FIR_mult_208_n170) );
  XOR2_X1 datapath_FIR_mult_208_U124 ( .A(datapath_FIR_mult_208_n4), .B(
        datapath_FIR_mult_208_n169), .Z(datapath_FIR_M3_10_) );
  XOR2_X1 datapath_FIR_mult_208_U123 ( .A(datapath_FIR_mult_208_n19), .B(
        datapath_FIR_mult_208_n16), .Z(datapath_FIR_mult_208_n169) );
  AND3_X1 datapath_FIR_mult_208_U122 ( .A1(datapath_FIR_mult_208_n208), .A2(
        datapath_FIR_mult_208_n209), .A3(datapath_FIR_mult_208_n210), .ZN(
        datapath_FIR_mult_208_n168) );
  AND2_X1 datapath_FIR_mult_208_U121 ( .A1(datapath_FIR_bq3[5]), .A2(
        datapath_FIR_x3[2]), .ZN(datapath_FIR_mult_208_n102) );
  NAND3_X1 datapath_FIR_mult_208_U120 ( .A1(datapath_FIR_mult_208_n165), .A2(
        datapath_FIR_mult_208_n166), .A3(datapath_FIR_mult_208_n167), .ZN(
        datapath_FIR_mult_208_n4) );
  NAND2_X1 datapath_FIR_mult_208_U119 ( .A1(datapath_FIR_mult_208_n20), .A2(
        datapath_FIR_mult_208_n25), .ZN(datapath_FIR_mult_208_n167) );
  NAND2_X1 datapath_FIR_mult_208_U118 ( .A1(datapath_FIR_mult_208_n5), .A2(
        datapath_FIR_mult_208_n25), .ZN(datapath_FIR_mult_208_n166) );
  NAND2_X1 datapath_FIR_mult_208_U117 ( .A1(datapath_FIR_mult_208_n5), .A2(
        datapath_FIR_mult_208_n20), .ZN(datapath_FIR_mult_208_n165) );
  XOR2_X1 datapath_FIR_mult_208_U116 ( .A(datapath_FIR_mult_208_n5), .B(
        datapath_FIR_mult_208_n164), .Z(datapath_FIR_M3_9_) );
  XOR2_X1 datapath_FIR_mult_208_U115 ( .A(datapath_FIR_mult_208_n20), .B(
        datapath_FIR_mult_208_n25), .Z(datapath_FIR_mult_208_n164) );
  INV_X1 datapath_FIR_mult_208_U114 ( .A(datapath_FIR_bq3[5]), .ZN(
        datapath_FIR_mult_208_n163) );
  XOR2_X1 datapath_FIR_mult_208_U113 ( .A(datapath_FIR_mult_208_n34), .B(
        datapath_FIR_mult_208_n43), .Z(datapath_FIR_mult_208_n162) );
  XNOR2_X1 datapath_FIR_mult_208_U112 ( .A(datapath_FIR_mult_208_n168), .B(
        datapath_FIR_mult_208_n162), .ZN(datapath_FIR_M3_7_) );
  INV_X1 datapath_FIR_mult_208_U111 ( .A(datapath_FIR_mult_208_n180), .ZN(
        datapath_FIR_mult_208_n161) );
  AND2_X1 datapath_FIR_mult_208_U110 ( .A1(datapath_FIR_mult_208_n86), .A2(
        datapath_FIR_mult_208_n92), .ZN(datapath_FIR_mult_208_n160) );
  INV_X1 datapath_FIR_mult_208_U109 ( .A(datapath_FIR_bq3[3]), .ZN(
        datapath_FIR_mult_208_n214) );
  HA_X1 datapath_FIR_mult_208_U44 ( .A(datapath_FIR_mult_208_n113), .B(
        datapath_FIR_mult_208_n119), .CO(datapath_FIR_mult_208_n71), .S(
        datapath_FIR_mult_208_n72) );
  HA_X1 datapath_FIR_mult_208_U43 ( .A(datapath_FIR_mult_208_n100), .B(
        datapath_FIR_mult_208_n106), .CO(datapath_FIR_mult_208_n69), .S(
        datapath_FIR_mult_208_n70) );
  FA_X1 datapath_FIR_mult_208_U42 ( .A(datapath_FIR_mult_208_n112), .B(
        datapath_FIR_mult_208_n118), .CI(datapath_FIR_mult_208_n71), .CO(
        datapath_FIR_mult_208_n67), .S(datapath_FIR_mult_208_n68) );
  HA_X1 datapath_FIR_mult_208_U41 ( .A(datapath_FIR_mult_208_n93), .B(
        datapath_FIR_mult_208_n99), .CO(datapath_FIR_mult_208_n65), .S(
        datapath_FIR_mult_208_n66) );
  FA_X1 datapath_FIR_mult_208_U40 ( .A(datapath_FIR_mult_208_n105), .B(
        datapath_FIR_mult_208_n117), .CI(datapath_FIR_mult_208_n111), .CO(
        datapath_FIR_mult_208_n63), .S(datapath_FIR_mult_208_n64) );
  FA_X1 datapath_FIR_mult_208_U39 ( .A(datapath_FIR_mult_208_n66), .B(
        datapath_FIR_mult_208_n69), .CI(datapath_FIR_mult_208_n67), .CO(
        datapath_FIR_mult_208_n61), .S(datapath_FIR_mult_208_n62) );
  FA_X1 datapath_FIR_mult_208_U37 ( .A(datapath_FIR_mult_208_n98), .B(
        datapath_FIR_mult_208_n116), .CI(datapath_FIR_mult_208_n104), .CO(
        datapath_FIR_mult_208_n57), .S(datapath_FIR_mult_208_n58) );
  HA_X1 datapath_FIR_mult_208_U34 ( .A(datapath_FIR_mult_208_n97), .B(
        datapath_FIR_mult_208_n91), .CO(datapath_FIR_mult_208_n51), .S(
        datapath_FIR_mult_208_n52) );
  FA_X1 datapath_FIR_mult_208_U33 ( .A(datapath_FIR_mult_208_n85), .B(
        datapath_FIR_mult_208_n103), .CI(datapath_FIR_mult_208_n109), .CO(
        datapath_FIR_mult_208_n49), .S(datapath_FIR_mult_208_n50) );
  FA_X1 datapath_FIR_mult_208_U32 ( .A(datapath_FIR_mult_208_n79), .B(
        datapath_FIR_mult_208_n115), .CI(datapath_FIR_mult_208_n160), .CO(
        datapath_FIR_mult_208_n47), .S(datapath_FIR_mult_208_n48) );
  FA_X1 datapath_FIR_mult_208_U31 ( .A(datapath_FIR_mult_208_n57), .B(
        datapath_FIR_mult_208_n52), .CI(datapath_FIR_mult_208_n50), .CO(
        datapath_FIR_mult_208_n45), .S(datapath_FIR_mult_208_n46) );
  FA_X1 datapath_FIR_mult_208_U30 ( .A(datapath_FIR_mult_208_n48), .B(
        datapath_FIR_mult_208_n55), .CI(datapath_FIR_mult_208_n46), .CO(
        datapath_FIR_mult_208_n43), .S(datapath_FIR_mult_208_n44) );
  FA_X1 datapath_FIR_mult_208_U27 ( .A(datapath_FIR_mult_208_n102), .B(
        datapath_FIR_mult_208_n90), .CI(datapath_FIR_mult_208_n108), .CO(
        datapath_FIR_mult_208_n39), .S(datapath_FIR_mult_208_n40) );
  FA_X1 datapath_FIR_mult_208_U26 ( .A(datapath_FIR_mult_208_n51), .B(
        datapath_FIR_mult_208_n78), .CI(datapath_FIR_mult_208_n42), .CO(
        datapath_FIR_mult_208_n37), .S(datapath_FIR_mult_208_n38) );
  FA_X1 datapath_FIR_mult_208_U25 ( .A(datapath_FIR_mult_208_n47), .B(
        datapath_FIR_mult_208_n49), .CI(datapath_FIR_mult_208_n40), .CO(
        datapath_FIR_mult_208_n35), .S(datapath_FIR_mult_208_n36) );
  FA_X1 datapath_FIR_mult_208_U24 ( .A(datapath_FIR_mult_208_n45), .B(
        datapath_FIR_mult_208_n38), .CI(datapath_FIR_mult_208_n36), .CO(
        datapath_FIR_mult_208_n33), .S(datapath_FIR_mult_208_n34) );
  FA_X1 datapath_FIR_mult_208_U23 ( .A(datapath_FIR_mult_208_n83), .B(
        datapath_FIR_mult_208_n89), .CI(datapath_FIR_mult_208_n95), .CO(
        datapath_FIR_mult_208_n31), .S(datapath_FIR_mult_208_n32) );
  FA_X1 datapath_FIR_mult_208_U22 ( .A(datapath_FIR_mult_208_n77), .B(
        datapath_FIR_mult_208_n101), .CI(datapath_FIR_mult_208_n41), .CO(
        datapath_FIR_mult_208_n29), .S(datapath_FIR_mult_208_n30) );
  FA_X1 datapath_FIR_mult_208_U21 ( .A(datapath_FIR_mult_208_n32), .B(
        datapath_FIR_mult_208_n39), .CI(datapath_FIR_mult_208_n37), .CO(
        datapath_FIR_mult_208_n27), .S(datapath_FIR_mult_208_n28) );
  FA_X1 datapath_FIR_mult_208_U20 ( .A(datapath_FIR_mult_208_n35), .B(
        datapath_FIR_mult_208_n30), .CI(datapath_FIR_mult_208_n28), .CO(
        datapath_FIR_mult_208_n25), .S(datapath_FIR_mult_208_n26) );
  FA_X1 datapath_FIR_mult_208_U19 ( .A(datapath_FIR_mult_208_n82), .B(
        datapath_FIR_mult_208_n88), .CI(datapath_FIR_mult_208_n94), .CO(
        datapath_FIR_mult_208_n23), .S(datapath_FIR_mult_208_n24) );
  FA_X1 datapath_FIR_mult_208_U18 ( .A(datapath_FIR_mult_208_n31), .B(
        datapath_FIR_mult_208_n76), .CI(datapath_FIR_mult_208_n29), .CO(
        datapath_FIR_mult_208_n21), .S(datapath_FIR_mult_208_n22) );
  FA_X1 datapath_FIR_mult_208_U17 ( .A(datapath_FIR_mult_208_n27), .B(
        datapath_FIR_mult_208_n24), .CI(datapath_FIR_mult_208_n22), .CO(
        datapath_FIR_mult_208_n19), .S(datapath_FIR_mult_208_n20) );
  FA_X1 datapath_FIR_mult_208_U16 ( .A(datapath_FIR_mult_208_n87), .B(
        datapath_FIR_mult_208_n81), .CI(datapath_FIR_mult_208_n75), .CO(
        datapath_FIR_mult_208_n17), .S(datapath_FIR_mult_208_n18) );
  FA_X1 datapath_FIR_mult_208_U15 ( .A(datapath_FIR_mult_208_n18), .B(
        datapath_FIR_mult_208_n23), .CI(datapath_FIR_mult_208_n21), .CO(
        datapath_FIR_mult_208_n15), .S(datapath_FIR_mult_208_n16) );
  FA_X1 datapath_FIR_mult_208_U14 ( .A(datapath_FIR_mult_208_n74), .B(
        datapath_FIR_mult_208_n80), .CI(datapath_FIR_mult_208_n17), .CO(
        datapath_FIR_mult_208_n13), .S(datapath_FIR_mult_208_n14) );
  NOR2_X1 datapath_FIR_mult_212_U231 ( .A1(datapath_FIR_mult_212_n185), .A2(
        datapath_FIR_mult_212_n210), .ZN(datapath_FIR_mult_212_n100) );
  NAND2_X1 datapath_FIR_mult_212_U230 ( .A1(datapath_FIR_x7[2]), .A2(
        datapath_FIR_bq7[6]), .ZN(datapath_FIR_mult_212_n101) );
  NOR2_X1 datapath_FIR_mult_212_U229 ( .A1(datapath_FIR_mult_212_n203), .A2(
        datapath_FIR_mult_212_n213), .ZN(datapath_FIR_mult_212_n103) );
  NOR2_X1 datapath_FIR_mult_212_U228 ( .A1(datapath_FIR_mult_212_n206), .A2(
        datapath_FIR_mult_212_n213), .ZN(datapath_FIR_mult_212_n104) );
  NOR2_X1 datapath_FIR_mult_212_U227 ( .A1(datapath_FIR_mult_212_n207), .A2(
        datapath_FIR_mult_212_n213), .ZN(datapath_FIR_mult_212_n105) );
  NOR2_X1 datapath_FIR_mult_212_U226 ( .A1(datapath_FIR_mult_212_n209), .A2(
        datapath_FIR_mult_212_n213), .ZN(datapath_FIR_mult_212_n106) );
  NAND2_X1 datapath_FIR_mult_212_U225 ( .A1(datapath_FIR_x7[1]), .A2(
        datapath_FIR_bq7[6]), .ZN(datapath_FIR_mult_212_n108) );
  NOR2_X1 datapath_FIR_mult_212_U224 ( .A1(datapath_FIR_mult_212_n202), .A2(
        datapath_FIR_mult_212_n214), .ZN(datapath_FIR_mult_212_n109) );
  NOR2_X1 datapath_FIR_mult_212_U223 ( .A1(datapath_FIR_mult_212_n203), .A2(
        datapath_FIR_mult_212_n214), .ZN(datapath_FIR_mult_212_n110) );
  NOR2_X1 datapath_FIR_mult_212_U222 ( .A1(datapath_FIR_mult_212_n206), .A2(
        datapath_FIR_mult_212_n214), .ZN(datapath_FIR_mult_212_n111) );
  NOR2_X1 datapath_FIR_mult_212_U221 ( .A1(datapath_FIR_mult_212_n207), .A2(
        datapath_FIR_mult_212_n214), .ZN(datapath_FIR_mult_212_n112) );
  NAND2_X1 datapath_FIR_mult_212_U220 ( .A1(datapath_FIR_x7[0]), .A2(
        datapath_FIR_bq7[6]), .ZN(datapath_FIR_mult_212_n115) );
  NOR2_X1 datapath_FIR_mult_212_U219 ( .A1(datapath_FIR_mult_212_n202), .A2(
        datapath_FIR_mult_212_n215), .ZN(datapath_FIR_mult_212_n116) );
  NOR2_X1 datapath_FIR_mult_212_U218 ( .A1(datapath_FIR_mult_212_n203), .A2(
        datapath_FIR_mult_212_n215), .ZN(datapath_FIR_mult_212_n117) );
  NOR2_X1 datapath_FIR_mult_212_U217 ( .A1(datapath_FIR_mult_212_n206), .A2(
        datapath_FIR_mult_212_n215), .ZN(datapath_FIR_mult_212_n118) );
  NAND2_X1 datapath_FIR_mult_212_U216 ( .A1(datapath_FIR_bq7[4]), .A2(
        datapath_FIR_x7[3]), .ZN(datapath_FIR_mult_212_n223) );
  NAND2_X1 datapath_FIR_mult_212_U215 ( .A1(datapath_FIR_x7[5]), .A2(
        datapath_FIR_bq7[2]), .ZN(datapath_FIR_mult_212_n222) );
  NAND2_X1 datapath_FIR_mult_212_U214 ( .A1(datapath_FIR_mult_212_n223), .A2(
        datapath_FIR_mult_212_n222), .ZN(datapath_FIR_mult_212_n41) );
  XNOR2_X1 datapath_FIR_mult_212_U213 ( .A(datapath_FIR_mult_212_n222), .B(
        datapath_FIR_mult_212_n223), .ZN(datapath_FIR_mult_212_n42) );
  NAND2_X1 datapath_FIR_mult_212_U212 ( .A1(datapath_FIR_bq7[5]), .A2(
        datapath_FIR_x7[6]), .ZN(datapath_FIR_mult_212_n74) );
  NAND2_X1 datapath_FIR_mult_212_U211 ( .A1(datapath_FIR_bq7[4]), .A2(
        datapath_FIR_x7[6]), .ZN(datapath_FIR_mult_212_n75) );
  NAND2_X1 datapath_FIR_mult_212_U210 ( .A1(datapath_FIR_bq7[3]), .A2(
        datapath_FIR_x7[6]), .ZN(datapath_FIR_mult_212_n76) );
  NAND2_X1 datapath_FIR_mult_212_U209 ( .A1(datapath_FIR_bq7[2]), .A2(
        datapath_FIR_x7[6]), .ZN(datapath_FIR_mult_212_n77) );
  NAND2_X1 datapath_FIR_mult_212_U208 ( .A1(datapath_FIR_mult_212_n176), .A2(
        datapath_FIR_x7[6]), .ZN(datapath_FIR_mult_212_n78) );
  NAND2_X1 datapath_FIR_mult_212_U207 ( .A1(datapath_FIR_bq7[0]), .A2(
        datapath_FIR_x7[6]), .ZN(datapath_FIR_mult_212_n79) );
  NOR4_X1 datapath_FIR_mult_212_U206 ( .A1(datapath_FIR_mult_212_n214), .A2(
        datapath_FIR_mult_212_n215), .A3(datapath_FIR_mult_212_n210), .A4(
        datapath_FIR_mult_212_n209), .ZN(datapath_FIR_mult_212_n220) );
  NOR2_X1 datapath_FIR_mult_212_U205 ( .A1(datapath_FIR_mult_212_n213), .A2(
        datapath_FIR_mult_212_n210), .ZN(datapath_FIR_mult_212_n221) );
  AOI222_X1 datapath_FIR_mult_212_U204 ( .A1(datapath_FIR_mult_212_n72), .A2(
        datapath_FIR_mult_212_n220), .B1(datapath_FIR_mult_212_n221), .B2(
        datapath_FIR_mult_212_n72), .C1(datapath_FIR_mult_212_n221), .C2(
        datapath_FIR_mult_212_n220), .ZN(datapath_FIR_mult_212_n219) );
  OAI222_X1 datapath_FIR_mult_212_U203 ( .A1(datapath_FIR_mult_212_n219), .A2(
        datapath_FIR_mult_212_n205), .B1(datapath_FIR_mult_212_n205), .B2(
        datapath_FIR_mult_212_n208), .C1(datapath_FIR_mult_212_n219), .C2(
        datapath_FIR_mult_212_n208), .ZN(datapath_FIR_mult_212_n218) );
  OAI222_X1 datapath_FIR_mult_212_U202 ( .A1(datapath_FIR_mult_212_n175), .A2(
        datapath_FIR_mult_212_n186), .B1(datapath_FIR_mult_212_n217), .B2(
        datapath_FIR_mult_212_n204), .C1(datapath_FIR_mult_212_n204), .C2(
        datapath_FIR_mult_212_n201), .ZN(datapath_FIR_mult_212_n8) );
  NAND2_X1 datapath_FIR_mult_212_U201 ( .A1(datapath_FIR_x7[5]), .A2(
        datapath_FIR_bq7[6]), .ZN(datapath_FIR_mult_212_n80) );
  NOR2_X1 datapath_FIR_mult_212_U200 ( .A1(datapath_FIR_mult_212_n202), .A2(
        datapath_FIR_mult_212_n193), .ZN(datapath_FIR_mult_212_n81) );
  NOR2_X1 datapath_FIR_mult_212_U199 ( .A1(datapath_FIR_mult_212_n203), .A2(
        datapath_FIR_mult_212_n193), .ZN(datapath_FIR_mult_212_n82) );
  NOR2_X1 datapath_FIR_mult_212_U198 ( .A1(datapath_FIR_mult_212_n206), .A2(
        datapath_FIR_mult_212_n193), .ZN(datapath_FIR_mult_212_n83) );
  NOR2_X1 datapath_FIR_mult_212_U197 ( .A1(datapath_FIR_mult_212_n209), .A2(
        datapath_FIR_mult_212_n211), .ZN(datapath_FIR_mult_212_n85) );
  NAND2_X1 datapath_FIR_mult_212_U196 ( .A1(datapath_FIR_mult_212_n174), .A2(
        datapath_FIR_bq7[6]), .ZN(datapath_FIR_mult_212_n87) );
  NOR2_X1 datapath_FIR_mult_212_U195 ( .A1(datapath_FIR_mult_212_n202), .A2(
        datapath_FIR_mult_212_n184), .ZN(datapath_FIR_mult_212_n88) );
  NOR2_X1 datapath_FIR_mult_212_U194 ( .A1(datapath_FIR_mult_212_n184), .A2(
        datapath_FIR_mult_212_n203), .ZN(datapath_FIR_mult_212_n89) );
  NOR2_X1 datapath_FIR_mult_212_U193 ( .A1(datapath_FIR_mult_212_n206), .A2(
        datapath_FIR_mult_212_n212), .ZN(datapath_FIR_mult_212_n90) );
  NOR2_X1 datapath_FIR_mult_212_U192 ( .A1(datapath_FIR_mult_212_n207), .A2(
        datapath_FIR_mult_212_n212), .ZN(datapath_FIR_mult_212_n91) );
  NAND2_X1 datapath_FIR_mult_212_U191 ( .A1(datapath_FIR_x7[3]), .A2(
        datapath_FIR_bq7[6]), .ZN(datapath_FIR_mult_212_n94) );
  NOR2_X1 datapath_FIR_mult_212_U190 ( .A1(datapath_FIR_mult_212_n185), .A2(
        datapath_FIR_mult_212_n202), .ZN(datapath_FIR_mult_212_n95) );
  NOR2_X1 datapath_FIR_mult_212_U189 ( .A1(datapath_FIR_mult_212_n185), .A2(
        datapath_FIR_mult_212_n206), .ZN(datapath_FIR_mult_212_n97) );
  NOR2_X1 datapath_FIR_mult_212_U188 ( .A1(datapath_FIR_mult_212_n185), .A2(
        datapath_FIR_mult_212_n207), .ZN(datapath_FIR_mult_212_n98) );
  XNOR2_X1 datapath_FIR_mult_212_U187 ( .A(datapath_FIR_mult_212_n2), .B(
        datapath_FIR_mult_212_n13), .ZN(datapath_FIR_mult_212_n216) );
  INV_X1 datapath_FIR_mult_212_U186 ( .A(datapath_FIR_mult_212_n54), .ZN(
        datapath_FIR_mult_212_n201) );
  INV_X1 datapath_FIR_mult_212_U185 ( .A(datapath_FIR_mult_212_n68), .ZN(
        datapath_FIR_mult_212_n205) );
  NAND3_X1 datapath_FIR_mult_212_U184 ( .A1(datapath_FIR_mult_212_n198), .A2(
        datapath_FIR_mult_212_n199), .A3(datapath_FIR_mult_212_n200), .ZN(
        datapath_FIR_mult_212_n7) );
  NAND2_X1 datapath_FIR_mult_212_U183 ( .A1(datapath_FIR_mult_212_n44), .A2(
        datapath_FIR_mult_212_n53), .ZN(datapath_FIR_mult_212_n200) );
  NAND2_X1 datapath_FIR_mult_212_U182 ( .A1(datapath_FIR_mult_212_n53), .A2(
        datapath_FIR_mult_212_n8), .ZN(datapath_FIR_mult_212_n199) );
  NAND2_X1 datapath_FIR_mult_212_U181 ( .A1(datapath_FIR_mult_212_n191), .A2(
        datapath_FIR_mult_212_n44), .ZN(datapath_FIR_mult_212_n198) );
  INV_X1 datapath_FIR_mult_212_U180 ( .A(datapath_FIR_x7[0]), .ZN(
        datapath_FIR_mult_212_n215) );
  INV_X1 datapath_FIR_mult_212_U179 ( .A(datapath_FIR_x7[4]), .ZN(
        datapath_FIR_mult_212_n212) );
  INV_X1 datapath_FIR_mult_212_U178 ( .A(datapath_FIR_x7[5]), .ZN(
        datapath_FIR_mult_212_n211) );
  INV_X1 datapath_FIR_mult_212_U177 ( .A(datapath_FIR_x7[1]), .ZN(
        datapath_FIR_mult_212_n214) );
  INV_X1 datapath_FIR_mult_212_U176 ( .A(datapath_FIR_bq7[2]), .ZN(
        datapath_FIR_mult_212_n207) );
  NAND3_X1 datapath_FIR_mult_212_U175 ( .A1(datapath_FIR_mult_212_n195), .A2(
        datapath_FIR_mult_212_n196), .A3(datapath_FIR_mult_212_n197), .ZN(
        datapath_FIR_mult_212_n6) );
  NAND2_X1 datapath_FIR_mult_212_U174 ( .A1(datapath_FIR_mult_212_n34), .A2(
        datapath_FIR_mult_212_n43), .ZN(datapath_FIR_mult_212_n197) );
  NAND2_X1 datapath_FIR_mult_212_U173 ( .A1(datapath_FIR_mult_212_n166), .A2(
        datapath_FIR_mult_212_n43), .ZN(datapath_FIR_mult_212_n196) );
  NAND2_X1 datapath_FIR_mult_212_U172 ( .A1(datapath_FIR_mult_212_n166), .A2(
        datapath_FIR_mult_212_n34), .ZN(datapath_FIR_mult_212_n195) );
  INV_X1 datapath_FIR_mult_212_U171 ( .A(datapath_FIR_x7[2]), .ZN(
        datapath_FIR_mult_212_n213) );
  INV_X1 datapath_FIR_mult_212_U170 ( .A(datapath_FIR_bq7[1]), .ZN(
        datapath_FIR_mult_212_n209) );
  AND2_X1 datapath_FIR_mult_212_U169 ( .A1(datapath_FIR_bq7[1]), .A2(
        datapath_FIR_x7[1]), .ZN(datapath_FIR_mult_212_n113) );
  AND2_X1 datapath_FIR_mult_212_U168 ( .A1(datapath_FIR_bq7[2]), .A2(
        datapath_FIR_x7[0]), .ZN(datapath_FIR_mult_212_n119) );
  XNOR2_X1 datapath_FIR_mult_212_U167 ( .A(datapath_FIR_mult_212_n44), .B(
        datapath_FIR_mult_212_n53), .ZN(datapath_FIR_mult_212_n194) );
  XNOR2_X1 datapath_FIR_mult_212_U166 ( .A(datapath_FIR_mult_212_n192), .B(
        datapath_FIR_mult_212_n194), .ZN(datapath_FIR_M7_6_) );
  CLKBUF_X1 datapath_FIR_mult_212_U165 ( .A(datapath_FIR_mult_212_n211), .Z(
        datapath_FIR_mult_212_n193) );
  INV_X1 datapath_FIR_mult_212_U164 ( .A(datapath_FIR_bq7[0]), .ZN(
        datapath_FIR_mult_212_n210) );
  OAI222_X1 datapath_FIR_mult_212_U163 ( .A1(datapath_FIR_mult_212_n175), .A2(
        datapath_FIR_mult_212_n186), .B1(datapath_FIR_mult_212_n175), .B2(
        datapath_FIR_mult_212_n204), .C1(datapath_FIR_mult_212_n204), .C2(
        datapath_FIR_mult_212_n186), .ZN(datapath_FIR_mult_212_n192) );
  OAI222_X1 datapath_FIR_mult_212_U162 ( .A1(datapath_FIR_mult_212_n175), .A2(
        datapath_FIR_mult_212_n186), .B1(datapath_FIR_mult_212_n217), .B2(
        datapath_FIR_mult_212_n204), .C1(datapath_FIR_mult_212_n204), .C2(
        datapath_FIR_mult_212_n201), .ZN(datapath_FIR_mult_212_n191) );
  INV_X1 datapath_FIR_mult_212_U161 ( .A(datapath_FIR_bq7[4]), .ZN(
        datapath_FIR_mult_212_n203) );
  INV_X1 datapath_FIR_mult_212_U160 ( .A(datapath_FIR_bq7[5]), .ZN(
        datapath_FIR_mult_212_n202) );
  INV_X1 datapath_FIR_mult_212_U159 ( .A(datapath_FIR_bq7[3]), .ZN(
        datapath_FIR_mult_212_n206) );
  NAND2_X1 datapath_FIR_mult_212_U158 ( .A1(datapath_FIR_bq7[6]), .A2(
        datapath_FIR_x7[6]), .ZN(datapath_FIR_mult_212_n190) );
  XOR2_X1 datapath_FIR_mult_212_U157 ( .A(datapath_FIR_mult_212_n190), .B(
        datapath_FIR_mult_212_n216), .Z(datapath_FIR_M7_12_) );
  INV_X1 datapath_FIR_mult_212_U156 ( .A(datapath_FIR_mult_212_n70), .ZN(
        datapath_FIR_mult_212_n208) );
  INV_X1 datapath_FIR_mult_212_U155 ( .A(datapath_FIR_mult_212_n61), .ZN(
        datapath_FIR_mult_212_n204) );
  NAND2_X1 datapath_FIR_mult_212_U154 ( .A1(datapath_FIR_mult_212_n64), .A2(
        datapath_FIR_mult_212_n62), .ZN(datapath_FIR_mult_212_n189) );
  NAND2_X1 datapath_FIR_mult_212_U153 ( .A1(datapath_FIR_mult_212_n218), .A2(
        datapath_FIR_mult_212_n64), .ZN(datapath_FIR_mult_212_n188) );
  NAND2_X1 datapath_FIR_mult_212_U152 ( .A1(datapath_FIR_mult_212_n218), .A2(
        datapath_FIR_mult_212_n62), .ZN(datapath_FIR_mult_212_n187) );
  INV_X1 datapath_FIR_mult_212_U151 ( .A(datapath_FIR_mult_212_n54), .ZN(
        datapath_FIR_mult_212_n186) );
  AND2_X1 datapath_FIR_mult_212_U150 ( .A1(datapath_FIR_bq7[0]), .A2(
        datapath_FIR_x7[5]), .ZN(datapath_FIR_mult_212_n86) );
  INV_X1 datapath_FIR_mult_212_U149 ( .A(datapath_FIR_x7[3]), .ZN(
        datapath_FIR_mult_212_n185) );
  AND2_X1 datapath_FIR_mult_212_U148 ( .A1(datapath_FIR_x7[3]), .A2(
        datapath_FIR_bq7[1]), .ZN(datapath_FIR_mult_212_n99) );
  CLKBUF_X1 datapath_FIR_mult_212_U147 ( .A(datapath_FIR_mult_212_n212), .Z(
        datapath_FIR_mult_212_n184) );
  NAND3_X1 datapath_FIR_mult_212_U146 ( .A1(datapath_FIR_mult_212_n181), .A2(
        datapath_FIR_mult_212_n182), .A3(datapath_FIR_mult_212_n183), .ZN(
        datapath_FIR_mult_212_n43) );
  NAND2_X1 datapath_FIR_mult_212_U145 ( .A1(datapath_FIR_mult_212_n48), .A2(
        datapath_FIR_mult_212_n55), .ZN(datapath_FIR_mult_212_n183) );
  NAND2_X1 datapath_FIR_mult_212_U144 ( .A1(datapath_FIR_mult_212_n46), .A2(
        datapath_FIR_mult_212_n55), .ZN(datapath_FIR_mult_212_n182) );
  NAND2_X1 datapath_FIR_mult_212_U143 ( .A1(datapath_FIR_mult_212_n46), .A2(
        datapath_FIR_mult_212_n48), .ZN(datapath_FIR_mult_212_n181) );
  NAND3_X1 datapath_FIR_mult_212_U142 ( .A1(datapath_FIR_mult_212_n178), .A2(
        datapath_FIR_mult_212_n179), .A3(datapath_FIR_mult_212_n180), .ZN(
        datapath_FIR_mult_212_n3) );
  NAND2_X1 datapath_FIR_mult_212_U141 ( .A1(datapath_FIR_mult_212_n19), .A2(
        datapath_FIR_mult_212_n16), .ZN(datapath_FIR_mult_212_n180) );
  NAND2_X1 datapath_FIR_mult_212_U140 ( .A1(datapath_FIR_mult_212_n4), .A2(
        datapath_FIR_mult_212_n16), .ZN(datapath_FIR_mult_212_n179) );
  NAND2_X1 datapath_FIR_mult_212_U139 ( .A1(datapath_FIR_mult_212_n4), .A2(
        datapath_FIR_mult_212_n19), .ZN(datapath_FIR_mult_212_n178) );
  XOR2_X1 datapath_FIR_mult_212_U138 ( .A(datapath_FIR_mult_212_n4), .B(
        datapath_FIR_mult_212_n177), .Z(datapath_FIR_M7_10_) );
  XOR2_X1 datapath_FIR_mult_212_U137 ( .A(datapath_FIR_mult_212_n19), .B(
        datapath_FIR_mult_212_n16), .Z(datapath_FIR_mult_212_n177) );
  AND2_X1 datapath_FIR_mult_212_U136 ( .A1(datapath_FIR_x7[4]), .A2(
        datapath_FIR_bq7[0]), .ZN(datapath_FIR_mult_212_n93) );
  INV_X1 datapath_FIR_mult_212_U135 ( .A(datapath_FIR_mult_212_n209), .ZN(
        datapath_FIR_mult_212_n176) );
  AND3_X1 datapath_FIR_mult_212_U134 ( .A1(datapath_FIR_mult_212_n187), .A2(
        datapath_FIR_mult_212_n188), .A3(datapath_FIR_mult_212_n189), .ZN(
        datapath_FIR_mult_212_n217) );
  AND3_X2 datapath_FIR_mult_212_U133 ( .A1(datapath_FIR_mult_212_n188), .A2(
        datapath_FIR_mult_212_n187), .A3(datapath_FIR_mult_212_n189), .ZN(
        datapath_FIR_mult_212_n175) );
  INV_X1 datapath_FIR_mult_212_U132 ( .A(datapath_FIR_mult_212_n184), .ZN(
        datapath_FIR_mult_212_n174) );
  AND2_X1 datapath_FIR_mult_212_U131 ( .A1(datapath_FIR_bq7[1]), .A2(
        datapath_FIR_x7[4]), .ZN(datapath_FIR_mult_212_n173) );
  NAND3_X1 datapath_FIR_mult_212_U130 ( .A1(datapath_FIR_mult_212_n170), .A2(
        datapath_FIR_mult_212_n171), .A3(datapath_FIR_mult_212_n172), .ZN(
        datapath_FIR_mult_212_n4) );
  NAND2_X1 datapath_FIR_mult_212_U129 ( .A1(datapath_FIR_mult_212_n20), .A2(
        datapath_FIR_mult_212_n25), .ZN(datapath_FIR_mult_212_n172) );
  NAND2_X1 datapath_FIR_mult_212_U128 ( .A1(datapath_FIR_mult_212_n5), .A2(
        datapath_FIR_mult_212_n25), .ZN(datapath_FIR_mult_212_n171) );
  NAND2_X1 datapath_FIR_mult_212_U127 ( .A1(datapath_FIR_mult_212_n5), .A2(
        datapath_FIR_mult_212_n20), .ZN(datapath_FIR_mult_212_n170) );
  XOR2_X1 datapath_FIR_mult_212_U126 ( .A(datapath_FIR_mult_212_n5), .B(
        datapath_FIR_mult_212_n169), .Z(datapath_FIR_M7_9_) );
  XOR2_X1 datapath_FIR_mult_212_U125 ( .A(datapath_FIR_mult_212_n20), .B(
        datapath_FIR_mult_212_n25), .Z(datapath_FIR_mult_212_n169) );
  NAND2_X1 datapath_FIR_mult_212_U124 ( .A1(datapath_FIR_bq7[1]), .A2(
        datapath_FIR_x7[4]), .ZN(datapath_FIR_mult_212_n168) );
  XNOR2_X1 datapath_FIR_mult_212_U123 ( .A(datapath_FIR_mult_212_n86), .B(
        datapath_FIR_mult_212_n168), .ZN(datapath_FIR_mult_212_n60) );
  XNOR2_X1 datapath_FIR_mult_212_U122 ( .A(datapath_FIR_mult_212_n48), .B(
        datapath_FIR_mult_212_n55), .ZN(datapath_FIR_mult_212_n167) );
  XNOR2_X1 datapath_FIR_mult_212_U121 ( .A(datapath_FIR_mult_212_n46), .B(
        datapath_FIR_mult_212_n167), .ZN(datapath_FIR_mult_212_n44) );
  AND2_X1 datapath_FIR_mult_212_U120 ( .A1(datapath_FIR_bq7[5]), .A2(
        datapath_FIR_x7[2]), .ZN(datapath_FIR_mult_212_n102) );
  AND2_X1 datapath_FIR_mult_212_U119 ( .A1(datapath_FIR_mult_212_n113), .A2(
        datapath_FIR_mult_212_n119), .ZN(datapath_FIR_mult_212_n71) );
  NAND3_X1 datapath_FIR_mult_212_U118 ( .A1(datapath_FIR_mult_212_n198), .A2(
        datapath_FIR_mult_212_n199), .A3(datapath_FIR_mult_212_n200), .ZN(
        datapath_FIR_mult_212_n166) );
  NAND3_X1 datapath_FIR_mult_212_U117 ( .A1(datapath_FIR_mult_212_n163), .A2(
        datapath_FIR_mult_212_n164), .A3(datapath_FIR_mult_212_n165), .ZN(
        datapath_FIR_mult_212_n5) );
  NAND2_X1 datapath_FIR_mult_212_U116 ( .A1(datapath_FIR_mult_212_n26), .A2(
        datapath_FIR_mult_212_n33), .ZN(datapath_FIR_mult_212_n165) );
  NAND2_X1 datapath_FIR_mult_212_U115 ( .A1(datapath_FIR_mult_212_n6), .A2(
        datapath_FIR_mult_212_n33), .ZN(datapath_FIR_mult_212_n164) );
  NAND2_X1 datapath_FIR_mult_212_U114 ( .A1(datapath_FIR_mult_212_n6), .A2(
        datapath_FIR_mult_212_n26), .ZN(datapath_FIR_mult_212_n163) );
  XOR2_X1 datapath_FIR_mult_212_U113 ( .A(datapath_FIR_mult_212_n6), .B(
        datapath_FIR_mult_212_n162), .Z(datapath_FIR_M7_8_) );
  XOR2_X1 datapath_FIR_mult_212_U112 ( .A(datapath_FIR_mult_212_n26), .B(
        datapath_FIR_mult_212_n33), .Z(datapath_FIR_mult_212_n162) );
  XNOR2_X1 datapath_FIR_mult_212_U111 ( .A(datapath_FIR_mult_212_n34), .B(
        datapath_FIR_mult_212_n43), .ZN(datapath_FIR_mult_212_n161) );
  XNOR2_X1 datapath_FIR_mult_212_U110 ( .A(datapath_FIR_mult_212_n7), .B(
        datapath_FIR_mult_212_n161), .ZN(datapath_FIR_M7_7_) );
  AND2_X1 datapath_FIR_mult_212_U109 ( .A1(datapath_FIR_mult_212_n86), .A2(
        datapath_FIR_mult_212_n173), .ZN(datapath_FIR_mult_212_n160) );
  HA_X1 datapath_FIR_mult_212_U44 ( .A(datapath_FIR_mult_212_n113), .B(
        datapath_FIR_mult_212_n119), .S(datapath_FIR_mult_212_n72) );
  HA_X1 datapath_FIR_mult_212_U43 ( .A(datapath_FIR_mult_212_n100), .B(
        datapath_FIR_mult_212_n106), .CO(datapath_FIR_mult_212_n69), .S(
        datapath_FIR_mult_212_n70) );
  FA_X1 datapath_FIR_mult_212_U42 ( .A(datapath_FIR_mult_212_n112), .B(
        datapath_FIR_mult_212_n118), .CI(datapath_FIR_mult_212_n71), .CO(
        datapath_FIR_mult_212_n67), .S(datapath_FIR_mult_212_n68) );
  HA_X1 datapath_FIR_mult_212_U41 ( .A(datapath_FIR_mult_212_n93), .B(
        datapath_FIR_mult_212_n99), .CO(datapath_FIR_mult_212_n65), .S(
        datapath_FIR_mult_212_n66) );
  FA_X1 datapath_FIR_mult_212_U40 ( .A(datapath_FIR_mult_212_n105), .B(
        datapath_FIR_mult_212_n117), .CI(datapath_FIR_mult_212_n111), .CO(
        datapath_FIR_mult_212_n63), .S(datapath_FIR_mult_212_n64) );
  FA_X1 datapath_FIR_mult_212_U39 ( .A(datapath_FIR_mult_212_n66), .B(
        datapath_FIR_mult_212_n69), .CI(datapath_FIR_mult_212_n67), .CO(
        datapath_FIR_mult_212_n61), .S(datapath_FIR_mult_212_n62) );
  FA_X1 datapath_FIR_mult_212_U37 ( .A(datapath_FIR_mult_212_n98), .B(
        datapath_FIR_mult_212_n116), .CI(datapath_FIR_mult_212_n104), .CO(
        datapath_FIR_mult_212_n57), .S(datapath_FIR_mult_212_n58) );
  FA_X1 datapath_FIR_mult_212_U36 ( .A(datapath_FIR_mult_212_n65), .B(
        datapath_FIR_mult_212_n110), .CI(datapath_FIR_mult_212_n60), .CO(
        datapath_FIR_mult_212_n55), .S(datapath_FIR_mult_212_n56) );
  FA_X1 datapath_FIR_mult_212_U35 ( .A(datapath_FIR_mult_212_n58), .B(
        datapath_FIR_mult_212_n63), .CI(datapath_FIR_mult_212_n56), .CO(
        datapath_FIR_mult_212_n53), .S(datapath_FIR_mult_212_n54) );
  HA_X1 datapath_FIR_mult_212_U34 ( .A(datapath_FIR_mult_212_n97), .B(
        datapath_FIR_mult_212_n91), .CO(datapath_FIR_mult_212_n51), .S(
        datapath_FIR_mult_212_n52) );
  FA_X1 datapath_FIR_mult_212_U33 ( .A(datapath_FIR_mult_212_n85), .B(
        datapath_FIR_mult_212_n103), .CI(datapath_FIR_mult_212_n109), .CO(
        datapath_FIR_mult_212_n49), .S(datapath_FIR_mult_212_n50) );
  FA_X1 datapath_FIR_mult_212_U32 ( .A(datapath_FIR_mult_212_n79), .B(
        datapath_FIR_mult_212_n115), .CI(datapath_FIR_mult_212_n160), .CO(
        datapath_FIR_mult_212_n47), .S(datapath_FIR_mult_212_n48) );
  FA_X1 datapath_FIR_mult_212_U31 ( .A(datapath_FIR_mult_212_n57), .B(
        datapath_FIR_mult_212_n52), .CI(datapath_FIR_mult_212_n50), .CO(
        datapath_FIR_mult_212_n45), .S(datapath_FIR_mult_212_n46) );
  FA_X1 datapath_FIR_mult_212_U27 ( .A(datapath_FIR_mult_212_n102), .B(
        datapath_FIR_mult_212_n90), .CI(datapath_FIR_mult_212_n108), .CO(
        datapath_FIR_mult_212_n39), .S(datapath_FIR_mult_212_n40) );
  FA_X1 datapath_FIR_mult_212_U26 ( .A(datapath_FIR_mult_212_n51), .B(
        datapath_FIR_mult_212_n78), .CI(datapath_FIR_mult_212_n42), .CO(
        datapath_FIR_mult_212_n37), .S(datapath_FIR_mult_212_n38) );
  FA_X1 datapath_FIR_mult_212_U25 ( .A(datapath_FIR_mult_212_n47), .B(
        datapath_FIR_mult_212_n49), .CI(datapath_FIR_mult_212_n40), .CO(
        datapath_FIR_mult_212_n35), .S(datapath_FIR_mult_212_n36) );
  FA_X1 datapath_FIR_mult_212_U24 ( .A(datapath_FIR_mult_212_n45), .B(
        datapath_FIR_mult_212_n38), .CI(datapath_FIR_mult_212_n36), .CO(
        datapath_FIR_mult_212_n33), .S(datapath_FIR_mult_212_n34) );
  FA_X1 datapath_FIR_mult_212_U23 ( .A(datapath_FIR_mult_212_n83), .B(
        datapath_FIR_mult_212_n89), .CI(datapath_FIR_mult_212_n95), .CO(
        datapath_FIR_mult_212_n31), .S(datapath_FIR_mult_212_n32) );
  FA_X1 datapath_FIR_mult_212_U22 ( .A(datapath_FIR_mult_212_n77), .B(
        datapath_FIR_mult_212_n101), .CI(datapath_FIR_mult_212_n41), .CO(
        datapath_FIR_mult_212_n29), .S(datapath_FIR_mult_212_n30) );
  FA_X1 datapath_FIR_mult_212_U21 ( .A(datapath_FIR_mult_212_n32), .B(
        datapath_FIR_mult_212_n39), .CI(datapath_FIR_mult_212_n37), .CO(
        datapath_FIR_mult_212_n27), .S(datapath_FIR_mult_212_n28) );
  FA_X1 datapath_FIR_mult_212_U20 ( .A(datapath_FIR_mult_212_n35), .B(
        datapath_FIR_mult_212_n30), .CI(datapath_FIR_mult_212_n28), .CO(
        datapath_FIR_mult_212_n25), .S(datapath_FIR_mult_212_n26) );
  FA_X1 datapath_FIR_mult_212_U19 ( .A(datapath_FIR_mult_212_n82), .B(
        datapath_FIR_mult_212_n88), .CI(datapath_FIR_mult_212_n94), .CO(
        datapath_FIR_mult_212_n23), .S(datapath_FIR_mult_212_n24) );
  FA_X1 datapath_FIR_mult_212_U18 ( .A(datapath_FIR_mult_212_n31), .B(
        datapath_FIR_mult_212_n76), .CI(datapath_FIR_mult_212_n29), .CO(
        datapath_FIR_mult_212_n21), .S(datapath_FIR_mult_212_n22) );
  FA_X1 datapath_FIR_mult_212_U17 ( .A(datapath_FIR_mult_212_n27), .B(
        datapath_FIR_mult_212_n24), .CI(datapath_FIR_mult_212_n22), .CO(
        datapath_FIR_mult_212_n19), .S(datapath_FIR_mult_212_n20) );
  FA_X1 datapath_FIR_mult_212_U16 ( .A(datapath_FIR_mult_212_n87), .B(
        datapath_FIR_mult_212_n81), .CI(datapath_FIR_mult_212_n75), .CO(
        datapath_FIR_mult_212_n17), .S(datapath_FIR_mult_212_n18) );
  FA_X1 datapath_FIR_mult_212_U15 ( .A(datapath_FIR_mult_212_n18), .B(
        datapath_FIR_mult_212_n23), .CI(datapath_FIR_mult_212_n21), .CO(
        datapath_FIR_mult_212_n15), .S(datapath_FIR_mult_212_n16) );
  FA_X1 datapath_FIR_mult_212_U14 ( .A(datapath_FIR_mult_212_n74), .B(
        datapath_FIR_mult_212_n80), .CI(datapath_FIR_mult_212_n17), .CO(
        datapath_FIR_mult_212_n13), .S(datapath_FIR_mult_212_n14) );
  FA_X1 datapath_FIR_mult_212_U3 ( .A(datapath_FIR_mult_212_n15), .B(
        datapath_FIR_mult_212_n14), .CI(datapath_FIR_mult_212_n3), .CO(
        datapath_FIR_mult_212_n2), .S(datapath_FIR_M7_11_) );
  XOR2_X1 datapath_FIR_add_6_root_add_0_root_add_245_U9 ( .A(
        datapath_FIR_add_6_root_add_0_root_add_245_n2), .B(datapath_FIR_M7_6_), 
        .Z(datapath_FIR_S4_0_) );
  NAND3_X1 datapath_FIR_add_6_root_add_0_root_add_245_U8 ( .A1(
        datapath_FIR_add_6_root_add_0_root_add_245_n4), .A2(
        datapath_FIR_add_6_root_add_0_root_add_245_n5), .A3(
        datapath_FIR_add_6_root_add_0_root_add_245_n6), .ZN(
        datapath_FIR_add_6_root_add_0_root_add_245_carry[5]) );
  NAND2_X1 datapath_FIR_add_6_root_add_0_root_add_245_U7 ( .A1(
        datapath_FIR_M3_10_), .A2(datapath_FIR_M7_10_), .ZN(
        datapath_FIR_add_6_root_add_0_root_add_245_n6) );
  NAND2_X1 datapath_FIR_add_6_root_add_0_root_add_245_U6 ( .A1(
        datapath_FIR_add_6_root_add_0_root_add_245_carry[4]), .A2(
        datapath_FIR_M7_10_), .ZN(
        datapath_FIR_add_6_root_add_0_root_add_245_n5) );
  NAND2_X1 datapath_FIR_add_6_root_add_0_root_add_245_U5 ( .A1(
        datapath_FIR_add_6_root_add_0_root_add_245_carry[4]), .A2(
        datapath_FIR_M3_10_), .ZN(
        datapath_FIR_add_6_root_add_0_root_add_245_n4) );
  XOR2_X1 datapath_FIR_add_6_root_add_0_root_add_245_U4 ( .A(
        datapath_FIR_add_6_root_add_0_root_add_245_carry[4]), .B(
        datapath_FIR_add_6_root_add_0_root_add_245_n3), .Z(datapath_FIR_S4_4_)
         );
  XOR2_X1 datapath_FIR_add_6_root_add_0_root_add_245_U3 ( .A(
        datapath_FIR_M3_10_), .B(datapath_FIR_M7_10_), .Z(
        datapath_FIR_add_6_root_add_0_root_add_245_n3) );
  CLKBUF_X1 datapath_FIR_add_6_root_add_0_root_add_245_U2 ( .A(
        datapath_FIR_M3_6_), .Z(datapath_FIR_add_6_root_add_0_root_add_245_n2)
         );
  AND2_X1 datapath_FIR_add_6_root_add_0_root_add_245_U1 ( .A1(
        datapath_FIR_M3_6_), .A2(datapath_FIR_M7_6_), .ZN(
        datapath_FIR_add_6_root_add_0_root_add_245_n1) );
  FA_X1 datapath_FIR_add_6_root_add_0_root_add_245_U1_1 ( .A(
        datapath_FIR_M7_7_), .B(datapath_FIR_M3_7_), .CI(
        datapath_FIR_add_6_root_add_0_root_add_245_n1), .CO(
        datapath_FIR_add_6_root_add_0_root_add_245_carry[2]), .S(
        datapath_FIR_S4_1_) );
  FA_X1 datapath_FIR_add_6_root_add_0_root_add_245_U1_2 ( .A(
        datapath_FIR_M7_8_), .B(datapath_FIR_M3_8_), .CI(
        datapath_FIR_add_6_root_add_0_root_add_245_carry[2]), .CO(
        datapath_FIR_add_6_root_add_0_root_add_245_carry[3]), .S(
        datapath_FIR_S4_2_) );
  FA_X1 datapath_FIR_add_6_root_add_0_root_add_245_U1_3 ( .A(
        datapath_FIR_M3_9_), .B(datapath_FIR_M7_9_), .CI(
        datapath_FIR_add_6_root_add_0_root_add_245_carry[3]), .CO(
        datapath_FIR_add_6_root_add_0_root_add_245_carry[4]), .S(
        datapath_FIR_S4_3_) );
  FA_X1 datapath_FIR_add_6_root_add_0_root_add_245_U1_5 ( .A(
        datapath_FIR_M7_11_), .B(datapath_FIR_M3_11_), .CI(
        datapath_FIR_add_6_root_add_0_root_add_245_carry[5]), .CO(
        datapath_FIR_add_6_root_add_0_root_add_245_carry[6]), .S(
        datapath_FIR_S4_5_) );
  FA_X1 datapath_FIR_add_6_root_add_0_root_add_245_U1_6 ( .A(
        datapath_FIR_M7_12_), .B(datapath_FIR_M3_12_), .CI(
        datapath_FIR_add_6_root_add_0_root_add_245_carry[6]), .S(
        datapath_FIR_S4_6_) );
  AND2_X1 datapath_FIR_add_2_root_add_0_root_add_245_U2 ( .A1(
        datapath_FIR_S0_0_), .A2(datapath_FIR_S4_0_), .ZN(
        datapath_FIR_add_2_root_add_0_root_add_245_n2) );
  XOR2_X1 datapath_FIR_add_2_root_add_0_root_add_245_U1 ( .A(
        datapath_FIR_S0_0_), .B(datapath_FIR_S4_0_), .Z(datapath_FIR_S1_0_) );
  FA_X1 datapath_FIR_add_2_root_add_0_root_add_245_U1_1 ( .A(
        datapath_FIR_S0_1_), .B(datapath_FIR_add_2_root_add_0_root_add_245_n2), 
        .CI(datapath_FIR_S4_1_), .CO(
        datapath_FIR_add_2_root_add_0_root_add_245_carry[2]), .S(
        datapath_FIR_S1_1_) );
  FA_X1 datapath_FIR_add_2_root_add_0_root_add_245_U1_2 ( .A(
        datapath_FIR_S4_2_), .B(datapath_FIR_S0_2_), .CI(
        datapath_FIR_add_2_root_add_0_root_add_245_carry[2]), .CO(
        datapath_FIR_add_2_root_add_0_root_add_245_carry[3]), .S(
        datapath_FIR_S1_2_) );
  FA_X1 datapath_FIR_add_2_root_add_0_root_add_245_U1_3 ( .A(
        datapath_FIR_S0_3_), .B(datapath_FIR_S4_3_), .CI(
        datapath_FIR_add_2_root_add_0_root_add_245_carry[3]), .CO(
        datapath_FIR_add_2_root_add_0_root_add_245_carry[4]), .S(
        datapath_FIR_S1_3_) );
  FA_X1 datapath_FIR_add_2_root_add_0_root_add_245_U1_4 ( .A(
        datapath_FIR_S0_4_), .B(datapath_FIR_S4_4_), .CI(
        datapath_FIR_add_2_root_add_0_root_add_245_carry[4]), .CO(
        datapath_FIR_add_2_root_add_0_root_add_245_carry[5]), .S(
        datapath_FIR_S1_4_) );
  FA_X1 datapath_FIR_add_2_root_add_0_root_add_245_U1_5 ( .A(
        datapath_FIR_S0_5_), .B(datapath_FIR_S4_5_), .CI(
        datapath_FIR_add_2_root_add_0_root_add_245_carry[5]), .CO(
        datapath_FIR_add_2_root_add_0_root_add_245_carry[6]), .S(
        datapath_FIR_S1_5_) );
  FA_X1 datapath_FIR_add_2_root_add_0_root_add_245_U1_6 ( .A(
        datapath_FIR_S0_6_), .B(datapath_FIR_S4_6_), .CI(
        datapath_FIR_add_2_root_add_0_root_add_245_carry[6]), .S(
        datapath_FIR_S1_6_) );
  NOR2_X1 datapath_FIR_mult_209_U179 ( .A1(datapath_FIR_mult_209_n172), .A2(
        datapath_FIR_mult_209_n169), .ZN(datapath_FIR_mult_209_n100) );
  NAND2_X1 datapath_FIR_mult_209_U178 ( .A1(datapath_FIR_x4[2]), .A2(
        datapath_FIR_bq4[6]), .ZN(datapath_FIR_mult_209_n101) );
  NOR2_X1 datapath_FIR_mult_209_U177 ( .A1(datapath_FIR_mult_209_n161), .A2(
        datapath_FIR_mult_209_n173), .ZN(datapath_FIR_mult_209_n102) );
  NOR2_X1 datapath_FIR_mult_209_U176 ( .A1(datapath_FIR_mult_209_n162), .A2(
        datapath_FIR_mult_209_n173), .ZN(datapath_FIR_mult_209_n103) );
  NOR2_X1 datapath_FIR_mult_209_U175 ( .A1(datapath_FIR_mult_209_n165), .A2(
        datapath_FIR_mult_209_n173), .ZN(datapath_FIR_mult_209_n104) );
  NOR2_X1 datapath_FIR_mult_209_U174 ( .A1(datapath_FIR_mult_209_n166), .A2(
        datapath_FIR_mult_209_n173), .ZN(datapath_FIR_mult_209_n105) );
  NOR2_X1 datapath_FIR_mult_209_U173 ( .A1(datapath_FIR_mult_209_n168), .A2(
        datapath_FIR_mult_209_n173), .ZN(datapath_FIR_mult_209_n106) );
  NAND2_X1 datapath_FIR_mult_209_U172 ( .A1(datapath_FIR_x4[1]), .A2(
        datapath_FIR_bq4[6]), .ZN(datapath_FIR_mult_209_n108) );
  NOR2_X1 datapath_FIR_mult_209_U171 ( .A1(datapath_FIR_mult_209_n161), .A2(
        datapath_FIR_mult_209_n174), .ZN(datapath_FIR_mult_209_n109) );
  NOR2_X1 datapath_FIR_mult_209_U170 ( .A1(datapath_FIR_mult_209_n162), .A2(
        datapath_FIR_mult_209_n174), .ZN(datapath_FIR_mult_209_n110) );
  NOR2_X1 datapath_FIR_mult_209_U169 ( .A1(datapath_FIR_mult_209_n165), .A2(
        datapath_FIR_mult_209_n174), .ZN(datapath_FIR_mult_209_n111) );
  NOR2_X1 datapath_FIR_mult_209_U168 ( .A1(datapath_FIR_mult_209_n166), .A2(
        datapath_FIR_mult_209_n174), .ZN(datapath_FIR_mult_209_n112) );
  NAND2_X1 datapath_FIR_mult_209_U167 ( .A1(datapath_FIR_x4[0]), .A2(
        datapath_FIR_bq4[6]), .ZN(datapath_FIR_mult_209_n115) );
  NOR2_X1 datapath_FIR_mult_209_U166 ( .A1(datapath_FIR_mult_209_n161), .A2(
        datapath_FIR_mult_209_n175), .ZN(datapath_FIR_mult_209_n116) );
  NOR2_X1 datapath_FIR_mult_209_U165 ( .A1(datapath_FIR_mult_209_n162), .A2(
        datapath_FIR_mult_209_n175), .ZN(datapath_FIR_mult_209_n117) );
  NOR2_X1 datapath_FIR_mult_209_U164 ( .A1(datapath_FIR_mult_209_n165), .A2(
        datapath_FIR_mult_209_n175), .ZN(datapath_FIR_mult_209_n118) );
  NAND2_X1 datapath_FIR_mult_209_U163 ( .A1(datapath_FIR_bq4[4]), .A2(
        datapath_FIR_x4[3]), .ZN(datapath_FIR_mult_209_n184) );
  NAND2_X1 datapath_FIR_mult_209_U162 ( .A1(datapath_FIR_x4[5]), .A2(
        datapath_FIR_bq4[2]), .ZN(datapath_FIR_mult_209_n183) );
  NAND2_X1 datapath_FIR_mult_209_U161 ( .A1(datapath_FIR_mult_209_n184), .A2(
        datapath_FIR_mult_209_n183), .ZN(datapath_FIR_mult_209_n41) );
  XNOR2_X1 datapath_FIR_mult_209_U160 ( .A(datapath_FIR_mult_209_n183), .B(
        datapath_FIR_mult_209_n184), .ZN(datapath_FIR_mult_209_n42) );
  NAND2_X1 datapath_FIR_mult_209_U159 ( .A1(datapath_FIR_bq4[5]), .A2(
        datapath_FIR_x4[6]), .ZN(datapath_FIR_mult_209_n74) );
  NAND2_X1 datapath_FIR_mult_209_U158 ( .A1(datapath_FIR_bq4[4]), .A2(
        datapath_FIR_x4[6]), .ZN(datapath_FIR_mult_209_n75) );
  NAND2_X1 datapath_FIR_mult_209_U157 ( .A1(datapath_FIR_bq4[3]), .A2(
        datapath_FIR_x4[6]), .ZN(datapath_FIR_mult_209_n76) );
  NAND2_X1 datapath_FIR_mult_209_U156 ( .A1(datapath_FIR_bq4[2]), .A2(
        datapath_FIR_x4[6]), .ZN(datapath_FIR_mult_209_n77) );
  NAND2_X1 datapath_FIR_mult_209_U155 ( .A1(datapath_FIR_bq4[1]), .A2(
        datapath_FIR_x4[6]), .ZN(datapath_FIR_mult_209_n78) );
  NAND2_X1 datapath_FIR_mult_209_U154 ( .A1(datapath_FIR_bq4[0]), .A2(
        datapath_FIR_x4[6]), .ZN(datapath_FIR_mult_209_n79) );
  NOR4_X1 datapath_FIR_mult_209_U153 ( .A1(datapath_FIR_mult_209_n174), .A2(
        datapath_FIR_mult_209_n175), .A3(datapath_FIR_mult_209_n169), .A4(
        datapath_FIR_mult_209_n168), .ZN(datapath_FIR_mult_209_n181) );
  NOR2_X1 datapath_FIR_mult_209_U152 ( .A1(datapath_FIR_mult_209_n173), .A2(
        datapath_FIR_mult_209_n169), .ZN(datapath_FIR_mult_209_n182) );
  AOI222_X1 datapath_FIR_mult_209_U151 ( .A1(datapath_FIR_mult_209_n72), .A2(
        datapath_FIR_mult_209_n181), .B1(datapath_FIR_mult_209_n182), .B2(
        datapath_FIR_mult_209_n72), .C1(datapath_FIR_mult_209_n182), .C2(
        datapath_FIR_mult_209_n181), .ZN(datapath_FIR_mult_209_n180) );
  OAI222_X1 datapath_FIR_mult_209_U150 ( .A1(datapath_FIR_mult_209_n180), .A2(
        datapath_FIR_mult_209_n164), .B1(datapath_FIR_mult_209_n164), .B2(
        datapath_FIR_mult_209_n167), .C1(datapath_FIR_mult_209_n180), .C2(
        datapath_FIR_mult_209_n167), .ZN(datapath_FIR_mult_209_n179) );
  AOI222_X1 datapath_FIR_mult_209_U149 ( .A1(datapath_FIR_mult_209_n179), .A2(
        datapath_FIR_mult_209_n62), .B1(datapath_FIR_mult_209_n179), .B2(
        datapath_FIR_mult_209_n64), .C1(datapath_FIR_mult_209_n64), .C2(
        datapath_FIR_mult_209_n62), .ZN(datapath_FIR_mult_209_n178) );
  OAI222_X1 datapath_FIR_mult_209_U148 ( .A1(datapath_FIR_mult_209_n178), .A2(
        datapath_FIR_mult_209_n160), .B1(datapath_FIR_mult_209_n178), .B2(
        datapath_FIR_mult_209_n163), .C1(datapath_FIR_mult_209_n163), .C2(
        datapath_FIR_mult_209_n160), .ZN(datapath_FIR_mult_209_n8) );
  NAND2_X1 datapath_FIR_mult_209_U147 ( .A1(datapath_FIR_x4[5]), .A2(
        datapath_FIR_bq4[6]), .ZN(datapath_FIR_mult_209_n80) );
  NOR2_X1 datapath_FIR_mult_209_U146 ( .A1(datapath_FIR_mult_209_n161), .A2(
        datapath_FIR_mult_209_n170), .ZN(datapath_FIR_mult_209_n81) );
  NOR2_X1 datapath_FIR_mult_209_U145 ( .A1(datapath_FIR_mult_209_n162), .A2(
        datapath_FIR_mult_209_n170), .ZN(datapath_FIR_mult_209_n82) );
  NOR2_X1 datapath_FIR_mult_209_U144 ( .A1(datapath_FIR_mult_209_n165), .A2(
        datapath_FIR_mult_209_n170), .ZN(datapath_FIR_mult_209_n83) );
  NOR2_X1 datapath_FIR_mult_209_U143 ( .A1(datapath_FIR_mult_209_n168), .A2(
        datapath_FIR_mult_209_n170), .ZN(datapath_FIR_mult_209_n85) );
  NOR2_X1 datapath_FIR_mult_209_U142 ( .A1(datapath_FIR_mult_209_n169), .A2(
        datapath_FIR_mult_209_n170), .ZN(datapath_FIR_mult_209_n86) );
  NAND2_X1 datapath_FIR_mult_209_U141 ( .A1(datapath_FIR_x4[4]), .A2(
        datapath_FIR_bq4[6]), .ZN(datapath_FIR_mult_209_n87) );
  NOR2_X1 datapath_FIR_mult_209_U140 ( .A1(datapath_FIR_mult_209_n161), .A2(
        datapath_FIR_mult_209_n171), .ZN(datapath_FIR_mult_209_n88) );
  NOR2_X1 datapath_FIR_mult_209_U139 ( .A1(datapath_FIR_mult_209_n171), .A2(
        datapath_FIR_mult_209_n162), .ZN(datapath_FIR_mult_209_n89) );
  NOR2_X1 datapath_FIR_mult_209_U138 ( .A1(datapath_FIR_mult_209_n165), .A2(
        datapath_FIR_mult_209_n171), .ZN(datapath_FIR_mult_209_n90) );
  NOR2_X1 datapath_FIR_mult_209_U137 ( .A1(datapath_FIR_mult_209_n166), .A2(
        datapath_FIR_mult_209_n171), .ZN(datapath_FIR_mult_209_n91) );
  NOR2_X1 datapath_FIR_mult_209_U136 ( .A1(datapath_FIR_mult_209_n168), .A2(
        datapath_FIR_mult_209_n171), .ZN(datapath_FIR_mult_209_n92) );
  NOR2_X1 datapath_FIR_mult_209_U135 ( .A1(datapath_FIR_mult_209_n171), .A2(
        datapath_FIR_mult_209_n169), .ZN(datapath_FIR_mult_209_n93) );
  NAND2_X1 datapath_FIR_mult_209_U134 ( .A1(datapath_FIR_x4[3]), .A2(
        datapath_FIR_bq4[6]), .ZN(datapath_FIR_mult_209_n94) );
  NOR2_X1 datapath_FIR_mult_209_U133 ( .A1(datapath_FIR_mult_209_n172), .A2(
        datapath_FIR_mult_209_n161), .ZN(datapath_FIR_mult_209_n95) );
  NOR2_X1 datapath_FIR_mult_209_U132 ( .A1(datapath_FIR_mult_209_n172), .A2(
        datapath_FIR_mult_209_n165), .ZN(datapath_FIR_mult_209_n97) );
  NOR2_X1 datapath_FIR_mult_209_U131 ( .A1(datapath_FIR_mult_209_n172), .A2(
        datapath_FIR_mult_209_n166), .ZN(datapath_FIR_mult_209_n98) );
  NOR2_X1 datapath_FIR_mult_209_U130 ( .A1(datapath_FIR_mult_209_n172), .A2(
        datapath_FIR_mult_209_n168), .ZN(datapath_FIR_mult_209_n99) );
  NAND2_X1 datapath_FIR_mult_209_U129 ( .A1(datapath_FIR_bq4[6]), .A2(
        datapath_FIR_x4[6]), .ZN(datapath_FIR_mult_209_n176) );
  XNOR2_X1 datapath_FIR_mult_209_U128 ( .A(datapath_FIR_mult_209_n2), .B(
        datapath_FIR_mult_209_n13), .ZN(datapath_FIR_mult_209_n177) );
  XOR2_X1 datapath_FIR_mult_209_U127 ( .A(datapath_FIR_mult_209_n176), .B(
        datapath_FIR_mult_209_n177), .Z(datapath_FIR_M4_12_) );
  INV_X1 datapath_FIR_mult_209_U126 ( .A(datapath_FIR_x4[0]), .ZN(
        datapath_FIR_mult_209_n175) );
  INV_X1 datapath_FIR_mult_209_U125 ( .A(datapath_FIR_bq4[0]), .ZN(
        datapath_FIR_mult_209_n169) );
  INV_X1 datapath_FIR_mult_209_U124 ( .A(datapath_FIR_x4[5]), .ZN(
        datapath_FIR_mult_209_n170) );
  INV_X1 datapath_FIR_mult_209_U123 ( .A(datapath_FIR_bq4[2]), .ZN(
        datapath_FIR_mult_209_n166) );
  INV_X1 datapath_FIR_mult_209_U122 ( .A(datapath_FIR_bq4[4]), .ZN(
        datapath_FIR_mult_209_n162) );
  INV_X1 datapath_FIR_mult_209_U121 ( .A(datapath_FIR_x4[3]), .ZN(
        datapath_FIR_mult_209_n172) );
  INV_X1 datapath_FIR_mult_209_U120 ( .A(datapath_FIR_x4[2]), .ZN(
        datapath_FIR_mult_209_n173) );
  INV_X1 datapath_FIR_mult_209_U119 ( .A(datapath_FIR_x4[1]), .ZN(
        datapath_FIR_mult_209_n174) );
  INV_X1 datapath_FIR_mult_209_U118 ( .A(datapath_FIR_x4[4]), .ZN(
        datapath_FIR_mult_209_n171) );
  INV_X1 datapath_FIR_mult_209_U117 ( .A(datapath_FIR_bq4[1]), .ZN(
        datapath_FIR_mult_209_n168) );
  INV_X1 datapath_FIR_mult_209_U116 ( .A(datapath_FIR_bq4[5]), .ZN(
        datapath_FIR_mult_209_n161) );
  INV_X1 datapath_FIR_mult_209_U115 ( .A(datapath_FIR_bq4[3]), .ZN(
        datapath_FIR_mult_209_n165) );
  INV_X1 datapath_FIR_mult_209_U114 ( .A(datapath_FIR_mult_209_n68), .ZN(
        datapath_FIR_mult_209_n164) );
  INV_X1 datapath_FIR_mult_209_U113 ( .A(datapath_FIR_mult_209_n54), .ZN(
        datapath_FIR_mult_209_n160) );
  INV_X1 datapath_FIR_mult_209_U112 ( .A(datapath_FIR_mult_209_n61), .ZN(
        datapath_FIR_mult_209_n163) );
  INV_X1 datapath_FIR_mult_209_U111 ( .A(datapath_FIR_mult_209_n70), .ZN(
        datapath_FIR_mult_209_n167) );
  AND2_X1 datapath_FIR_mult_209_U110 ( .A1(datapath_FIR_bq4[1]), .A2(
        datapath_FIR_x4[1]), .ZN(datapath_FIR_mult_209_n113) );
  AND2_X1 datapath_FIR_mult_209_U109 ( .A1(datapath_FIR_bq4[2]), .A2(
        datapath_FIR_x4[0]), .ZN(datapath_FIR_mult_209_n119) );
  HA_X1 datapath_FIR_mult_209_U44 ( .A(datapath_FIR_mult_209_n113), .B(
        datapath_FIR_mult_209_n119), .CO(datapath_FIR_mult_209_n71), .S(
        datapath_FIR_mult_209_n72) );
  HA_X1 datapath_FIR_mult_209_U43 ( .A(datapath_FIR_mult_209_n100), .B(
        datapath_FIR_mult_209_n106), .CO(datapath_FIR_mult_209_n69), .S(
        datapath_FIR_mult_209_n70) );
  FA_X1 datapath_FIR_mult_209_U42 ( .A(datapath_FIR_mult_209_n112), .B(
        datapath_FIR_mult_209_n118), .CI(datapath_FIR_mult_209_n71), .CO(
        datapath_FIR_mult_209_n67), .S(datapath_FIR_mult_209_n68) );
  HA_X1 datapath_FIR_mult_209_U41 ( .A(datapath_FIR_mult_209_n93), .B(
        datapath_FIR_mult_209_n99), .CO(datapath_FIR_mult_209_n65), .S(
        datapath_FIR_mult_209_n66) );
  FA_X1 datapath_FIR_mult_209_U40 ( .A(datapath_FIR_mult_209_n105), .B(
        datapath_FIR_mult_209_n117), .CI(datapath_FIR_mult_209_n111), .CO(
        datapath_FIR_mult_209_n63), .S(datapath_FIR_mult_209_n64) );
  FA_X1 datapath_FIR_mult_209_U39 ( .A(datapath_FIR_mult_209_n66), .B(
        datapath_FIR_mult_209_n69), .CI(datapath_FIR_mult_209_n67), .CO(
        datapath_FIR_mult_209_n61), .S(datapath_FIR_mult_209_n62) );
  HA_X1 datapath_FIR_mult_209_U38 ( .A(datapath_FIR_mult_209_n86), .B(
        datapath_FIR_mult_209_n92), .CO(datapath_FIR_mult_209_n59), .S(
        datapath_FIR_mult_209_n60) );
  FA_X1 datapath_FIR_mult_209_U37 ( .A(datapath_FIR_mult_209_n98), .B(
        datapath_FIR_mult_209_n116), .CI(datapath_FIR_mult_209_n104), .CO(
        datapath_FIR_mult_209_n57), .S(datapath_FIR_mult_209_n58) );
  FA_X1 datapath_FIR_mult_209_U36 ( .A(datapath_FIR_mult_209_n65), .B(
        datapath_FIR_mult_209_n110), .CI(datapath_FIR_mult_209_n60), .CO(
        datapath_FIR_mult_209_n55), .S(datapath_FIR_mult_209_n56) );
  FA_X1 datapath_FIR_mult_209_U35 ( .A(datapath_FIR_mult_209_n58), .B(
        datapath_FIR_mult_209_n63), .CI(datapath_FIR_mult_209_n56), .CO(
        datapath_FIR_mult_209_n53), .S(datapath_FIR_mult_209_n54) );
  HA_X1 datapath_FIR_mult_209_U34 ( .A(datapath_FIR_mult_209_n97), .B(
        datapath_FIR_mult_209_n91), .CO(datapath_FIR_mult_209_n51), .S(
        datapath_FIR_mult_209_n52) );
  FA_X1 datapath_FIR_mult_209_U33 ( .A(datapath_FIR_mult_209_n85), .B(
        datapath_FIR_mult_209_n103), .CI(datapath_FIR_mult_209_n109), .CO(
        datapath_FIR_mult_209_n49), .S(datapath_FIR_mult_209_n50) );
  FA_X1 datapath_FIR_mult_209_U32 ( .A(datapath_FIR_mult_209_n79), .B(
        datapath_FIR_mult_209_n115), .CI(datapath_FIR_mult_209_n59), .CO(
        datapath_FIR_mult_209_n47), .S(datapath_FIR_mult_209_n48) );
  FA_X1 datapath_FIR_mult_209_U31 ( .A(datapath_FIR_mult_209_n57), .B(
        datapath_FIR_mult_209_n52), .CI(datapath_FIR_mult_209_n50), .CO(
        datapath_FIR_mult_209_n45), .S(datapath_FIR_mult_209_n46) );
  FA_X1 datapath_FIR_mult_209_U30 ( .A(datapath_FIR_mult_209_n48), .B(
        datapath_FIR_mult_209_n55), .CI(datapath_FIR_mult_209_n46), .CO(
        datapath_FIR_mult_209_n43), .S(datapath_FIR_mult_209_n44) );
  FA_X1 datapath_FIR_mult_209_U27 ( .A(datapath_FIR_mult_209_n102), .B(
        datapath_FIR_mult_209_n90), .CI(datapath_FIR_mult_209_n108), .CO(
        datapath_FIR_mult_209_n39), .S(datapath_FIR_mult_209_n40) );
  FA_X1 datapath_FIR_mult_209_U26 ( .A(datapath_FIR_mult_209_n51), .B(
        datapath_FIR_mult_209_n78), .CI(datapath_FIR_mult_209_n42), .CO(
        datapath_FIR_mult_209_n37), .S(datapath_FIR_mult_209_n38) );
  FA_X1 datapath_FIR_mult_209_U25 ( .A(datapath_FIR_mult_209_n47), .B(
        datapath_FIR_mult_209_n49), .CI(datapath_FIR_mult_209_n40), .CO(
        datapath_FIR_mult_209_n35), .S(datapath_FIR_mult_209_n36) );
  FA_X1 datapath_FIR_mult_209_U24 ( .A(datapath_FIR_mult_209_n45), .B(
        datapath_FIR_mult_209_n38), .CI(datapath_FIR_mult_209_n36), .CO(
        datapath_FIR_mult_209_n33), .S(datapath_FIR_mult_209_n34) );
  FA_X1 datapath_FIR_mult_209_U23 ( .A(datapath_FIR_mult_209_n83), .B(
        datapath_FIR_mult_209_n89), .CI(datapath_FIR_mult_209_n95), .CO(
        datapath_FIR_mult_209_n31), .S(datapath_FIR_mult_209_n32) );
  FA_X1 datapath_FIR_mult_209_U22 ( .A(datapath_FIR_mult_209_n77), .B(
        datapath_FIR_mult_209_n101), .CI(datapath_FIR_mult_209_n41), .CO(
        datapath_FIR_mult_209_n29), .S(datapath_FIR_mult_209_n30) );
  FA_X1 datapath_FIR_mult_209_U21 ( .A(datapath_FIR_mult_209_n32), .B(
        datapath_FIR_mult_209_n39), .CI(datapath_FIR_mult_209_n37), .CO(
        datapath_FIR_mult_209_n27), .S(datapath_FIR_mult_209_n28) );
  FA_X1 datapath_FIR_mult_209_U20 ( .A(datapath_FIR_mult_209_n35), .B(
        datapath_FIR_mult_209_n30), .CI(datapath_FIR_mult_209_n28), .CO(
        datapath_FIR_mult_209_n25), .S(datapath_FIR_mult_209_n26) );
  FA_X1 datapath_FIR_mult_209_U19 ( .A(datapath_FIR_mult_209_n82), .B(
        datapath_FIR_mult_209_n88), .CI(datapath_FIR_mult_209_n94), .CO(
        datapath_FIR_mult_209_n23), .S(datapath_FIR_mult_209_n24) );
  FA_X1 datapath_FIR_mult_209_U18 ( .A(datapath_FIR_mult_209_n31), .B(
        datapath_FIR_mult_209_n76), .CI(datapath_FIR_mult_209_n29), .CO(
        datapath_FIR_mult_209_n21), .S(datapath_FIR_mult_209_n22) );
  FA_X1 datapath_FIR_mult_209_U17 ( .A(datapath_FIR_mult_209_n27), .B(
        datapath_FIR_mult_209_n24), .CI(datapath_FIR_mult_209_n22), .CO(
        datapath_FIR_mult_209_n19), .S(datapath_FIR_mult_209_n20) );
  FA_X1 datapath_FIR_mult_209_U16 ( .A(datapath_FIR_mult_209_n87), .B(
        datapath_FIR_mult_209_n81), .CI(datapath_FIR_mult_209_n75), .CO(
        datapath_FIR_mult_209_n17), .S(datapath_FIR_mult_209_n18) );
  FA_X1 datapath_FIR_mult_209_U15 ( .A(datapath_FIR_mult_209_n18), .B(
        datapath_FIR_mult_209_n23), .CI(datapath_FIR_mult_209_n21), .CO(
        datapath_FIR_mult_209_n15), .S(datapath_FIR_mult_209_n16) );
  FA_X1 datapath_FIR_mult_209_U14 ( .A(datapath_FIR_mult_209_n74), .B(
        datapath_FIR_mult_209_n80), .CI(datapath_FIR_mult_209_n17), .CO(
        datapath_FIR_mult_209_n13), .S(datapath_FIR_mult_209_n14) );
  FA_X1 datapath_FIR_mult_209_U8 ( .A(datapath_FIR_mult_209_n44), .B(
        datapath_FIR_mult_209_n53), .CI(datapath_FIR_mult_209_n8), .CO(
        datapath_FIR_mult_209_n7), .S(datapath_FIR_M4_6_) );
  FA_X1 datapath_FIR_mult_209_U7 ( .A(datapath_FIR_mult_209_n34), .B(
        datapath_FIR_mult_209_n43), .CI(datapath_FIR_mult_209_n7), .CO(
        datapath_FIR_mult_209_n6), .S(datapath_FIR_M4_7_) );
  FA_X1 datapath_FIR_mult_209_U6 ( .A(datapath_FIR_mult_209_n26), .B(
        datapath_FIR_mult_209_n33), .CI(datapath_FIR_mult_209_n6), .CO(
        datapath_FIR_mult_209_n5), .S(datapath_FIR_M4_8_) );
  FA_X1 datapath_FIR_mult_209_U5 ( .A(datapath_FIR_mult_209_n20), .B(
        datapath_FIR_mult_209_n25), .CI(datapath_FIR_mult_209_n5), .CO(
        datapath_FIR_mult_209_n4), .S(datapath_FIR_M4_9_) );
  FA_X1 datapath_FIR_mult_209_U4 ( .A(datapath_FIR_mult_209_n16), .B(
        datapath_FIR_mult_209_n19), .CI(datapath_FIR_mult_209_n4), .CO(
        datapath_FIR_mult_209_n3), .S(datapath_FIR_M4_10_) );
  FA_X1 datapath_FIR_mult_209_U3 ( .A(datapath_FIR_mult_209_n15), .B(
        datapath_FIR_mult_209_n14), .CI(datapath_FIR_mult_209_n3), .CO(
        datapath_FIR_mult_209_n2), .S(datapath_FIR_M4_11_) );
  NOR2_X1 datapath_FIR_mult_211_U185 ( .A1(datapath_FIR_mult_211_n178), .A2(
        datapath_FIR_mult_211_n175), .ZN(datapath_FIR_mult_211_n100) );
  NAND2_X1 datapath_FIR_mult_211_U184 ( .A1(datapath_FIR_x6[2]), .A2(
        datapath_FIR_bq6[6]), .ZN(datapath_FIR_mult_211_n101) );
  NOR2_X1 datapath_FIR_mult_211_U183 ( .A1(datapath_FIR_mult_211_n167), .A2(
        datapath_FIR_mult_211_n179), .ZN(datapath_FIR_mult_211_n102) );
  NOR2_X1 datapath_FIR_mult_211_U182 ( .A1(datapath_FIR_mult_211_n168), .A2(
        datapath_FIR_mult_211_n179), .ZN(datapath_FIR_mult_211_n103) );
  NOR2_X1 datapath_FIR_mult_211_U181 ( .A1(datapath_FIR_mult_211_n171), .A2(
        datapath_FIR_mult_211_n179), .ZN(datapath_FIR_mult_211_n104) );
  NOR2_X1 datapath_FIR_mult_211_U180 ( .A1(datapath_FIR_mult_211_n172), .A2(
        datapath_FIR_mult_211_n179), .ZN(datapath_FIR_mult_211_n105) );
  NOR2_X1 datapath_FIR_mult_211_U179 ( .A1(datapath_FIR_mult_211_n174), .A2(
        datapath_FIR_mult_211_n179), .ZN(datapath_FIR_mult_211_n106) );
  NAND2_X1 datapath_FIR_mult_211_U178 ( .A1(datapath_FIR_x6[1]), .A2(
        datapath_FIR_bq6[6]), .ZN(datapath_FIR_mult_211_n108) );
  NOR2_X1 datapath_FIR_mult_211_U177 ( .A1(datapath_FIR_mult_211_n167), .A2(
        datapath_FIR_mult_211_n180), .ZN(datapath_FIR_mult_211_n109) );
  NOR2_X1 datapath_FIR_mult_211_U176 ( .A1(datapath_FIR_mult_211_n168), .A2(
        datapath_FIR_mult_211_n180), .ZN(datapath_FIR_mult_211_n110) );
  NOR2_X1 datapath_FIR_mult_211_U175 ( .A1(datapath_FIR_mult_211_n171), .A2(
        datapath_FIR_mult_211_n180), .ZN(datapath_FIR_mult_211_n111) );
  NOR2_X1 datapath_FIR_mult_211_U174 ( .A1(datapath_FIR_mult_211_n172), .A2(
        datapath_FIR_mult_211_n180), .ZN(datapath_FIR_mult_211_n112) );
  NAND2_X1 datapath_FIR_mult_211_U173 ( .A1(datapath_FIR_x6[0]), .A2(
        datapath_FIR_bq6[6]), .ZN(datapath_FIR_mult_211_n115) );
  NOR2_X1 datapath_FIR_mult_211_U172 ( .A1(datapath_FIR_mult_211_n167), .A2(
        datapath_FIR_mult_211_n181), .ZN(datapath_FIR_mult_211_n116) );
  NOR2_X1 datapath_FIR_mult_211_U171 ( .A1(datapath_FIR_mult_211_n168), .A2(
        datapath_FIR_mult_211_n181), .ZN(datapath_FIR_mult_211_n117) );
  NOR2_X1 datapath_FIR_mult_211_U170 ( .A1(datapath_FIR_mult_211_n171), .A2(
        datapath_FIR_mult_211_n181), .ZN(datapath_FIR_mult_211_n118) );
  NOR2_X1 datapath_FIR_mult_211_U169 ( .A1(datapath_FIR_mult_211_n172), .A2(
        datapath_FIR_mult_211_n181), .ZN(datapath_FIR_mult_211_n119) );
  NAND2_X1 datapath_FIR_mult_211_U168 ( .A1(datapath_FIR_bq6[4]), .A2(
        datapath_FIR_x6[3]), .ZN(datapath_FIR_mult_211_n190) );
  NAND2_X1 datapath_FIR_mult_211_U167 ( .A1(datapath_FIR_x6[5]), .A2(
        datapath_FIR_bq6[2]), .ZN(datapath_FIR_mult_211_n189) );
  NAND2_X1 datapath_FIR_mult_211_U166 ( .A1(datapath_FIR_mult_211_n190), .A2(
        datapath_FIR_mult_211_n189), .ZN(datapath_FIR_mult_211_n41) );
  XNOR2_X1 datapath_FIR_mult_211_U165 ( .A(datapath_FIR_mult_211_n189), .B(
        datapath_FIR_mult_211_n190), .ZN(datapath_FIR_mult_211_n42) );
  NAND2_X1 datapath_FIR_mult_211_U164 ( .A1(datapath_FIR_bq6[5]), .A2(
        datapath_FIR_x6[6]), .ZN(datapath_FIR_mult_211_n74) );
  NAND2_X1 datapath_FIR_mult_211_U163 ( .A1(datapath_FIR_bq6[4]), .A2(
        datapath_FIR_x6[6]), .ZN(datapath_FIR_mult_211_n75) );
  NAND2_X1 datapath_FIR_mult_211_U162 ( .A1(datapath_FIR_bq6[3]), .A2(
        datapath_FIR_x6[6]), .ZN(datapath_FIR_mult_211_n76) );
  NAND2_X1 datapath_FIR_mult_211_U161 ( .A1(datapath_FIR_bq6[2]), .A2(
        datapath_FIR_x6[6]), .ZN(datapath_FIR_mult_211_n77) );
  NAND2_X1 datapath_FIR_mult_211_U160 ( .A1(datapath_FIR_bq6[1]), .A2(
        datapath_FIR_x6[6]), .ZN(datapath_FIR_mult_211_n78) );
  NAND2_X1 datapath_FIR_mult_211_U159 ( .A1(datapath_FIR_bq6[0]), .A2(
        datapath_FIR_x6[6]), .ZN(datapath_FIR_mult_211_n79) );
  NOR4_X1 datapath_FIR_mult_211_U158 ( .A1(datapath_FIR_mult_211_n180), .A2(
        datapath_FIR_mult_211_n181), .A3(datapath_FIR_mult_211_n175), .A4(
        datapath_FIR_mult_211_n174), .ZN(datapath_FIR_mult_211_n187) );
  NOR2_X1 datapath_FIR_mult_211_U157 ( .A1(datapath_FIR_mult_211_n179), .A2(
        datapath_FIR_mult_211_n175), .ZN(datapath_FIR_mult_211_n188) );
  AOI222_X1 datapath_FIR_mult_211_U156 ( .A1(datapath_FIR_mult_211_n72), .A2(
        datapath_FIR_mult_211_n187), .B1(datapath_FIR_mult_211_n188), .B2(
        datapath_FIR_mult_211_n72), .C1(datapath_FIR_mult_211_n188), .C2(
        datapath_FIR_mult_211_n187), .ZN(datapath_FIR_mult_211_n186) );
  OAI222_X1 datapath_FIR_mult_211_U155 ( .A1(datapath_FIR_mult_211_n186), .A2(
        datapath_FIR_mult_211_n170), .B1(datapath_FIR_mult_211_n170), .B2(
        datapath_FIR_mult_211_n173), .C1(datapath_FIR_mult_211_n186), .C2(
        datapath_FIR_mult_211_n173), .ZN(datapath_FIR_mult_211_n185) );
  NAND2_X1 datapath_FIR_mult_211_U154 ( .A1(datapath_FIR_x6[5]), .A2(
        datapath_FIR_bq6[6]), .ZN(datapath_FIR_mult_211_n80) );
  NOR2_X1 datapath_FIR_mult_211_U153 ( .A1(datapath_FIR_mult_211_n167), .A2(
        datapath_FIR_mult_211_n176), .ZN(datapath_FIR_mult_211_n81) );
  NOR2_X1 datapath_FIR_mult_211_U152 ( .A1(datapath_FIR_mult_211_n168), .A2(
        datapath_FIR_mult_211_n176), .ZN(datapath_FIR_mult_211_n82) );
  NOR2_X1 datapath_FIR_mult_211_U151 ( .A1(datapath_FIR_mult_211_n171), .A2(
        datapath_FIR_mult_211_n176), .ZN(datapath_FIR_mult_211_n83) );
  NOR2_X1 datapath_FIR_mult_211_U150 ( .A1(datapath_FIR_mult_211_n174), .A2(
        datapath_FIR_mult_211_n176), .ZN(datapath_FIR_mult_211_n85) );
  NOR2_X1 datapath_FIR_mult_211_U149 ( .A1(datapath_FIR_mult_211_n175), .A2(
        datapath_FIR_mult_211_n176), .ZN(datapath_FIR_mult_211_n86) );
  NAND2_X1 datapath_FIR_mult_211_U148 ( .A1(datapath_FIR_x6[4]), .A2(
        datapath_FIR_bq6[6]), .ZN(datapath_FIR_mult_211_n87) );
  NOR2_X1 datapath_FIR_mult_211_U147 ( .A1(datapath_FIR_mult_211_n167), .A2(
        datapath_FIR_mult_211_n177), .ZN(datapath_FIR_mult_211_n88) );
  NOR2_X1 datapath_FIR_mult_211_U146 ( .A1(datapath_FIR_mult_211_n177), .A2(
        datapath_FIR_mult_211_n168), .ZN(datapath_FIR_mult_211_n89) );
  NOR2_X1 datapath_FIR_mult_211_U145 ( .A1(datapath_FIR_mult_211_n171), .A2(
        datapath_FIR_mult_211_n177), .ZN(datapath_FIR_mult_211_n90) );
  NOR2_X1 datapath_FIR_mult_211_U144 ( .A1(datapath_FIR_mult_211_n172), .A2(
        datapath_FIR_mult_211_n177), .ZN(datapath_FIR_mult_211_n91) );
  NOR2_X1 datapath_FIR_mult_211_U143 ( .A1(datapath_FIR_mult_211_n174), .A2(
        datapath_FIR_mult_211_n177), .ZN(datapath_FIR_mult_211_n92) );
  NOR2_X1 datapath_FIR_mult_211_U142 ( .A1(datapath_FIR_mult_211_n177), .A2(
        datapath_FIR_mult_211_n175), .ZN(datapath_FIR_mult_211_n93) );
  NAND2_X1 datapath_FIR_mult_211_U141 ( .A1(datapath_FIR_x6[3]), .A2(
        datapath_FIR_bq6[6]), .ZN(datapath_FIR_mult_211_n94) );
  NOR2_X1 datapath_FIR_mult_211_U140 ( .A1(datapath_FIR_mult_211_n178), .A2(
        datapath_FIR_mult_211_n167), .ZN(datapath_FIR_mult_211_n95) );
  NOR2_X1 datapath_FIR_mult_211_U139 ( .A1(datapath_FIR_mult_211_n178), .A2(
        datapath_FIR_mult_211_n171), .ZN(datapath_FIR_mult_211_n97) );
  NOR2_X1 datapath_FIR_mult_211_U138 ( .A1(datapath_FIR_mult_211_n178), .A2(
        datapath_FIR_mult_211_n172), .ZN(datapath_FIR_mult_211_n98) );
  NOR2_X1 datapath_FIR_mult_211_U137 ( .A1(datapath_FIR_mult_211_n178), .A2(
        datapath_FIR_mult_211_n174), .ZN(datapath_FIR_mult_211_n99) );
  NAND2_X1 datapath_FIR_mult_211_U136 ( .A1(datapath_FIR_bq6[6]), .A2(
        datapath_FIR_x6[6]), .ZN(datapath_FIR_mult_211_n182) );
  XNOR2_X1 datapath_FIR_mult_211_U135 ( .A(datapath_FIR_mult_211_n2), .B(
        datapath_FIR_mult_211_n13), .ZN(datapath_FIR_mult_211_n183) );
  XOR2_X1 datapath_FIR_mult_211_U134 ( .A(datapath_FIR_mult_211_n182), .B(
        datapath_FIR_mult_211_n183), .Z(datapath_FIR_M6_12_) );
  INV_X1 datapath_FIR_mult_211_U133 ( .A(datapath_FIR_x6[0]), .ZN(
        datapath_FIR_mult_211_n181) );
  INV_X1 datapath_FIR_mult_211_U132 ( .A(datapath_FIR_bq6[0]), .ZN(
        datapath_FIR_mult_211_n175) );
  INV_X1 datapath_FIR_mult_211_U131 ( .A(datapath_FIR_x6[5]), .ZN(
        datapath_FIR_mult_211_n176) );
  INV_X1 datapath_FIR_mult_211_U130 ( .A(datapath_FIR_bq6[2]), .ZN(
        datapath_FIR_mult_211_n172) );
  INV_X1 datapath_FIR_mult_211_U129 ( .A(datapath_FIR_bq6[4]), .ZN(
        datapath_FIR_mult_211_n168) );
  INV_X1 datapath_FIR_mult_211_U128 ( .A(datapath_FIR_x6[3]), .ZN(
        datapath_FIR_mult_211_n178) );
  INV_X1 datapath_FIR_mult_211_U127 ( .A(datapath_FIR_x6[2]), .ZN(
        datapath_FIR_mult_211_n179) );
  INV_X1 datapath_FIR_mult_211_U126 ( .A(datapath_FIR_x6[1]), .ZN(
        datapath_FIR_mult_211_n180) );
  INV_X1 datapath_FIR_mult_211_U125 ( .A(datapath_FIR_x6[4]), .ZN(
        datapath_FIR_mult_211_n177) );
  INV_X1 datapath_FIR_mult_211_U124 ( .A(datapath_FIR_bq6[1]), .ZN(
        datapath_FIR_mult_211_n174) );
  INV_X1 datapath_FIR_mult_211_U123 ( .A(datapath_FIR_bq6[5]), .ZN(
        datapath_FIR_mult_211_n167) );
  INV_X1 datapath_FIR_mult_211_U122 ( .A(datapath_FIR_bq6[3]), .ZN(
        datapath_FIR_mult_211_n171) );
  INV_X1 datapath_FIR_mult_211_U121 ( .A(datapath_FIR_mult_211_n68), .ZN(
        datapath_FIR_mult_211_n170) );
  INV_X1 datapath_FIR_mult_211_U120 ( .A(datapath_FIR_mult_211_n54), .ZN(
        datapath_FIR_mult_211_n166) );
  INV_X1 datapath_FIR_mult_211_U119 ( .A(datapath_FIR_mult_211_n61), .ZN(
        datapath_FIR_mult_211_n169) );
  INV_X1 datapath_FIR_mult_211_U118 ( .A(datapath_FIR_mult_211_n70), .ZN(
        datapath_FIR_mult_211_n173) );
  AND2_X1 datapath_FIR_mult_211_U117 ( .A1(datapath_FIR_bq6[1]), .A2(
        datapath_FIR_x6[1]), .ZN(datapath_FIR_mult_211_n113) );
  AND3_X1 datapath_FIR_mult_211_U116 ( .A1(datapath_FIR_mult_211_n163), .A2(
        datapath_FIR_mult_211_n164), .A3(datapath_FIR_mult_211_n165), .ZN(
        datapath_FIR_mult_211_n184) );
  NAND2_X1 datapath_FIR_mult_211_U115 ( .A1(datapath_FIR_mult_211_n64), .A2(
        datapath_FIR_mult_211_n62), .ZN(datapath_FIR_mult_211_n165) );
  NAND2_X1 datapath_FIR_mult_211_U114 ( .A1(datapath_FIR_mult_211_n185), .A2(
        datapath_FIR_mult_211_n64), .ZN(datapath_FIR_mult_211_n164) );
  NAND2_X1 datapath_FIR_mult_211_U113 ( .A1(datapath_FIR_mult_211_n185), .A2(
        datapath_FIR_mult_211_n62), .ZN(datapath_FIR_mult_211_n163) );
  NAND3_X1 datapath_FIR_mult_211_U112 ( .A1(datapath_FIR_mult_211_n160), .A2(
        datapath_FIR_mult_211_n161), .A3(datapath_FIR_mult_211_n162), .ZN(
        datapath_FIR_mult_211_n8) );
  OR2_X1 datapath_FIR_mult_211_U111 ( .A1(datapath_FIR_mult_211_n169), .A2(
        datapath_FIR_mult_211_n166), .ZN(datapath_FIR_mult_211_n162) );
  OR2_X1 datapath_FIR_mult_211_U110 ( .A1(datapath_FIR_mult_211_n184), .A2(
        datapath_FIR_mult_211_n169), .ZN(datapath_FIR_mult_211_n161) );
  OR2_X1 datapath_FIR_mult_211_U109 ( .A1(datapath_FIR_mult_211_n184), .A2(
        datapath_FIR_mult_211_n166), .ZN(datapath_FIR_mult_211_n160) );
  HA_X1 datapath_FIR_mult_211_U44 ( .A(datapath_FIR_mult_211_n113), .B(
        datapath_FIR_mult_211_n119), .CO(datapath_FIR_mult_211_n71), .S(
        datapath_FIR_mult_211_n72) );
  HA_X1 datapath_FIR_mult_211_U43 ( .A(datapath_FIR_mult_211_n100), .B(
        datapath_FIR_mult_211_n106), .CO(datapath_FIR_mult_211_n69), .S(
        datapath_FIR_mult_211_n70) );
  FA_X1 datapath_FIR_mult_211_U42 ( .A(datapath_FIR_mult_211_n112), .B(
        datapath_FIR_mult_211_n118), .CI(datapath_FIR_mult_211_n71), .CO(
        datapath_FIR_mult_211_n67), .S(datapath_FIR_mult_211_n68) );
  HA_X1 datapath_FIR_mult_211_U41 ( .A(datapath_FIR_mult_211_n93), .B(
        datapath_FIR_mult_211_n99), .CO(datapath_FIR_mult_211_n65), .S(
        datapath_FIR_mult_211_n66) );
  FA_X1 datapath_FIR_mult_211_U40 ( .A(datapath_FIR_mult_211_n105), .B(
        datapath_FIR_mult_211_n117), .CI(datapath_FIR_mult_211_n111), .CO(
        datapath_FIR_mult_211_n63), .S(datapath_FIR_mult_211_n64) );
  FA_X1 datapath_FIR_mult_211_U39 ( .A(datapath_FIR_mult_211_n66), .B(
        datapath_FIR_mult_211_n69), .CI(datapath_FIR_mult_211_n67), .CO(
        datapath_FIR_mult_211_n61), .S(datapath_FIR_mult_211_n62) );
  HA_X1 datapath_FIR_mult_211_U38 ( .A(datapath_FIR_mult_211_n86), .B(
        datapath_FIR_mult_211_n92), .CO(datapath_FIR_mult_211_n59), .S(
        datapath_FIR_mult_211_n60) );
  FA_X1 datapath_FIR_mult_211_U37 ( .A(datapath_FIR_mult_211_n98), .B(
        datapath_FIR_mult_211_n116), .CI(datapath_FIR_mult_211_n104), .CO(
        datapath_FIR_mult_211_n57), .S(datapath_FIR_mult_211_n58) );
  FA_X1 datapath_FIR_mult_211_U36 ( .A(datapath_FIR_mult_211_n65), .B(
        datapath_FIR_mult_211_n110), .CI(datapath_FIR_mult_211_n60), .CO(
        datapath_FIR_mult_211_n55), .S(datapath_FIR_mult_211_n56) );
  FA_X1 datapath_FIR_mult_211_U35 ( .A(datapath_FIR_mult_211_n58), .B(
        datapath_FIR_mult_211_n63), .CI(datapath_FIR_mult_211_n56), .CO(
        datapath_FIR_mult_211_n53), .S(datapath_FIR_mult_211_n54) );
  HA_X1 datapath_FIR_mult_211_U34 ( .A(datapath_FIR_mult_211_n97), .B(
        datapath_FIR_mult_211_n91), .CO(datapath_FIR_mult_211_n51), .S(
        datapath_FIR_mult_211_n52) );
  FA_X1 datapath_FIR_mult_211_U33 ( .A(datapath_FIR_mult_211_n85), .B(
        datapath_FIR_mult_211_n103), .CI(datapath_FIR_mult_211_n109), .CO(
        datapath_FIR_mult_211_n49), .S(datapath_FIR_mult_211_n50) );
  FA_X1 datapath_FIR_mult_211_U32 ( .A(datapath_FIR_mult_211_n79), .B(
        datapath_FIR_mult_211_n115), .CI(datapath_FIR_mult_211_n59), .CO(
        datapath_FIR_mult_211_n47), .S(datapath_FIR_mult_211_n48) );
  FA_X1 datapath_FIR_mult_211_U31 ( .A(datapath_FIR_mult_211_n57), .B(
        datapath_FIR_mult_211_n52), .CI(datapath_FIR_mult_211_n50), .CO(
        datapath_FIR_mult_211_n45), .S(datapath_FIR_mult_211_n46) );
  FA_X1 datapath_FIR_mult_211_U30 ( .A(datapath_FIR_mult_211_n48), .B(
        datapath_FIR_mult_211_n55), .CI(datapath_FIR_mult_211_n46), .CO(
        datapath_FIR_mult_211_n43), .S(datapath_FIR_mult_211_n44) );
  FA_X1 datapath_FIR_mult_211_U27 ( .A(datapath_FIR_mult_211_n102), .B(
        datapath_FIR_mult_211_n90), .CI(datapath_FIR_mult_211_n108), .CO(
        datapath_FIR_mult_211_n39), .S(datapath_FIR_mult_211_n40) );
  FA_X1 datapath_FIR_mult_211_U26 ( .A(datapath_FIR_mult_211_n51), .B(
        datapath_FIR_mult_211_n78), .CI(datapath_FIR_mult_211_n42), .CO(
        datapath_FIR_mult_211_n37), .S(datapath_FIR_mult_211_n38) );
  FA_X1 datapath_FIR_mult_211_U25 ( .A(datapath_FIR_mult_211_n47), .B(
        datapath_FIR_mult_211_n49), .CI(datapath_FIR_mult_211_n40), .CO(
        datapath_FIR_mult_211_n35), .S(datapath_FIR_mult_211_n36) );
  FA_X1 datapath_FIR_mult_211_U24 ( .A(datapath_FIR_mult_211_n45), .B(
        datapath_FIR_mult_211_n38), .CI(datapath_FIR_mult_211_n36), .CO(
        datapath_FIR_mult_211_n33), .S(datapath_FIR_mult_211_n34) );
  FA_X1 datapath_FIR_mult_211_U23 ( .A(datapath_FIR_mult_211_n83), .B(
        datapath_FIR_mult_211_n89), .CI(datapath_FIR_mult_211_n95), .CO(
        datapath_FIR_mult_211_n31), .S(datapath_FIR_mult_211_n32) );
  FA_X1 datapath_FIR_mult_211_U22 ( .A(datapath_FIR_mult_211_n77), .B(
        datapath_FIR_mult_211_n101), .CI(datapath_FIR_mult_211_n41), .CO(
        datapath_FIR_mult_211_n29), .S(datapath_FIR_mult_211_n30) );
  FA_X1 datapath_FIR_mult_211_U21 ( .A(datapath_FIR_mult_211_n32), .B(
        datapath_FIR_mult_211_n39), .CI(datapath_FIR_mult_211_n37), .CO(
        datapath_FIR_mult_211_n27), .S(datapath_FIR_mult_211_n28) );
  FA_X1 datapath_FIR_mult_211_U20 ( .A(datapath_FIR_mult_211_n35), .B(
        datapath_FIR_mult_211_n30), .CI(datapath_FIR_mult_211_n28), .CO(
        datapath_FIR_mult_211_n25), .S(datapath_FIR_mult_211_n26) );
  FA_X1 datapath_FIR_mult_211_U19 ( .A(datapath_FIR_mult_211_n82), .B(
        datapath_FIR_mult_211_n88), .CI(datapath_FIR_mult_211_n94), .CO(
        datapath_FIR_mult_211_n23), .S(datapath_FIR_mult_211_n24) );
  FA_X1 datapath_FIR_mult_211_U18 ( .A(datapath_FIR_mult_211_n31), .B(
        datapath_FIR_mult_211_n76), .CI(datapath_FIR_mult_211_n29), .CO(
        datapath_FIR_mult_211_n21), .S(datapath_FIR_mult_211_n22) );
  FA_X1 datapath_FIR_mult_211_U17 ( .A(datapath_FIR_mult_211_n27), .B(
        datapath_FIR_mult_211_n24), .CI(datapath_FIR_mult_211_n22), .CO(
        datapath_FIR_mult_211_n19), .S(datapath_FIR_mult_211_n20) );
  FA_X1 datapath_FIR_mult_211_U16 ( .A(datapath_FIR_mult_211_n87), .B(
        datapath_FIR_mult_211_n81), .CI(datapath_FIR_mult_211_n75), .CO(
        datapath_FIR_mult_211_n17), .S(datapath_FIR_mult_211_n18) );
  FA_X1 datapath_FIR_mult_211_U15 ( .A(datapath_FIR_mult_211_n18), .B(
        datapath_FIR_mult_211_n23), .CI(datapath_FIR_mult_211_n21), .CO(
        datapath_FIR_mult_211_n15), .S(datapath_FIR_mult_211_n16) );
  FA_X1 datapath_FIR_mult_211_U14 ( .A(datapath_FIR_mult_211_n74), .B(
        datapath_FIR_mult_211_n80), .CI(datapath_FIR_mult_211_n17), .CO(
        datapath_FIR_mult_211_n13), .S(datapath_FIR_mult_211_n14) );
  FA_X1 datapath_FIR_mult_211_U8 ( .A(datapath_FIR_mult_211_n44), .B(
        datapath_FIR_mult_211_n53), .CI(datapath_FIR_mult_211_n8), .CO(
        datapath_FIR_mult_211_n7), .S(datapath_FIR_M6_6_) );
  FA_X1 datapath_FIR_mult_211_U7 ( .A(datapath_FIR_mult_211_n34), .B(
        datapath_FIR_mult_211_n43), .CI(datapath_FIR_mult_211_n7), .CO(
        datapath_FIR_mult_211_n6), .S(datapath_FIR_M6_7_) );
  FA_X1 datapath_FIR_mult_211_U6 ( .A(datapath_FIR_mult_211_n26), .B(
        datapath_FIR_mult_211_n33), .CI(datapath_FIR_mult_211_n6), .CO(
        datapath_FIR_mult_211_n5), .S(datapath_FIR_M6_8_) );
  FA_X1 datapath_FIR_mult_211_U5 ( .A(datapath_FIR_mult_211_n20), .B(
        datapath_FIR_mult_211_n25), .CI(datapath_FIR_mult_211_n5), .CO(
        datapath_FIR_mult_211_n4), .S(datapath_FIR_M6_9_) );
  FA_X1 datapath_FIR_mult_211_U4 ( .A(datapath_FIR_mult_211_n16), .B(
        datapath_FIR_mult_211_n19), .CI(datapath_FIR_mult_211_n4), .CO(
        datapath_FIR_mult_211_n3), .S(datapath_FIR_M6_10_) );
  FA_X1 datapath_FIR_mult_211_U3 ( .A(datapath_FIR_mult_211_n15), .B(
        datapath_FIR_mult_211_n14), .CI(datapath_FIR_mult_211_n3), .CO(
        datapath_FIR_mult_211_n2), .S(datapath_FIR_M6_11_) );
  XOR2_X1 datapath_FIR_add_4_root_add_0_root_add_245_U2 ( .A(
        datapath_FIR_M4_6_), .B(datapath_FIR_M6_6_), .Z(datapath_FIR_S6_0_) );
  AND2_X1 datapath_FIR_add_4_root_add_0_root_add_245_U1 ( .A1(
        datapath_FIR_M4_6_), .A2(datapath_FIR_M6_6_), .ZN(
        datapath_FIR_add_4_root_add_0_root_add_245_n1) );
  FA_X1 datapath_FIR_add_4_root_add_0_root_add_245_U1_1 ( .A(
        datapath_FIR_M6_7_), .B(datapath_FIR_M4_7_), .CI(
        datapath_FIR_add_4_root_add_0_root_add_245_n1), .CO(
        datapath_FIR_add_4_root_add_0_root_add_245_carry[2]), .S(
        datapath_FIR_S6_1_) );
  FA_X1 datapath_FIR_add_4_root_add_0_root_add_245_U1_2 ( .A(
        datapath_FIR_M6_8_), .B(datapath_FIR_M4_8_), .CI(
        datapath_FIR_add_4_root_add_0_root_add_245_carry[2]), .CO(
        datapath_FIR_add_4_root_add_0_root_add_245_carry[3]), .S(
        datapath_FIR_S6_2_) );
  FA_X1 datapath_FIR_add_4_root_add_0_root_add_245_U1_3 ( .A(
        datapath_FIR_M6_9_), .B(datapath_FIR_M4_9_), .CI(
        datapath_FIR_add_4_root_add_0_root_add_245_carry[3]), .CO(
        datapath_FIR_add_4_root_add_0_root_add_245_carry[4]), .S(
        datapath_FIR_S6_3_) );
  FA_X1 datapath_FIR_add_4_root_add_0_root_add_245_U1_4 ( .A(
        datapath_FIR_M6_10_), .B(datapath_FIR_M4_10_), .CI(
        datapath_FIR_add_4_root_add_0_root_add_245_carry[4]), .CO(
        datapath_FIR_add_4_root_add_0_root_add_245_carry[5]), .S(
        datapath_FIR_S6_4_) );
  FA_X1 datapath_FIR_add_4_root_add_0_root_add_245_U1_5 ( .A(
        datapath_FIR_M6_11_), .B(datapath_FIR_M4_11_), .CI(
        datapath_FIR_add_4_root_add_0_root_add_245_carry[5]), .CO(
        datapath_FIR_add_4_root_add_0_root_add_245_carry[6]), .S(
        datapath_FIR_S6_5_) );
  FA_X1 datapath_FIR_add_4_root_add_0_root_add_245_U1_6 ( .A(
        datapath_FIR_add_4_root_add_0_root_add_245_carry[6]), .B(
        datapath_FIR_M4_12_), .CI(datapath_FIR_M6_12_), .S(datapath_FIR_S6_6_)
         );
  XOR2_X1 datapath_FIR_add_3_root_add_0_root_add_245_U2 ( .A(
        datapath_FIR_S6_0_), .B(datapath_FIR_M0_6_), .Z(datapath_FIR_S2_0_) );
  AND2_X1 datapath_FIR_add_3_root_add_0_root_add_245_U1 ( .A1(
        datapath_FIR_S6_0_), .A2(datapath_FIR_M0_6_), .ZN(
        datapath_FIR_add_3_root_add_0_root_add_245_n1) );
  FA_X1 datapath_FIR_add_3_root_add_0_root_add_245_U1_1 ( .A(
        datapath_FIR_M0_7_), .B(datapath_FIR_S6_1_), .CI(
        datapath_FIR_add_3_root_add_0_root_add_245_n1), .CO(
        datapath_FIR_add_3_root_add_0_root_add_245_carry[2]), .S(
        datapath_FIR_S2_1_) );
  FA_X1 datapath_FIR_add_3_root_add_0_root_add_245_U1_2 ( .A(
        datapath_FIR_M0_8_), .B(datapath_FIR_S6_2_), .CI(
        datapath_FIR_add_3_root_add_0_root_add_245_carry[2]), .CO(
        datapath_FIR_add_3_root_add_0_root_add_245_carry[3]), .S(
        datapath_FIR_S2_2_) );
  FA_X1 datapath_FIR_add_3_root_add_0_root_add_245_U1_3 ( .A(
        datapath_FIR_M0_9_), .B(datapath_FIR_S6_3_), .CI(
        datapath_FIR_add_3_root_add_0_root_add_245_carry[3]), .CO(
        datapath_FIR_add_3_root_add_0_root_add_245_carry[4]), .S(
        datapath_FIR_S2_3_) );
  FA_X1 datapath_FIR_add_3_root_add_0_root_add_245_U1_4 ( .A(
        datapath_FIR_M0_10_), .B(datapath_FIR_S6_4_), .CI(
        datapath_FIR_add_3_root_add_0_root_add_245_carry[4]), .CO(
        datapath_FIR_add_3_root_add_0_root_add_245_carry[5]), .S(
        datapath_FIR_S2_4_) );
  FA_X1 datapath_FIR_add_3_root_add_0_root_add_245_U1_5 ( .A(
        datapath_FIR_M0_11_), .B(datapath_FIR_S6_5_), .CI(
        datapath_FIR_add_3_root_add_0_root_add_245_carry[5]), .CO(
        datapath_FIR_add_3_root_add_0_root_add_245_carry[6]), .S(
        datapath_FIR_S2_5_) );
  FA_X1 datapath_FIR_add_3_root_add_0_root_add_245_U1_6 ( .A(
        datapath_FIR_M0_12_), .B(datapath_FIR_S6_6_), .CI(
        datapath_FIR_add_3_root_add_0_root_add_245_carry[6]), .S(
        datapath_FIR_S2_6_) );
  XOR2_X1 datapath_FIR_add_5_root_add_0_root_add_245_U2 ( .A(
        datapath_FIR_M2_6_), .B(datapath_FIR_M1_6_), .Z(datapath_FIR_S3_0_) );
  AND2_X1 datapath_FIR_add_5_root_add_0_root_add_245_U1 ( .A1(
        datapath_FIR_M2_6_), .A2(datapath_FIR_M1_6_), .ZN(
        datapath_FIR_add_5_root_add_0_root_add_245_n1) );
  FA_X1 datapath_FIR_add_5_root_add_0_root_add_245_U1_1 ( .A(
        datapath_FIR_M1_7_), .B(datapath_FIR_M2_7_), .CI(
        datapath_FIR_add_5_root_add_0_root_add_245_n1), .CO(
        datapath_FIR_add_5_root_add_0_root_add_245_carry[2]), .S(
        datapath_FIR_S3_1_) );
  FA_X1 datapath_FIR_add_5_root_add_0_root_add_245_U1_2 ( .A(
        datapath_FIR_M1_8_), .B(datapath_FIR_M2_8_), .CI(
        datapath_FIR_add_5_root_add_0_root_add_245_carry[2]), .CO(
        datapath_FIR_add_5_root_add_0_root_add_245_carry[3]), .S(
        datapath_FIR_S3_2_) );
  FA_X1 datapath_FIR_add_5_root_add_0_root_add_245_U1_3 ( .A(
        datapath_FIR_M1_9_), .B(datapath_FIR_M2_9_), .CI(
        datapath_FIR_add_5_root_add_0_root_add_245_carry[3]), .CO(
        datapath_FIR_add_5_root_add_0_root_add_245_carry[4]), .S(
        datapath_FIR_S3_3_) );
  FA_X1 datapath_FIR_add_5_root_add_0_root_add_245_U1_4 ( .A(
        datapath_FIR_M1_10_), .B(datapath_FIR_M2_10_), .CI(
        datapath_FIR_add_5_root_add_0_root_add_245_carry[4]), .CO(
        datapath_FIR_add_5_root_add_0_root_add_245_carry[5]), .S(
        datapath_FIR_S3_4_) );
  FA_X1 datapath_FIR_add_5_root_add_0_root_add_245_U1_5 ( .A(
        datapath_FIR_M1_11_), .B(datapath_FIR_M2_11_), .CI(
        datapath_FIR_add_5_root_add_0_root_add_245_carry[5]), .CO(
        datapath_FIR_add_5_root_add_0_root_add_245_carry[6]), .S(
        datapath_FIR_S3_5_) );
  FA_X1 datapath_FIR_add_5_root_add_0_root_add_245_U1_6 ( .A(
        datapath_FIR_M1_12_), .B(datapath_FIR_M2_12_), .CI(
        datapath_FIR_add_5_root_add_0_root_add_245_carry[6]), .S(
        datapath_FIR_S3_6_) );
  XOR2_X1 datapath_FIR_add_1_root_add_0_root_add_245_U8 ( .A(
        datapath_FIR_S1_0_), .B(datapath_FIR_S3_0_), .Z(datapath_FIR_S5_0_) );
  AND2_X1 datapath_FIR_add_1_root_add_0_root_add_245_U7 ( .A1(
        datapath_FIR_S1_0_), .A2(datapath_FIR_S3_0_), .ZN(
        datapath_FIR_add_1_root_add_0_root_add_245_n5) );
  NAND3_X1 datapath_FIR_add_1_root_add_0_root_add_245_U6 ( .A1(
        datapath_FIR_add_1_root_add_0_root_add_245_n2), .A2(
        datapath_FIR_add_1_root_add_0_root_add_245_n3), .A3(
        datapath_FIR_add_1_root_add_0_root_add_245_n4), .ZN(
        datapath_FIR_add_1_root_add_0_root_add_245_carry[2]) );
  NAND2_X1 datapath_FIR_add_1_root_add_0_root_add_245_U5 ( .A1(
        datapath_FIR_S3_1_), .A2(datapath_FIR_add_1_root_add_0_root_add_245_n5), .ZN(datapath_FIR_add_1_root_add_0_root_add_245_n4) );
  NAND2_X1 datapath_FIR_add_1_root_add_0_root_add_245_U4 ( .A1(
        datapath_FIR_S1_1_), .A2(datapath_FIR_add_1_root_add_0_root_add_245_n5), .ZN(datapath_FIR_add_1_root_add_0_root_add_245_n3) );
  NAND2_X1 datapath_FIR_add_1_root_add_0_root_add_245_U3 ( .A1(
        datapath_FIR_S1_1_), .A2(datapath_FIR_S3_1_), .ZN(
        datapath_FIR_add_1_root_add_0_root_add_245_n2) );
  XOR2_X1 datapath_FIR_add_1_root_add_0_root_add_245_U2 ( .A(
        datapath_FIR_S1_1_), .B(datapath_FIR_add_1_root_add_0_root_add_245_n1), 
        .Z(datapath_FIR_S5_1_) );
  XOR2_X1 datapath_FIR_add_1_root_add_0_root_add_245_U1 ( .A(
        datapath_FIR_S3_1_), .B(datapath_FIR_add_1_root_add_0_root_add_245_n5), 
        .Z(datapath_FIR_add_1_root_add_0_root_add_245_n1) );
  FA_X1 datapath_FIR_add_1_root_add_0_root_add_245_U1_2 ( .A(
        datapath_FIR_S3_2_), .B(
        datapath_FIR_add_1_root_add_0_root_add_245_carry[2]), .CI(
        datapath_FIR_S1_2_), .CO(
        datapath_FIR_add_1_root_add_0_root_add_245_carry[3]), .S(
        datapath_FIR_S5_2_) );
  FA_X1 datapath_FIR_add_1_root_add_0_root_add_245_U1_3 ( .A(
        datapath_FIR_S1_3_), .B(datapath_FIR_S3_3_), .CI(
        datapath_FIR_add_1_root_add_0_root_add_245_carry[3]), .CO(
        datapath_FIR_add_1_root_add_0_root_add_245_carry[4]), .S(
        datapath_FIR_S5_3_) );
  FA_X1 datapath_FIR_add_1_root_add_0_root_add_245_U1_4 ( .A(
        datapath_FIR_S1_4_), .B(datapath_FIR_S3_4_), .CI(
        datapath_FIR_add_1_root_add_0_root_add_245_carry[4]), .CO(
        datapath_FIR_add_1_root_add_0_root_add_245_carry[5]), .S(
        datapath_FIR_S5_4_) );
  FA_X1 datapath_FIR_add_1_root_add_0_root_add_245_U1_5 ( .A(
        datapath_FIR_S1_5_), .B(datapath_FIR_S3_5_), .CI(
        datapath_FIR_add_1_root_add_0_root_add_245_carry[5]), .CO(
        datapath_FIR_add_1_root_add_0_root_add_245_carry[6]), .S(
        datapath_FIR_S5_5_) );
  FA_X1 datapath_FIR_add_1_root_add_0_root_add_245_U1_6 ( .A(
        datapath_FIR_S1_6_), .B(datapath_FIR_S3_6_), .CI(
        datapath_FIR_add_1_root_add_0_root_add_245_carry[6]), .S(
        datapath_FIR_S5_6_) );
  AND2_X1 datapath_FIR_add_0_root_add_0_root_add_245_U8 ( .A1(
        datapath_FIR_S5_0_), .A2(datapath_FIR_S2_0_), .ZN(
        datapath_FIR_add_0_root_add_0_root_add_245_n6) );
  XOR2_X1 datapath_FIR_add_0_root_add_0_root_add_245_U7 ( .A(
        datapath_FIR_S5_0_), .B(datapath_FIR_S2_0_), .Z(datapath_FIR_Y[0]) );
  NAND3_X1 datapath_FIR_add_0_root_add_0_root_add_245_U6 ( .A1(
        datapath_FIR_add_0_root_add_0_root_add_245_n2), .A2(
        datapath_FIR_add_0_root_add_0_root_add_245_n3), .A3(
        datapath_FIR_add_0_root_add_0_root_add_245_n4), .ZN(
        datapath_FIR_add_0_root_add_0_root_add_245_carry[6]) );
  NAND2_X1 datapath_FIR_add_0_root_add_0_root_add_245_U5 ( .A1(
        datapath_FIR_S5_5_), .A2(datapath_FIR_S2_5_), .ZN(
        datapath_FIR_add_0_root_add_0_root_add_245_n4) );
  NAND2_X1 datapath_FIR_add_0_root_add_0_root_add_245_U4 ( .A1(
        datapath_FIR_add_0_root_add_0_root_add_245_carry[5]), .A2(
        datapath_FIR_S2_5_), .ZN(datapath_FIR_add_0_root_add_0_root_add_245_n3) );
  NAND2_X1 datapath_FIR_add_0_root_add_0_root_add_245_U3 ( .A1(
        datapath_FIR_add_0_root_add_0_root_add_245_carry[5]), .A2(
        datapath_FIR_S5_5_), .ZN(datapath_FIR_add_0_root_add_0_root_add_245_n2) );
  XOR2_X1 datapath_FIR_add_0_root_add_0_root_add_245_U2 ( .A(
        datapath_FIR_add_0_root_add_0_root_add_245_carry[5]), .B(
        datapath_FIR_add_0_root_add_0_root_add_245_n1), .Z(datapath_FIR_Y[5])
         );
  XOR2_X1 datapath_FIR_add_0_root_add_0_root_add_245_U1 ( .A(
        datapath_FIR_S5_5_), .B(datapath_FIR_S2_5_), .Z(
        datapath_FIR_add_0_root_add_0_root_add_245_n1) );
  FA_X1 datapath_FIR_add_0_root_add_0_root_add_245_U1_1 ( .A(
        datapath_FIR_S2_1_), .B(datapath_FIR_add_0_root_add_0_root_add_245_n6), 
        .CI(datapath_FIR_S5_1_), .CO(
        datapath_FIR_add_0_root_add_0_root_add_245_carry[2]), .S(
        datapath_FIR_Y[1]) );
  FA_X1 datapath_FIR_add_0_root_add_0_root_add_245_U1_2 ( .A(
        datapath_FIR_S2_2_), .B(datapath_FIR_S5_2_), .CI(
        datapath_FIR_add_0_root_add_0_root_add_245_carry[2]), .CO(
        datapath_FIR_add_0_root_add_0_root_add_245_carry[3]), .S(
        datapath_FIR_Y[2]) );
  FA_X1 datapath_FIR_add_0_root_add_0_root_add_245_U1_3 ( .A(
        datapath_FIR_S5_3_), .B(datapath_FIR_S2_3_), .CI(
        datapath_FIR_add_0_root_add_0_root_add_245_carry[3]), .CO(
        datapath_FIR_add_0_root_add_0_root_add_245_carry[4]), .S(
        datapath_FIR_Y[3]) );
  FA_X1 datapath_FIR_add_0_root_add_0_root_add_245_U1_4 ( .A(
        datapath_FIR_S2_4_), .B(datapath_FIR_S5_4_), .CI(
        datapath_FIR_add_0_root_add_0_root_add_245_carry[4]), .CO(
        datapath_FIR_add_0_root_add_0_root_add_245_carry[5]), .S(
        datapath_FIR_Y[4]) );
  FA_X1 datapath_FIR_add_0_root_add_0_root_add_245_U1_6 ( .A(
        datapath_FIR_S5_6_), .B(datapath_FIR_S2_6_), .CI(
        datapath_FIR_add_0_root_add_0_root_add_245_carry[6]), .S(
        datapath_FIR_Y[6]) );
  AND2_X1 control_unit_FIR_U15 ( .A1(reg_out_en), .A2(VIN), .ZN(
        control_unit_FIR_next_state[2]) );
  NOR2_X1 control_unit_FIR_U14 ( .A1(control_unit_FIR_present_state[0]), .A2(
        control_unit_FIR_n12), .ZN(VOUT) );
  NAND2_X1 control_unit_FIR_U13 ( .A1(VIN), .A2(control_unit_FIR_n8), .ZN(
        control_unit_FIR_n10) );
  INV_X1 control_unit_FIR_U12 ( .A(reg_out_en), .ZN(control_unit_FIR_n5) );
  NAND2_X1 control_unit_FIR_U11 ( .A1(control_unit_FIR_n11), .A2(
        control_unit_FIR_n7), .ZN(control_unit_FIR_n9) );
  OAI22_X1 control_unit_FIR_U10 ( .A1(VIN), .A2(control_unit_FIR_n5), .B1(
        control_unit_FIR_n9), .B2(control_unit_FIR_n10), .ZN(
        control_unit_FIR_next_state[1]) );
  XNOR2_X1 control_unit_FIR_U9 ( .A(control_unit_FIR_n7), .B(
        control_unit_FIR_n4), .ZN(control_unit_FIR_n11) );
  AND3_X1 control_unit_FIR_U8 ( .A1(control_unit_FIR_present_state[0]), .A2(
        control_unit_FIR_n4), .A3(control_unit_FIR_n1), .ZN(reg_coeff_en) );
  INV_X1 control_unit_FIR_U7 ( .A(control_unit_FIR_n8), .ZN(
        control_unit_FIR_n6) );
  NAND2_X1 control_unit_FIR_U6 ( .A1(control_unit_FIR_present_state[1]), .A2(
        control_unit_FIR_present_state[0]), .ZN(control_unit_FIR_n7) );
  INV_X1 control_unit_FIR_U5 ( .A(control_unit_FIR_n7), .ZN(
        control_unit_FIR_n3) );
  NOR2_X1 control_unit_FIR_U3 ( .A1(control_unit_FIR_n8), .A2(
        control_unit_FIR_n11), .ZN(reg_out_en) );
  XOR2_X1 control_unit_FIR_U18 ( .A(control_unit_FIR_present_state[1]), .B(
        control_unit_FIR_n4), .Z(control_unit_FIR_n12) );
  XOR2_X1 control_unit_FIR_U17 ( .A(control_unit_FIR_present_state[0]), .B(
        control_unit_FIR_present_state[1]), .Z(control_unit_FIR_n8) );
  NAND3_X1 control_unit_FIR_U16 ( .A1(control_unit_FIR_n7), .A2(
        control_unit_FIR_n4), .A3(control_unit_FIR_n6), .ZN(reg_rst_n) );
  DFFR_X1 control_unit_FIR_present_state_reg_2_ ( .D(
        control_unit_FIR_next_state[2]), .CK(clk), .RN(rst_n), .QN(
        control_unit_FIR_n4) );
  DFFR_X1 control_unit_FIR_present_state_reg_1_ ( .D(
        control_unit_FIR_next_state[1]), .CK(clk), .RN(rst_n), .Q(
        control_unit_FIR_present_state[1]), .QN(control_unit_FIR_n1) );
  SDFFR_X1 control_unit_FIR_present_state_reg_0_ ( .D(control_unit_FIR_n4), 
        .SI(1'b0), .SE(control_unit_FIR_n3), .CK(clk), .RN(rst_n), .Q(
        control_unit_FIR_present_state[0]) );
endmodule

