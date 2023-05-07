module rst_clk_ctrl_tb;

    reg         clk_ref = 0;
    reg         xrst_n = 1;
    reg         pll_en;
    reg         sel_8mhz;
    reg         sel_8x;
    reg         sel_pll;
    reg         sel_xclk;
    reg [1:0]   sel_rosc;
    reg [1:0] 	pll_trim;
    reg [1:0]   clk_div;
    wire        clk;
    wire        rst_n;
    wire        por_n;

    reg         VGND, 
                VPWR = 0;

    initial begin
        $dumpfile("rst_clk_ctrl_tb.vcd");
        $dumpvars;
    end

    rst_clk_ctrl muv (
        .VPWR(VPWR),
        .VGND(VGND),
        .clk_ref(clk_ref),
        .xrst_n(xrst_n),
        .pll_en(pll_en),
        .sel_8mhz(sel_8mhz),
        .sel_xclk(sel_xclk),
        .sel_pll(sel_pll),
        .sel_rosc(sel_rosc),
        .pll_trim(pll_trim),
        .clk_div(clk_div),
        .clk(clk),
        .rst_n(rst_n),
        .por_n(por_n)
    );

    initial begin
        //$display("Loading SDF for por_rosc");
        $sdf_annotate("./views/sdf/por_rosc.sdf", muv.PoR);
        //$display("Loading SDF for freq_mul");
        $sdf_annotate("./views/sdf/freq_mul_x8.sdf", muv.PLL);
    end

    // Power up;
    initial #25 VPWR = 1;
    initial #20 VGND = 0;
    // Initializations
    initial begin
        pll_en = 0;
        pll_trim = 0;
        sel_8mhz = 1;
        sel_xclk = 1;
        clk_div = 0;

    end
    // Ref. Clock generator
    // 5 MHz
    initial begin
        # 33;
        forever begin
            #100 clk_ref = !clk_ref;
        end
    end

    // always #100 clk_ref = !clk_ref;

    // External Reset Generator
    event ext_rst;
    always @(ext_rst) begin
        xrst_n = 1'b0;
        #(1000+$random & 12'hFFF);
        xrst_n = 1'b1;
    end
        
    initial begin
        -> ext_rst;
        #50_000 $finish;
    end

    always @(posedge clk or negedge rst_n)
    if(!rst_n) begin
        pll_en = 0;
        pll_trim = 2'b11;
        sel_8mhz = 1;
        sel_pll = 0;
        clk_div = 0;
        sel_rosc = 0;
    end

    // fix the loopback issues of the eing oscillators
    initial begin
        force muv.PoR.fb_in = 0;
        force muv.PoR._002_ = 0;
        force muv.PoR._003_ = 0;
        force muv.PoR._004_ = 0;
        force muv.PoR._005_ = 0;
        force muv.PoR._006_ = 0;
        force muv.PoR._007_ = 0;
        force muv.PoR._008_ = 0;
        force muv.PoR._009_ = 0;
        force muv.PoR.\shift_reg0[0] = 0;
        force muv.PoR.\shift_reg0[1] = 0;
        force muv.PoR.\shift_reg0[2] = 0;
        force muv.PoR.\shift_reg0[3] = 0;
        force muv.PoR.\shift_reg0[4] = 0;
        force muv.PoR.\shift_reg0[5] = 0;
        force muv.PoR.\shift_reg0[6] = 0;
        force muv.PoR.\shift_reg0[7] = 0;
        force muv.PoR.\shift_reg0[8] = 0;
        force muv.PoR.\shift_reg0[9] = 0;
        force muv.PoR.\shift_reg0[10] = 0;
        force muv.PoR.\shift_reg0[11] = 0;
        force muv.PoR.\shift_reg0[12] = 0;
        force muv.PoR.\shift_reg0[13] = 0;
        force muv.PoR.\shift_reg0[14] = 0;
        force muv.PoR.\shift_reg0[15] = 0;

        force muv.PoR.\shift_reg1[0] = 0;
        force muv.PoR.\shift_reg1[1] = 0;
        force muv.PoR.\shift_reg1[2] = 0;
        force muv.PoR.\shift_reg1[3] = 0;
        force muv.PoR.\shift_reg1[4] = 0;
        force muv.PoR.\shift_reg1[5] = 0;
        force muv.PoR.\shift_reg1[6] = 0;
        force muv.PoR.\shift_reg1[7] = 0;
        force muv.PoR.\shift_reg1[8] = 0;
        force muv.PoR.\shift_reg1[9] = 0;
        force muv.PoR.\shift_reg1[10] = 0;
        force muv.PoR.\shift_reg1[11] = 0;
        force muv.PoR.\shift_reg1[12] = 0;
        force muv.PoR.\shift_reg1[13] = 0;
        force muv.PoR.\shift_reg1[14] = 0;
        force muv.PoR.\shift_reg1[15] = 0;

        force muv.PoR.\shift_reg2[0] = 0;
        force muv.PoR.\shift_reg2[1] = 0;
        force muv.PoR.\shift_reg2[2] = 0;
        force muv.PoR.\shift_reg2[3] = 0;
        force muv.PoR.\shift_reg2[4] = 0;
        force muv.PoR.\shift_reg2[5] = 0;
        force muv.PoR.\shift_reg2[6] = 0;
        force muv.PoR.\shift_reg2[7] = 0;
        force muv.PoR.\shift_reg2[8] = 0;
        force muv.PoR.\shift_reg2[9] = 0;
        force muv.PoR.\shift_reg2[10] = 0;
        force muv.PoR.\shift_reg2[11] = 0;
        force muv.PoR.\shift_reg2[12] = 0;
        force muv.PoR.\shift_reg2[13] = 0;
        force muv.PoR.\shift_reg2[14] = 0;
        force muv.PoR.\shift_reg2[15] = 0;

        force muv.PoR.\shift_reg3[0] = 0;
        force muv.PoR.\shift_reg3[1] = 0;
        force muv.PoR.\shift_reg3[2] = 0;
        force muv.PoR.\shift_reg3[3] = 0;
        force muv.PoR.\shift_reg3[4] = 0;
        force muv.PoR.\shift_reg3[5] = 0;
        force muv.PoR.\shift_reg3[6] = 0;
        force muv.PoR.\shift_reg3[7] = 0;
        force muv.PoR.\shift_reg3[8] = 0;
        force muv.PoR.\shift_reg3[9] = 0;
        force muv.PoR.\shift_reg3[10] = 0;
        force muv.PoR.\shift_reg3[11] = 0;
        force muv.PoR.\shift_reg3[12] = 0;
        force muv.PoR.\shift_reg3[13] = 0;
        force muv.PoR.\shift_reg3[14] = 0;
        force muv.PoR.\shift_reg3[15] = 0;

        #100;
        release muv.PoR.fb_in;
        
        #100;       // wait till th eclk_div register is clocked and got a good value.
        release muv.PoR._002_;
        release muv.PoR._003_;
        release muv.PoR._004_;
        release muv.PoR._005_;
        release muv.PoR._006_;
        release muv.PoR._007_;
        release muv.PoR._008_;
        release muv.PoR._009_;

        #1_500;

        release muv.PoR.\shift_reg0[0] ;
        release muv.PoR.\shift_reg0[1] ;
        release muv.PoR.\shift_reg0[2] ;
        release muv.PoR.\shift_reg0[3] ;
        release muv.PoR.\shift_reg0[4] ;
        release muv.PoR.\shift_reg0[5] ;
        release muv.PoR.\shift_reg0[6] ;
        release muv.PoR.\shift_reg0[7] ;
        release muv.PoR.\shift_reg0[8] ;
        release muv.PoR.\shift_reg0[9] ;
        release muv.PoR.\shift_reg0[10] ;
        release muv.PoR.\shift_reg0[11] ;
        release muv.PoR.\shift_reg0[12] ;
        release muv.PoR.\shift_reg0[13] ;
        release muv.PoR.\shift_reg0[14] ;
        release muv.PoR.\shift_reg0[15] ;
   
        release muv.PoR.\shift_reg1[0] ;
        release muv.PoR.\shift_reg1[1] ;
        release muv.PoR.\shift_reg1[2] ;
        release muv.PoR.\shift_reg1[3] ;
        release muv.PoR.\shift_reg1[4] ;
        release muv.PoR.\shift_reg1[5] ;
        release muv.PoR.\shift_reg1[6] ;
        release muv.PoR.\shift_reg1[7] ;
        release muv.PoR.\shift_reg1[8] ;
        release muv.PoR.\shift_reg1[9] ;
        release muv.PoR.\shift_reg1[10] ;
        release muv.PoR.\shift_reg1[11] ;
        release muv.PoR.\shift_reg1[12] ;
        release muv.PoR.\shift_reg1[13] ;
        release muv.PoR.\shift_reg1[14] ;
        release muv.PoR.\shift_reg1[15] ;

        release muv.PoR.\shift_reg2[0] ;
        release muv.PoR.\shift_reg2[1] ;
        release muv.PoR.\shift_reg2[2] ;
        release muv.PoR.\shift_reg2[3] ;
        release muv.PoR.\shift_reg2[4] ;
        release muv.PoR.\shift_reg2[5] ;
        release muv.PoR.\shift_reg2[6] ;
        release muv.PoR.\shift_reg2[7] ;
        release muv.PoR.\shift_reg2[8] ;
        release muv.PoR.\shift_reg2[9] ;
        release muv.PoR.\shift_reg2[10] ;
        release muv.PoR.\shift_reg2[11] ;
        release muv.PoR.\shift_reg2[12] ;
        release muv.PoR.\shift_reg2[13] ;
        release muv.PoR.\shift_reg2[14] ;
        release muv.PoR.\shift_reg2[15] ;

        release muv.PoR.\shift_reg3[0] ;
        release muv.PoR.\shift_reg3[1] ;
        release muv.PoR.\shift_reg3[2] ;
        release muv.PoR.\shift_reg3[3] ;
        release muv.PoR.\shift_reg3[4] ;
        release muv.PoR.\shift_reg3[5] ;
        release muv.PoR.\shift_reg3[6] ;
        release muv.PoR.\shift_reg3[7] ;
        release muv.PoR.\shift_reg3[8] ;
        release muv.PoR.\shift_reg3[9] ;
        release muv.PoR.\shift_reg3[10] ;
        release muv.PoR.\shift_reg3[11] ;
        release muv.PoR.\shift_reg3[12] ;
        release muv.PoR.\shift_reg3[13] ;
        release muv.PoR.\shift_reg3[14] ;
        release muv.PoR.\shift_reg3[15] ;
    end
    // Test 1
    initial begin
        // Wait for rst_n to be deassarted then enable the PLL
        @(posedge rst_n);
        @(posedge clk);
        
        #1_000;
        // change the frequency using the rosc
        @(posedge clk);
        sel_rosc = 3;
        sel_pll = 0;
        sel_8mhz = 0;
        #1_000;
        @(posedge clk);
        sel_rosc = 1;
        #1_000;
        // Switch to the external clock
        @(posedge clk);
        sel_8mhz = 1;
        #500;
        @(posedge clk);
        sel_xclk = 1;
        #500;
        @(posedge clk);
        sel_8mhz = 0;
        // Enable the PLL
        @(posedge clk);
        pll_en = 1;
        #1_000;
        
        // change the PLL trim 
        @(posedge clk);
        sel_8mhz = 1;
        #100;
        @(posedge clk);
        pll_trim = 2'b10;
        #100;
        
        // Adjust the muxes to assign the system clock to the pll clock
        @(posedge clk);
        sel_8mhz = 1;
        @(posedge clk);
        sel_pll = 1;
        sel_xclk = 0;
        #500;
        @(posedge clk);
        sel_8mhz = 0;
        #1000;
        
        

        // Make the system clock = pll_clk/2
        @(posedge clk);
        clk_div = 1;
        #1000;
        // Generate 128MHz out of the Ring Osc.
        @(posedge clk);
        sel_rosc = 0;
        // Make system clock = ROSC Clock / 2 (64 MHz)
        @(posedge clk);
        sel_pll = 0;
        #500;
        // Make system clock = ROSC Clock (128 MHz)
        @(posedge clk);
        clk_div = 0;
        #500;
        // Make system clock = ROSC Clock / 8 (16 MHz)
        @(posedge clk);
        clk_div = 3;
        #500;
        // Lower the ROSC Freq
        @(posedge clk);
        sel_rosc = 3;
        #1000;
        // Reset
        -> ext_rst;

        #1000;
        $display("SOne!");
        
    end

endmodule