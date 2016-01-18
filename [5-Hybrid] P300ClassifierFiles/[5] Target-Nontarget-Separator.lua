
targets = {}
non_targets = {}
sent_stimulation = 0

function initialize(box)
	dofile(box:get_config("${Path_Data}") .. "/plugins/stimulation/lua-stimulator-stim-codes.lua")

	sent_stimulation = _G[box:get_setting(2)]

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
			box:log("Info", string.format("=== Target : %s", t_code))
		end

		while box:get_stimulation_count(1) > 0 do

			s_code, s_date, s_duration = box:get_stimulation(1, 1)
			box:remove_stimulation(1, 1)

			if s_code >= OVTK_StimulationId_Label_00 and s_code <= OVTK_StimulationId_Label_1F then

				-- box:log("Info", string.format("stimulus : %s", s_code))

				received_stimulation = s_code - OVTK_StimulationId_Label_00

				if t_code == s_code then
					--box:log("Info", string.format("Target!"))
					box:send_stimulation(1, sent_stimulation, time)
				else
					--box:log("Info", string.format("Nontarget!"))
					box:send_stimulation(2, sent_stimulation, time)
				end

			elseif s_code == OVTK_StimulationId_ExperimentStop then
				finished = true
			end

		end

		box:sleep()

	end

end
