
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

		while box:get_stimulation_count(3) > 0 do
			stimuli_code, stimuli_date, stimuli_duration = box:get_stimulation(3, 1)
			-- box:log("Info", string.format("stimuli_code : %s", stimuli_code))
			box:remove_stimulation(3, 1)

			--if start_code == trigger_stimulation then

				received_stimulation = target_code - OVTK_StimulationId_Label_00
				-- box:log("Info", string.format("received_stimulation : %s", received_stimulation))

				if targets[received_stimulation] ~= nil then
					if stimuli_code == OVTK_StimulationId_Label_05 then
						-- box:log("Info", string.format("TARGET Label 05"))
						box:send_stimulation(1, OVTK_StimulationId_Target, time)
					else
						-- box:log("Info", string.format("TARGET Label 01 ~ 04"))
						box:send_stimulation(2, OVTK_StimulationId_Target, time)
					end
				elseif non_targets[received_stimulation] ~= nil then
					if stimuli_code == OVTK_StimulationId_Label_05 then
						-- box:log("Info", string.format("NonTARGET Label 05"))
						box:send_stimulation(3, OVTK_StimulationId_Target, time)
					else
						-- box:log("Info", string.format("NonTARGET Label 01 ~ 04"))
						box:send_stimulation(4, OVTK_StimulationId_Target, time)
					end
				end

			-- elseif start_code == OVTK_StimulationId_ExperimentStop then
			-- 	finished = true
			-- end

		end

		while box:get_stimulation_count(2) > 0 do

			start_code, start_date, start_duration = box:get_stimulation(2, 1)
			-- box:log("Info", string.format("start_code : %s", start_code))
			box:remove_stimulation(2, 1)

		end

		while box:get_stimulation_count(1) > 0 do

			target_code, target_date, target_duration = box:get_stimulation(1, 1)
			-- box:log("Info", string.format("target_code : %s", target_code))
			box:remove_stimulation(1, 1)

		end

		box:sleep()

	end

end
