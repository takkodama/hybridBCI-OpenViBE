
trigger_stimulation = 0
send_stimulation = 0

function initialize(box)
	dofile(box:get_config("${Path_Data}") .. "/plugins/stimulation/lua-stimulator-stim-codes.lua")
	
	-- read the parameters of the box

	trigger_stimulation = _G[box:get_setting(2)]

	send_stimulation = _G[box:get_setting(3)]

end

function uninitialize(box)
end

function process(box)

	finished = false

	while box:keep_processing() and not finished do

		time = box:get_current_time()

		while box:get_stimulation_count(1) > 0 do

			t_code, t_date, t_duration = box:get_stimulation(1, 1)
			box:remove_stimulation(1, 1)
			
			time_receive = box:get_current_time()
			-- box:log("Info", string.format("time_receive : %s", time_receive))

			if t_code == trigger_stimulation then

				box:send_stimulation(1, send_stimulation, time_receive + 1.48)
				-- box:send_stimulation(1, OVTK_StimulationId_VisualStimulationStop, time_receive + 7.5)
				box:log("Info", string.format("stimulation set from %s until %s", time_receive + 1.5, time_receive + 7.5))

			elseif t_code == OVTK_StimulationId_TrialStop then
				box:send_stimulation(1, OVTK_StimulationId_VisualStimulationStop, time)
				box:log("Info", string.format("OVTK_StimulationId_VisualStimulationStop : %s", OVTK_StimulationId_VisualStimulationStop))
			end
		end


		box:sleep()

	end

end
