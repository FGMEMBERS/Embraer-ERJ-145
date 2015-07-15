# Chronograph #############

# One button elapsed counter

print("Initializing Chronograph.........................................") ;

var chrono_onoff = props.globals.getNode("instrumentation/clock/chronometer-on",1);
var reset_state = props.globals.getNode("instrumentation/clock/reset-state",1);
var elapsed_sec = props.globals.getNode("instrumentation/clock/elapsed-sec", 1);
# var indicated_sec = props.globals.getNode("instrumentation/clock/indicated-sec",1);
var indicated_sec = props.globals.getNode("sim/time/utc/day-seconds",1);

var indicated_chr_sec = props.globals.initNode("instrumentation/clock/indicated-chr-sec",0,"INT");
var indicated_chr_min = props.globals.initNode("instrumentation/clock/indicated-chr-min",0,"INT");
var indicated_chr_ref_sec = props.globals.initNode("instrumentation/clock/indicated-chr-ref-sec",0,"INT");

aircraft.data.add("/instrumentation/clock/offset-sec");

chrono_onoff.setBoolValue( 0 );
reset_state.setBoolValue( 1 );
elapsed_sec.setValue( 0 );
var offset = 0;

var click = func {
	var on = chrono_onoff.getBoolValue();
	var reset = reset_state.getBoolValue();
	if ( ! on ) {
		if ( ! reset ) {
			# Had been former started and stoped, now, has to be reset.
			offset = 0;
			elapsed_sec.setValue( 0 );
			reset_state.setBoolValue( 1 );
			
			indicated_chr_min.setValue( 0 );
			indicated_chr_sec.setValue( 0 );
			
		} else {
			# Is not started but allready reset, start it.
			chrono_onoff.setBoolValue( 1 );
			reset_state.setBoolValue( 0 );
			offset = indicated_sec.getValue();
			
			var basal = indicated_sec.getValue() ;
			indicated_chr_ref_sec.setValue( basal );
		}
	} else {
		# Stop it.
		chrono_onoff.setBoolValue( 0 );
		reset_state.setBoolValue( 0 );
	}
}

var reset_chrono = func {
			var basal = indicated_sec.getValue() ;
			indicated_chr_ref_sec.setValue( basal );
}

var update_chrono = func {
	var on = chrono_onoff.getBoolValue();
	if ( on ) {
		var i_sec = indicated_sec.getValue();
		var e_sec = i_sec - indicated_chr_ref_sec.getValue() ;
		elapsed_sec.setValue( e_sec );
		
		var hours_chr = e_sec / ( 60 * 60 );
		var minutes_chr = ( hours_chr - int(hours_chr) ) * 60 ;
		var seconds_chr = ( minutes_chr - int(minutes_chr) ) * 60 ;
		indicated_chr_min.setValue( minutes_chr );
		indicated_chr_sec.setValue( seconds_chr );
		
	}
}

# Comment the following if update_chrono() is launched from a
# centralized loop in order to save some CPU cycles.

var chrono_loop = func {
	update_chrono();
	settimer(chrono_loop, 0.1);
}
settimer(chrono_loop, 0.5);
