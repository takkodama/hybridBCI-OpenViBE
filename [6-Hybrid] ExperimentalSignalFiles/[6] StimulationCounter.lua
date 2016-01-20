
sent_stimulation = 0
stimulation_counter_1 = 0
stimulation_counter_2 = 0
stimulation_counter_3 = 0
stimulation_counter_4 = 0

function initialize(box)
	dofile(box:get_config("${Path_Data}") .. "/plugins/stimulation/lua-stimulator-stim-codes.lua")

	trigger_stimulation = _G[box:get_setting(2)]

	sent_stimulation_1 = _G[box:get_setting(3)]
	sent_stimulation_2 = _G[box:get_setting(4)]
	sent_stimulation_3 = _G[box:get_setting(5)]
	sent_stimulation_4 = _G[box:get_setting(6)]
	sent_stimulation_5 = _G[box:get_setting(7)]


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

			if s_code == OVTK_StimulationId_Label_01 then

				stimulation_counter_1 = stimulation_counter_1 + 1

				if stimulation_counter_1 == 1 then
					box:log("Info", string.format("OVTK_StimulationId_Label_1"))
					-- box:send_stimulation(1, sent_stimulation_1, time)
				elseif stimulation_counter_1 == 2 then
					box:log("Info", string.format("Send Stimulation 2"))
					-- box:send_stimulation(1, sent_stimulation_2, time)
				elseif stimulation_counter_1 == 3 then
					box:log("Info", string.format("Send Stimulation 3"))
					-- box:send_stimulation(1, sent_stimulation_3, time)
				elseif stimulation_counter_1 == 4 then
					box:log("Info", string.format("Send Stimulation 4"))
					-- box:send_stimulation(1, sent_stimulation_4, time)
				elseif stimulation_counter_1 == 5 then
					box:log("Info", string.format("Send Stimulation 5"))
					-- box:send_stimulation(1, sent_stimulation_5, time)
					box:log("Info", string.format("Stimulation Counter RESET"))
					stimulation_counter_1 = 0
				end

			elseif s_code == OVTK_StimulationId_Label_02 then

				stimulation_counter_2 = stimulation_counter_2 + 1

				if stimulation_counter_2 == 1 then
					box:log("Info", string.format("OVTK_StimulationId_Label_2"))
					-- box:send_stimulation(2, sent_stimulation_1, time)
				elseif stimulation_counter_2 == 2 then
					box:log("Info", string.format("Send Stimulation 2"))
					-- box:send_stimulation(2, sent_stimulation_2, time)
				elseif stimulation_counter_2 == 3 then
					box:log("Info", string.format("Send Stimulation 3"))
					-- box:send_stimulation(2, sent_stimulation_3, time)
				elseif stimulation_counter_2 == 4 then
					box:log("Info", string.format("Send Stimulation 4"))
					-- box:send_stimulation(2, sent_stimulation_4, time)
				elseif stimulation_counter_2 == 5 then
					box:log("Info", string.format("Send Stimulation 5"))
					-- box:send_stimulation(2, sent_stimulation_5, time)
					box:log("Info", string.format("Stimulation Counter RESET"))
					stimulation_counter_2 = 0
				end

			elseif s_code == OVTK_StimulationId_Label_03 then

				stimulation_counter_3 = stimulation_counter_3 + 1

				if stimulation_counter_3 == 1 then
					box:log("Info", string.format("OVTK_StimulationId_Label_3"))
					-- box:send_stimulation(3, sent_stimulation_1, time)
				elseif stimulation_counter_3 == 2 then
					box:log("Info", string.format("Send Stimulation 2"))
					-- box:send_stimulation(3, sent_stimulation_2, time)
				elseif stimulation_counter_3 == 3 then
					box:log("Info", string.format("Send Stimulation 3"))
					-- box:send_stimulation(3, sent_stimulation_3, time)
				elseif stimulation_counter_3 == 4 then
					box:log("Info", string.format("Send Stimulation 4"))
					-- box:send_stimulation(3, sent_stimulation_4, time)
				elseif stimulation_counter_3 == 5 then
					box:log("Info", string.format("Send Stimulation 5"))
					-- box:send_stimulation(3, sent_stimulation_5, time)
					box:log("Info", string.format("Stimulation Counter RESET"))
					stimulation_counter_3 = 0
				end

			elseif s_code == OVTK_StimulationId_Label_04 then

				stimulation_counter_4 = stimulation_counter_4 + 1

				if stimulation_counter_4 == 1 then
					box:log("Info", string.format("OVTK_StimulationId_Label_4"))
					-- box:send_stimulation(4, sent_stimulation_1, time)
				elseif stimulation_counter_4 == 2 then
					box:log("Info", string.format("Send Stimulation 2"))
					-- box:send_stimulation(4, sent_stimulation_2, time)
				elseif stimulation_counter_4 == 3 then
					box:log("Info", string.format("Send Stimulation 3"))
					-- box:send_stimulation(4, sent_stimulation_3, time)
				elseif stimulation_counter_4 == 4 then
					box:log("Info", string.format("Send Stimulation 4"))
					-- box:send_stimulation(4, sent_stimulation_4, time)
				elseif stimulation_counter_4 == 5 then
					box:log("Info", string.format("Send Stimulation 5"))
					-- box:send_stimulation(4, sent_stimulation_5, time)
					box:log("Info", string.format("Stimulation Counter RESET"))
					stimulation_counter_4 = 0
				end

			elseif s_code == OVTK_StimulationId_ExperimentStop then
				finished = true
			end


		end

		box:sleep()

	end

end
