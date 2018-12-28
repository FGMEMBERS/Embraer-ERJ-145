var canvas_atctcas = {
	new: func(canvasGroup, instance)
	{
		var m = { parents: [canvas_atctcas], fltid_data:{} };
		m.group = canvasGroup;
		m.Instance = instance;
		m.Tmp = 0;
		m.Text = 0;

		var font_mapper = func(family, weight)
		{
			return "honeywellfont.ttf";
		};
		canvas.parsesvg(canvasGroup, "Aircraft/Embraer-ERJ-145/Models/Interior/Panel/Instruments/rmu/atctcas.svg", {'font-mapper': font_mapper});

		var svg_keys = ["fltid_text","fltid_ptr"];
		foreach(var key; svg_keys) {
			m[key] = canvasGroup.getElementById(key);
		}

		m.fltid_text.setText("");
		m.fltid_size = 0;
		m.fltid_index = 0;
		return m;
	},
	BtClick: func(input = -1) {
		if(input == 10) {
			setprop("instrumentation/rmu["~me.Instance~"]/page", PageEnum.frequencies);
		}
		if(input == 17) {
			setprop("instrumentation/rmu["~me.Instance~"]/page", PageEnum.pagemenu);
		}
	},
	Knob: func(index = -1, input = -1) {
		if(index == 0) {
			# outer wheel
			if(input > 0) {
				if(me.fltid_index < me.fltid_size) {
					if(me.fltid_index < 7) {
						me.fltid_index = me.fltid_index+1;
					}
				}
			}
			else {
				if(me.fltid_index > 0) {
					me.fltid_index = me.fltid_index-1;
				}
			}
			me.fltid_ptr.setTranslation(me.fltid_index*9, 0);
		}
		else {
			# inner wheel
			me.Tmp = me.fltid_data[me.fltid_index] or 32;
			me.Text = "";

			if(input > 0) {
				# right turn
				if(me.Tmp == 32) {
					# space -> 0
					me.Tmp = 48;
				}
				else if(me.Tmp == 57) {
					# 9 -> A
					me.Tmp = 65;
				}
				else if(me.Tmp == 90) {
					# Z -> back to 0 or space if last char
					if(me.fltid_index == me.fltid_size-1) {
						me.Tmp = 32;
						me.fltid_size = me.fltid_size-1;
					}
					else {
						me.Tmp = 48;
					}
				}
				else {
					# normal increase
					me.Tmp = me.Tmp+1;
				}
			}
			else {
				# left turn
				if(me.Tmp == 32) {
					# space -> Z
					me.Tmp = 90;
				}
				else if(me.Tmp == 65) {
					# A -> 9
					me.Tmp = 57;
				}
				else if(me.Tmp == 48) {
					# 0 -> back to Z or space if last char
					if(me.fltid_index == me.fltid_size-1) {
						me.Tmp = 32;
						me.fltid_size = me.fltid_size-1;
					}
					else {
						me.Tmp = 90;
					}
				}
				else {
					# normal decrease
					me.Tmp = me.Tmp-1;
				}
			}

			me.fltid_data[me.fltid_index] = me.Tmp;

			# increase buffer if new position
			if(me.fltid_index == me.fltid_size) {
				if(me.fltid_data[me.fltid_size] != 32) {
					me.fltid_size = me.fltid_size+1;
					me.fltid_data[me.fltid_size+1] = 32;
				}
			}

			for(me.Tmp=0; me.Tmp < me.fltid_size; me.Tmp+=1) {
				me.Text=me.Text~chr(me.fltid_data[me.Tmp]);
			}

			me.fltid_text.setText(me.Text);
		}
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
