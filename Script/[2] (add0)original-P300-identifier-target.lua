-- This Lua script generates target stimulations for the P300 visualisation
-- box based on the matrix of letters / numbers a P300 speller has
--
-- Author : Yann Renard, INRIA
-- Date   : 2011-03-15

grid ={'1', '2', '3', '4', '5', '6'}

index = 0

function get_location(c)
		for j = 1, 6 do
			if grid[j] == c then
				return j
			end
	end
	return 0, 0
end

-- this function is called when the box is initialized
function initialize(box)

	dofile(box:get_config("${Path_Data}") .. "/plugins/stimulation/lua-stimulator-stim-codes.lua")

	math.randomseed(os.time())
	target = box:get_setting(2)
	row_base = _G[box:get_setting(3)]
	delay = box:get_setting(5)
	target_for_print = ""

	if target == "" then
		for i = 1, 1000 do
			-- a = math.random(1, #grid)
			for j = 1, 6 do
				a = j
				target = target .. grid[a]
				-- 後ろに連結していく
			end
		end
		-- print(target)
	end
end

-- this function is called when the box is uninitialized
function uninitialize(box)
end

-- this function is called once by the box
function process(box)

	-- loop until box:keep_processing() returns zero
	-- cpu will be released with a call to sleep
	-- at the end of the loop
	while box:keep_processing() do

		-- gets current simulated time
		t = box:get_current_time()

		-- loops on every received stimulation for a given input
		for stimulation = 1, box:get_stimulation_count(1) do

			-- gets stimulation
			stimulation_id, stimulation_time, stimulation_duration = box:get_stimulation(1, 1)

			if stimulation_id == OVTK_StimulationId_RestStart then

				-- finds a new target
				index = index + 1
				r, c = get_location(string.sub(target, index, index))

				-- triggers the target
				box:send_stimulation(1, row_base+r-1, t+delay, 0)

			elseif stimulation_id == OVTK_StimulationId_ExperimentStop then

				-- triggers train stimulation
				box:send_stimulation(1, OVTK_StimulationId_Train, t+delay+1, 0)

			end

			-- discards it
			box:remove_stimulation(1, 1)

		end

		-- releases cpu
		box:sleep()
	end
end
