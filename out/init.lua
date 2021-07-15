--[[
	Lighter version of Anaminus's Signal and even Sleitnick's Signal
]]

local RunService = game:GetService("RunService")

local Connection do
	Connection = {
		__index = {},
		__metatable = "Connection",
	}

	function Connection.new(signal, id)
		local self = setmetatable({
			_signal = signal,
			_id = id,
			_isConnected = true,
		}, Connection)
		return self
	end

	function Connection.__index:IsConnected()
		return self._isConnected
	end

	function Connection.__index:Disconnect()
		do
			local connections = self._signal._connections
			local listeners = self._signal._listeners

			local n = #connections

			connections[self._id] = connections[n]
			listeners[self._id] = nil
			connections[n] = nil

			self._signal = nil
			self._id = nil
			self._isConnected = false
		end
	end
end

local Signal do
	Signal = {
		__index = {},
		__connection = "Signal",
	}

	function Signal.new()
		local self = setmetatable({
			_listeners = {},
			_connections = {},
		}, Signal)
		return self
	end

	function Signal.__index:Fire(...)
		for _, listener in pairs(self._listeners) do
			if listener ~= nil then
				coroutine.resume(coroutine.create(listener), ...)
			end
		end
	end

	function Signal.__index:Connect(callback)
		local connection do
			local connections = #self._connections
			local newId = connections + 1

			connection = Connection.new(self, newId)
			self._listeners[newId] = callback
		end
		return connection
	end

	function Signal.__index:DisconnectAll()
		for _, connection in pairs(self._connections) do
			if connection ~= nil then
				connection:Disconnect()
			end
		end 
	end

	-- A weird hack
	function Signal.__index:Wait()
		local parameters = nil

		do
			local recieved = false
			local conn = self:Connect(function(...)
				parameters = { ... }
				
				-- Otherwise it will cause some problems
				-- because it is asynchornous!
				recieved = true
			end)

			while not recieved do
				RunService.Heartbeat:Wait()
			end
			conn:Disconnect()
		end

		return unpack(parameters)
	end

	function Signal.__index:Destroy()
		self:DisconnectAll()
	end
end

return Signal
