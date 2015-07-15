# Anti-Collision Beacon lights
beacon_switch = props.globals.getNode("controls/switches/beacon", 2);
var beacon = aircraft.light.new( "/sim/model/lights/beacon", [0, 3], "/controls/lighting/beacon" );

strobe_switch = props.globals.getNode("controls/switches/strobe", 2);
var strobe = aircraft.light.new( "/sim/model/lights/strobe", [0, 3], "/controls/lighting/strobe" );
var sbc1 = aircraft.light.new( "/sim/model/lights/sbc1", [0.5, 0.3] );
sbc1.interval = 0.1;
sbc1.switch( 1 );

var sbc2 = aircraft.light.new( "/sim/model/lights/sbc2", [0.2, 0.3], "/sim/model/lights/sbc1/state" );
sbc2.interval = 0;
sbc2.switch( 1 );

setlistener( "/sim/model/lights/sbc2/state", func(n) {
  var bsbc1 = sbc1.stateN.getValue();
  var bsbc2 = n.getBoolValue();
  var b = 0;
  if( bsbc1 and bsbc2 and getprop( "/controls/lighting/beacon") ) {
    b = 1;
  } else {
    b = 0;
  }
  setprop( "/sim/model/lights/beacon/enabled", b );

  if( bsbc1 and !bsbc2 and getprop( "/controls/lighting/strobe" ) ) {
    b = 1;
  } else {
    b = 0;
  }
  setprop( "/sim/model/lights/strobe/enabled", b );
});

var beacon = aircraft.light.new( "/sim/model/lights/beacon", [0.05, 0.05] );
beacon.interval = 0;

var strobe = aircraft.light.new( "/sim/model/lights/strobe", [0.05, 0.05, 0.05, 1] );
strobe.interval = 0;

setprop( "/instrumentation/nav[0]/ident", 0 );
setprop( "/instrumentation/nav[1]/ident", 0 );
 

setprop( "/controls/switches/landing-lights", 0 );
setprop( "/controls/lighting/landing-lights", 0 );
setprop( "/controls/switches/taxi-lights", 0 );
setprop( "/controls/lighting/taxi-lights", 0 );
setprop( "/controls/switches/beacon", 0 );
setprop( "/controls/lighting/beacon", 0 );
setprop( "/controls/switches/nav-lights", 0 );
setprop( "/controls/lighting/nav-lights", 0 );
setprop( "/controls/switches/strobe", 0 );
setprop( "/controls/lighting/strobe", 0 );
setprop( "/controls/switches/instrument-lights", 0 );
setprop( "/controls/lighting/instrument-lights", 0 );
setprop( "/controls/lighting/instruments-norm", 0 );
setprop( "/controls/switches/panel-norm", 0 );
setprop( "/controls/lighting/panel-norm", 0 );
setprop( "/controls/switches/cabin-lights", 0 );
setprop( "/controls/lighting/cabin-lights", 0 );
setprop( "/controls/switches/logo-lights", 0 );
setprop( "/controls/lighting/logo-lights", 0 );
setprop( "/controls/switches/wing-lights", 0 );
setprop( "/controls/lighting/wing-lights", 0 );
