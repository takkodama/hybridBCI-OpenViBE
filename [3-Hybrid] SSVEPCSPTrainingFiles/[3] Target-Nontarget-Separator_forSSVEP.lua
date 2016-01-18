
targets = {}
non_targets = {}
trigger_stimulation = 0

function initialize(box)
	dofile(box:get_config("${Path_Data}") .. "/plugins/stimulation/lua-stimulator-stim-codes.lua")
	
	-- read the parameters of the box
	
	s_targets = box:get_setting(2)

	for t in s_targets:gmatch("%d+") do
		targets[t + 0] = true
	end

	s_non_targets = box:get_setting(3)

	for t in s_non_targets:gmatch("%d+") do
		non_targets[t + 0] = true
	end

	trigger_stimulation = _G[box:get_setting(4)]

end

function uninitialize(box)
end

function process(box)

	finished = false

	while box:keep_processing() and not finished do

		time = box:get_current_time()

		while box:get_stimulation_count(2) > 0 do

			t_code, t_date, t_duration = box:get_stimulation(2, 1)
			box:remove_stimulation(2, 1)

			if t_code == trigger_stimulation then

				received_stimulation = s_code - OVTK_StimulationId_Label_00

				if targets[received_stimulation] ~= nil then
					box:send_stimulation(1, trigger_stimulation, time)
				elseif non_targets[received_stimulation] ~= nil then
					box:send_stimulation(2, trigger_stimulation, time)
				end

			elseif s_code == OVTK_StimulationId_ExperimentStop then
				finished = true
			end
		end

		while box:get_stimulation_count(1) > 0 do

			s_code, s_date, s_duration = box:get_stimulation(1, 1)
			box:remove_stimulation(1, 1)
			-- box:log("Info", string.format("s_target : %s", s_target))
			-- box:log("Info", string.format("s_code : %s", s_code))

		end

		box:sleep()

	end

end
