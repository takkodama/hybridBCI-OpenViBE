
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
					box:log("Info", string.format("NonTarget 1-2"))
					box:send_stimulation(1, sent_stimulation, time)

				elseif stimulation_counter >= 3 and stimulation_counter < 5 then
					box:log("Info", string.format("NonTarget 3-4"))
					box:send_stimulation(2, sent_stimulation, time)

				elseif stimulation_counter >= 5 and stimulation_counter < 7 then
					box:log("Info", string.format("NonTarget 5-6"))
					box:send_stimulation(3, sent_stimulation, time)

				elseif stimulation_counter >= 7 and stimulation_counter < 9 then
					box:log("Info", string.format("NonTarget 7-8"))
					box:send_stimulation(4, sent_stimulation, time)

				elseif stimulation_counter >= 9 and stimulation_counter < 11 then
					box:log("Info", string.format("NonTarget 9-10"))
					box:send_stimulation(5, sent_stimulation, time)

				elseif stimulation_counter >= 11 and stimulation_counter < 13 then
					box:log("Info", string.format("NonTarget 11-12"))
					box:send_stimulation(6, sent_stimulation, time)

				elseif stimulation_counter >= 13 and stimulation_counter < 15 then
					box:log("Info", string.format("NonTarget 13-14"))
					box:send_stimulation(7, sent_stimulation, time)

				elseif stimulation_counter >= 15 and stimulation_counter < 17 then
					box:log("Info", string.format("NonTarget 15-16"))
					box:send_stimulation(8, sent_stimulation, time)

				elseif stimulation_counter >= 17 and stimulation_counter < 19 then
					box:log("Info", string.format("NonTarget 17-18"))
					box:send_stimulation(9, sent_stimulation, time)

				elseif stimulation_counter >= 19 and stimulation_counter < 21 then
					box:log("Info", string.format("NonTarget 19-20"))
					box:send_stimulation(10, sent_stimulation, time)

				elseif stimulation_counter >= 21 and stimulation_counter < 23 then
					box:log("Info", string.format("NonTarget 21-22"))
					box:send_stimulation(11, sent_stimulation, time)

				elseif stimulation_counter >= 23 and stimulation_counter < 25 then
					box:log("Info", string.format("NonTarget 23-24"))
					box:send_stimulation(12, sent_stimulation, time)

				elseif stimulation_counter >= 25 and stimulation_counter < 27 then
					box:log("Info", string.format("NonTarget 25-26"))
					box:send_stimulation(13, sent_stimulation, time)

				elseif stimulation_counter >= 27 and stimulation_counter < 29 then
					box:log("Info", string.format("NonTarget 27-28"))
					box:send_stimulation(14, sent_stimulation, time)

				elseif stimulation_counter >= 29 then
					box:log("Info", string.format("NonTarget 29-30"))
					box:send_stimulation(15, sent_stimulation, time)

					if(stimulation_counter == 30) then
						box:log("Info", string.format("NonTarget Stimulation Counter RESET"))
						stimulation_counter = 0
					end
				end

			elseif s_code == OVTK_StimulationId_ExperimentStop then
				finished = true
			end


		end

		box:sleep()

	end

end
