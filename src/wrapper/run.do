# To use this file, you need to enter parameters in to the do file, to do that, write the following:
# vsim -do "source run.do;start -simulate -(other parameters)

# -simulate is simulates and compiles
# -uvm simulates using uvm libraies and inputs if signals if no wave.do is inputted
# -cli is used to allow for -c or -batch to work properly, if you don't want the GUI to open
# -wavefile runs a wave.do
# -nowave does as the name specifies
# if -uvm is detected it will load in the if signals
# -exclude runs exclutions.do (you paste in the exclutions yourself)
# -cover_report outputs a function report and a code report 
# -quitafter closes simulation right after finishing, $finish won't be bypassed. I recommend using $stop instead

# NOTE: Reports don't work with -c or -batch
# NOTE: You may need to make some manual changes by yourself to fix some naming or path inconsitancies




set design {src/SPI_slave.v wrapper}
set tb {tb/spi_tb.sv spi_tb}
set extra_compile {}

proc start {args} {  

    global design tb extra_compile

    if {[lsearch -exact $args -simulate] >= 0} {
        vlib work
        if {[lsearch -exact $args -uvm] >= 0} {
            vlog -f src_files.list +cover -covercells
            vsim -voptargs=+acc work.[lindex $design 1]_top -classdebug -uvmcontrol=all -cover
        } else {
            vlog {*}$extra_compile [lindex $design 0] [lindex $tb 0] +cover -covercells
            vsim -voptargs=+acc work.[lindex $tb 1] -cover
        }

        # You still need to write it -c or -batch while you vsim the .do file
        if {[lsearch -exact $args -cli] <= 0} {
            layout load MyLayout
        }

    }

    if {[lsearch -exact $args -wavefile] >= 0} {
        do wave.do
    } elseif {[lsearch -exact $args -nowave] >= 0} {
        # Does nothing
    } elseif {[lsearch -exact $args -uvm] >= 0} {
        add wave /[lindex $design 1]_top/[lindex $design 1]_if/*
        radix unsigned
    } else {
        add wave *
        radix unsigned
    }

    run -all

    if {[lsearch -exact $args -exclude] >= 0} {
        do exclutions.do
    }

    if {[lsearch -exact $args -cover_report] >= 0} {

        coverage report -detail -cvg -directive -comments -option -output reports/[lindex $tb 1]_fcover_report.txt
        echo "Wrote the function coverage report in sim/[lindex $tb 1]_fcover_report.txt"
        coverage report -output reports/[lindex $tb 1]_codecover_report.txt -du=WRAPPER -du=RAM -du=SLAVE -detail -all -dump -annotate -assert -directive -cvg -codeAll
        echo "Wrote the code coverage report in sim/[lindex $tb 1]_codecover_report.txt"

    }

    if {[lsearch -exact $args -quitafter] >= 0} {
        quit -force
    }

}
