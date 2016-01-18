
sequence = {}
number_of_cycles = 0

stimulation_duration = nil
break_duration = nil
flickering_delay = nil

stimulationLabels = {
	0x00008100,
	0x00008101,
	0x00008102,
	0x00008103,
	0x00008104,
	0x00008105,
	0x00008106,
	0x00008107
}

function initialize(box)

	dofile(box:get_config("${Path_Data}") .. "/plugins/stimulation/lua-stimulator-stim-codes.lua")

	-- load the goal sequence
	s_sequence = box:get_setting(2)


	for target in s_sequence:gmatch("%d+") do
		table.insert(sequence, target)
		number_of_cycles = number_of_cycles + 1
	end

	box:log("Info", string.format("Number of goals in sequence: [%d]", number_of_cycles))

	-- get the duration of a stimulation sequence
	s_stimulation_duration = box:get_setting(3)

	if (s_stimulation_duration:find("^%d+[.]?%d*$") ~= nil) then
		stimulation_duration = tonumber(s_stimulation_duration)
		box:log("Info", string.format("Stimulation Duration : [%g]", stimulation_duration))
	else
		box:log("Error", "The parameter 'stimulation duration' must be a numeric value\n")
		error()
	end

	-- get the duration of a break between stimulations
	s_break_duration = box:get_setting(4)

	if (s_break_duration:find("^%d+[.]?%d*$") ~= nil) then
		break_duration = tonumber(s_break_duration)
		box:log("Info", string.format("Break Duration : [%s]", s_break_duration))
	else
		box:log("Error", "The parameter 'break duration' must be a numeric value\n")
		error()
	end

	-- get the delay between the appearance of the marker and the start of flickering
	s_flickering_delay = box:get_setting(5)

	if (s_flickering_delay:find("^%d+[.]?%d*$") ~= nil) then
		flickering_delay = tonumber(s_flickering_delay)
		box:log("Info", string.format("Flickering Delay : [%s]", s_flickering_delay))
	else
		box:log("Error", "The parameter 'flickering delay' must be a numeric value\n")
		error()
	end

	-- tell the time when this program implemented
	box:log("Info", string.format(os.date("%Y-%m-%d %H:%M:%S")))

	-- create the configuration file for the stimulation-based-epoching
	-- this file is used during classifier training only
	cfg_file_name = box:get_config("${Player_ScenarioDirectory}/configuration/stimulation-based-epoching.cfg")
	cfg_file = io.open(cfg_file_name, "w")
	if cfg_file == nil then
		box:log("Error", "Cannot write to [" .. cfg_file_name .. "]")
		box:log("Error", "Please copy the scenario folder to a directory with write access and use from there.")
		return false
	end

	cfg_file:write("<OpenViBE-SettingsOverride>\n")
	cfg_file:write("	<SettingValue>", stimulation_duration, "</SettingValue>\n")
	cfg_file:write("	<SettingValue>", flickering_delay, "</SettingValue>\n")
	cfg_file:write("	<SettingValue>OVTK_StimulationId_Target</SettingValue>\n")
	cfg_file:write("</OpenViBE-SettingsOverride>\n")

	cfg_file:close()

end

function uninitialize(box)
end

function process(box)

	while box:keep_processing() and box:get_stimulation_count(1) == 0 do
		box:sleep()
	end

	current_time = box:get_current_time() + 1

	box:send_stimulation(1, OVTK_StimulationId_ExperimentStart, current_time, 0)

	current_time = current_time + 2

	for i,target in ipairs(sequence) do
		box:log("Info", string.format("Target no %d is %d at %d", i, target, current_time))
		-- mark goal
		box:send_stimulation(2, OVTK_StimulationId_LabelStart + target, current_time, 0)
		-- wait for Flickering_delay seconds
		current_time = current_time + flickering_delay
		-- start flickering
		box:send_stimulation(1, OVTK_StimulationId_VisualStimulationStart, current_time, 0)
		-- wait for Stimulation_duration seconds
		current_time = current_time + stimulation_duration
		-- unmark goal and stop flickering
		box:send_stimulation(1, OVTK_StimulationId_VisualStimulationStop, current_time, 0)
		-- wait for Break_duration seconds
		current_time = current_time + break_duration
	end

	box:send_stimulation(1, OVTK_StimulationId_ExperimentStop, current_time, 0)

	box:sleep()
end

