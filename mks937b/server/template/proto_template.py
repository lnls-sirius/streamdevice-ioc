from string import Template

mks937b_pressures_proto = Template(
"""LockTimeout  = 10000;
Terminator   = ';FF';
ReplyTimeout = 4000; 
ReadTimeout  = 5000;   
extrainput   = Ignore;

# Delay between commands
Delay = 7;

# The serial address
Addr = "@\$1";

@init{out " ";}
 
get_pressures {
    wait  $Delay;
    out $Addr, "PRZ?";
    in  $Addr, "ACK",
                "%(${G1}:Pressure-Mon-s)s",
                " %(${G2}:Pressure-Mon-s)s",
                " %(${G3}:Pressure-Mon-s)s",
                " %(${G4}:Pressure-Mon-s)s",
                " %(${G5}:Pressure-Mon-s)s",
                " %(${G6}:Pressure-Mon-s)s";
    wait  $Delay;
}

""")