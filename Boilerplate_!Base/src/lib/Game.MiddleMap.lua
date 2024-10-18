--------------------------------------------------------------------------------
-- This file is part of the JX3 Plugin Project.
-- @desc     : ”Œœ∑ª∑æ≥ø‚
-- @copyright: Copyright (c) 2009 Kingsoft Co., Ltd.
--------------------------------------------------------------------------------
---@type Boilerplate
local X = Boilerplate
--------------------------------------------------------------------------------
local MODULE_PATH = X.NSFormatString('{$NS}_!Base/lib/Game.MiddleMap')
--------------------------------------------------------------------------------
--[[#DEBUG BEGIN]]X.ReportModuleLoading(MODULE_PATH, 'START')--[[#DEBUG END]]
--------------------------------------------------------------------------------
local _L = X.LoadLangPack(X.PACKET_INFO.FRAMEWORK_ROOT .. 'lang/lib/')
--------------------------------------------------------------------------------

local CANVAS_NAME = X.NSFormatString('Handle_{$NS}')
local HANDLER = {}

function X.RegisterMiddleMapPoint(szType, R)
	if HANDLER[szType] then
		return X.OutputDebugMessage(X.NSFormatString('{$NS}.RegisterMiddleMapPoint'), szType .. ' type already registered!', X.DEBUG_LEVEL.ERROR)
	end
	HANDLER[szType] = {
		nPriority = R.nPriority or 0,
		Drawer = R.Drawer,
		aPoint = {},
	}
end

local function DrawPoint(szType, szKey, nX, nY, data)
	local R = HANDLER[szType]
	local hInner = Station.Lookup('Topmost1/MiddleMap', 'Handle_Inner')
		or Station.Lookup('Topmost1/MiddleMap', 'Handle_Border/Handle_Map/Handle_Inner')
	if not R or not hInner then
		return
	end
	local nW, nH = hInner:GetSize()
	local hCanvas = hInner:Lookup(CANVAS_NAME)
	if not hCanvas then
		hInner:AppendItemFromString('<handle>firstpostype=0 name="' .. CANVAS_NAME .. '" w=' .. nW .. ' h=' .. nH .. '</handle>')
		hCanvas = hInner:Lookup(CANVAS_NAME)
		hInner:FormatAllItemPos()
	end
	nX, nY = MiddleMap.LPosToHPos(nX, nY, 0, 0)
	if nX < 0 or nY < 0 or nX > nW or nY > nH then
		return
	end

end

local function DrawAllPoint()
	for szType, R in pairs(HANDLER) do
		for _, tPoint in ipairs(R.aPoint) do
			DrawPoint(szType, tPoint.szKey, tPoint.nX, tPoint.nY, tPoint.data)
		end
	end
end

function X.UpdateMiddleMapPoint(szType, szKey, nX, nY, data)

end

Topmost1/MiddleMap/
Handle_Border/Handle_Map/Handle_Inner

--[[#DEBUG BEGIN]]X.ReportModuleLoading(MODULE_PATH, 'FINISH')--[[#DEBUG END]]
