module wrapper_sva(
    wrapper_if.SVA wrapper_iff
);
    
    property rst_p;
        @(posedge wrapper_iff.clk) !wrapper_iff.rst_n |=> !wrapper_iff.MISO;
    endproperty : rst_p

    property miso_p;
        @(posedge wrapper_iff.clk) $fell(wrapper_iff.SS_n) |=> 
        not(wrapper_iff.MOSI |=> wrapper_iff.MOSI |=> wrapper_iff.MOSI and !$stable(wrapper_iff.MISO)[*13]);
    endproperty : miso_p
    
    asrt_rst : assert property ( rst_p );
    covr_rst : cover property ( rst_p );

    asrt_miso : assert property ( miso_p );
    covr_miso : cover property ( miso_p );

endmodule
