var canvas_mls = {
	new: func(canvasGroup, instance)
	{
		var m = { parents: [canvas_mls] };
		m.group = canvasGroup;
		m.Instance = instance;

		var font_mapper = func(family, weight)
		{
			return "honeywellfont.ttf";
		};
		canvas.parsesvg(canvasGroup, "Aircraft/Embraer-ERJ-145/Models/Interior/Panel/Instruments/rmu/mls.svg", {'font-mapper': font_mapper});

		#var svg_keys = ["title","linel"];
		#foreach(var key; svg_keys) {
		#	m[key] = canvasGroup.getElementById(key);
		#}

		return m;
	},
	BtClick: func(input = -1) {
		if(input == 10) {
			setprop("instrumentation/rmu["~me.Instance~"]/page", PageEnum.frequencies);
		}
		if(input == 11 or input == 17) {
			setprop("instrumentation/rmu["~me.Instance~"]/page", PageEnum.pagemenu);
		}
	},
	Knob: func(index = -1, input = -1) {
	},
	show: func()
	{
		me.group.show();
	},
	hide: func()
	{
		me.group.hide();
	}
};
