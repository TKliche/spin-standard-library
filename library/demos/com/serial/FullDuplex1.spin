{{
Object file:    FullDuplexSerial_Test1.spin
Version:        1.2
Date:           2006 - 2014
Author:         Daniel Harris
Company:        Parallax Semiconductor
Email:          dharris@parallaxsemiconductor.com
Licensing:      MIT License - see end of file for terms of use.

Description:
This is a very simple demonstration of the FullDuplexSerial object.  It starts
the object, waits 1 second, prints two lines to the terminal, waits 1 more
second, and then shuts down.  It starts a serial port on Propeller pins P30-P31;
these pins are usually used by the Propeller to communicate with a terminal,
though any two pins can be used.  To see the results, set your serial terminal
to receive data at 9600 baud.

Revision History:
v1.2 - 8/5/2014  Rearranged waitcnt arguments by convention
v1.1 - 5/1/2011  Original test file

 
=============================================
        Connection Diagram
=============================================

        ┌─────────┐   
        │         │         
        │      P30├─── Propeller's TX line
        │      P31├─── Propeller's RX line
        │         │   
        └─────────┘           
         Propeller
            MCU
          (P8X32A)

          
Components:
N/A
=============================================  
}}
CON

  'Set up the clock mode
  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000
  '5 MHz clock * 16x PLL = 80 MHz system clock speed

VAR

  'Globally accessible variables

  
OBJ

  'in leiu of Parallax Serial Terminal, FullDuplexSerial is being used to communicate with the terminal
  serial        : "com.serial.fullduplex"

  
PUB Main
{{
  Starts execution of FullDuplexSerialTest1.spin

  This is a very simple test.  It starts the object, waits 1 second, prints two
  lines to the terminal, waits 1 more second, then shuts down.  Set your terminal
  to a baud rate of 9600 baud to see the output.
  
  parameters:    none
  return:        none
  
  example usage: N/A - executes on startup

}}

  'start the FullDuplexSerial object
  serial.Start(31, 30, %0000, 9_600)                    'requires 1 cog for operation

  waitcnt((1 * clkfreq) + cnt)                          'wait 1 second for the serial object to start
  
  serial.Str(STRING("Testing the FullDuplexSerial object."))     'print a test string
  serial.Tx($0D)                                                 'print a new line
  
  serial.Str(STRING("All Done!"))

  waitcnt((1 * clkfreq) + cnt)                          'wait 1 second for the serial object to finish printing
  
  serial.Stop                                           'Stop the object


DAT
{{
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                   TERMS OF USE: MIT License                                                  │                                                            
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation    │ 
│files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,    │
│modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software│
│is furnished to do so, subject to the following conditions:                                                                   │
│                                                                                                                              │
│The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.│
│                                                                                                                              │
│THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE          │
│WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR         │
│COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,   │
│ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                         │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
}}
