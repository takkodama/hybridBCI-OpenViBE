
sent_stimulation = 0
stimulation_counter = 0

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

		while box:get_stimulation_count(1) > 0 do

			s_code, s_date, s_duration = box:get_stimulation(1, 1)
			box:remove_stimulation(1, 1)

			if s_code == OVTK_StimulationId_Target then

				stimulation_counter = stimulation_counter + 1

				if stimulation_counter < 3 then
					box:log("Info", string.format("Target 1-2"))
					box:send_stimulation(1, sent_stimulation, time)
				elseif stimulation_counter >= 3 and stimulation_counter < 5 then
					box:log("Info", string.format("Target 3-4"))
					box:send_stimulation(2, sent_stimulation, time)
				elseif stimulation_counter >= 5 and stimulation_counter < 7 then
					box:log("Info", string.format("Target 5-6"))
					box:send_stimulation(3, sent_stimulation, time)
				elseif stimulation_counter >= 7 and stimulation_counter < 9 then
					box:log("Info", string.format("Target 7-8"))
					box:send_stimulation(4, sent_stimulation, time)
				elseif stimulation_counter >= 9 then
					box:log("Info", string.format("Target 9-10"))
					box:send_stimulation(5, sent_stimulation, time)
					if(stimulation_counter == 10) then
						stimulation_counter = 0
						box:log("Info", string.format("Target Stimulation Counter RESET"))
					end
				end

			elseif s_code == OVTK_StimulationId_ExperimentStop then
				finished = true
			end


		end

		box:sleep()

	end

end
