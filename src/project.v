/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */
`default_nettype none

module tt_um_SUMADOR (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    
  wire sl, cl, s2; 
    
  XOR U1 (.OUT(sl), .A(ui_in[0]), .B(ui_in[1]));      //  ui_in[0]  ES LA ENTRADA A
  AND U2 (.OUT(cl), .A(ui_in[0]), .B(ui_in[1]));      //  ui_in[1]  ES LA ENTRADA B
  XOR U3 (.OUT(uo_out[0]), .A(sl), .B(ui_in[2]));     //  ui_in[2]  ES EL CARRY DE ENTRADA (C_IN)
  AND U4 (.OUT(s2), .A(sl), .B(ui_in[2]));           //  uo_out[0] ES EL RESULTADO DE LA SUMA
  XOR U5 (.OUT(uo_out[1]), .A(s2), .B(cl));           //  uo_out[1] ES EL CARRY DE SALIDA (C_OUT)
    
    assign uo_out [7:2] = 6'b0; // LAS SALIDAS DEDICADAS QUE NO SE UTILIZAN SE MANDAN A 0 (SON 6 SALIDAS QUE NO SE USAN)
    assign uio_out [7:0] = 8'b0; // LAS I/O QUE NO SE UTILIZAN SE MANDAN A 0 (SON 8 I/O QUE NO SE USAN)
    assign uio_oe [7:0] = 8'b0;  // LAS I/O QUE NO SE UTILIZAN SE MANDAN A 0 (SON 8 SALIDAS QUE NO SE USAN)

  // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n, ui_in [7:3], uio_in [7:0], 1'b0};
endmodule
