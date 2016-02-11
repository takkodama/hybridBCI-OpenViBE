
targets = {}
non_targets = {}
switchFlag = 0

function initialize(box)
	dofile(box:get_config("${Path_Data}") .. "/plugins/stimulation/lua-stimulator-stim-codes.lua")

end

function uninitialize(box)
end

function process(box)

	finished = false

	while box:keep_processing() and not finished do

		time = box:get_current_time()

		while box:get_stimulation_count(2) > 0 do

			t_code, t_date, t_duration = box:get_stimulation(2, 1)
			box:log("Info", string.format("t_code : %s", t_code))
			box:remove_stimulation(2, 1)
		end

		while box:get_stimulation_count(1) > 0 do

			-- box:log("Info", string.format("box:get_stimulation_count(1) > 0"))

			s_code, s_date, s_duration = box:get_stimulation(1, 1)
			box:log("Info", string.format("s_code : %s", s_code))
			box:remove_stimulation(1, 1)

			if t_code == OVTK_StimulationId_TrialStart then

				if s_code == OVTK_StimulationId_Label_05 then
					box:log("Info", string.format("Label 05"))
					box:send_stimulation(1, OVTK_StimulationId_Target, time)
				else
					box:log("Info", string.format("Label 01 ~ 04"))
					box:send_stimulation(2, OVTK_StimulationId_Target, time)
				end

			elseif s_code == OVTK_StimulationId_ExperimentStop then
				finished = true
			end

		end

		box:sleep()

	end

end
