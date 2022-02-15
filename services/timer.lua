local State = require('services/state')
local mapList = require('maps/mapList')

timer = {}

timer.timesTable = {} -- Holds times

timer.convertSeconds = function(timeInSeconds)
    -- Formats the current stopwatch time in mm:ss:ms.

    -- Seperate seconds out into minutes, seconds, and milliseconds
    local minutes = math.floor(timeInSeconds / 60)
    local seconds = math.floor(timeInSeconds % 60)
    local milliseconds = math.floor((timeInSeconds - math.floor(timeInSeconds)) * 1000)
    local timeString = minutes .. ':'

    -- Make sure seconds always display with two digits.
    -- Maps hopefully won't be 10+ minutes long and milliseconds are too fast to care about.
    if seconds < 10 then timeString = timeString .. '0' end
    timeString = timeString .. seconds .. ':' .. milliseconds

    return timeString
end

timer.getBestTimes = function(mapID, x)
    -- Gets the `x` best times of a map.
    local requestedTimesTable = {}
    local bestTimes = {}
    if timer.timesTable[mapList[mapID].filename] then
        requestedTimesTable = timer.timesTable[mapList[mapID].filename]
    end

    for i = 1, x do
        if i <= #requestedTimesTable then
            table.insert(bestTimes, timer.convertSeconds(requestedTimesTable[i]))
        else
            table.insert(bestTimes, '0:00:000')
        end
    end

    return bestTimes
end

timer.saveNewTime = function(timeInSeconds)
    -- Inserts new time to the current map's timesTable.

    -- Grab the currennt map's table of times (or create it)
    local currentMapTimesTable = {}
    if not timer.timesTable[mapList[State.activeMap].filename] then
        timer.timesTable[mapList[State.activeMap].filename] = {}
    end

    -- Round off time to be stored (Who really wants the 10th place of precision)
    timeInSeconds = math.floor(timeInSeconds * 1000) / 1000

    if State.activeMap ~= -1 then
        currentMapTimesTable = timer.timesTable[mapList[State.activeMap].filename]
        table.insert(currentMapTimesTable, timeInSeconds)
        table.sort(currentMapTimesTable)
    end
end

return timer
