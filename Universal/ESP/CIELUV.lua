-- // Information
--[[
    "If you don’t know what CIELUV is (you probably don’t and that’s ok), it’s a perceptually uniform and additive color space. In other words, it’s really good at representing color transitions on LCD screens for human eyes."

    Source: https://devforum.roblox.com/t/cieluv-interpolator/27100
]]

-- //
local LerpCIELUV
do
	-- Combines two colors in CIELUV space.
	-- function<function<Color3 result>(float t)>(Color3 fromColor, Color3 toColor)

	-- https://www.w3.org/Graphics/Color/srgb

	local clamp = math.clamp
	local C3 = Color3.new
	local black = C3(0, 0, 0)

	-- Convert from linear RGB to scaled CIELUV
	local function RgbToLuv13(c)
		local r, g, b = c.r, c.g, c.b
		-- Apply inverse gamma correction
		r = r < 0.0404482362771076 and r/12.92 or 0.87941546140213*(r + 0.055)^2.4
		g = g < 0.0404482362771076 and g/12.92 or 0.87941546140213*(g + 0.055)^2.4
		b = b < 0.0404482362771076 and b/12.92 or 0.87941546140213*(b + 0.055)^2.4
		-- sRGB->XYZ->CIELUV
		local y = 0.2125862307855956*r + 0.71517030370341085*g + 0.0722004986433362*b
		local z = 3.6590806972265883*r + 11.4426895800574232*g + 4.1149915024264843*b
		local l = y > 0.008856451679035631 and 116*y^(1/3) - 16 or 903.296296296296*y
		if z > 1e-15 then
			local x = 0.9257063972951867*r - 0.8333736323779866*g - 0.09209820666085898*b
			return l, l*x/z, l*(9*y/z - 0.46832)
		else
			return l, -0.19783*l, -0.46832*l
		end
	end

	function LerpCIELUV(c0, c1)
		local l0, u0, v0 = RgbToLuv13(c0)
		local l1, u1, v1 = RgbToLuv13(c1)

		return function(t)
			-- Interpolate
			local l = (1 - t)*l0 + t*l1
			if l < 0.0197955 then
				return black
			end
			local u = ((1 - t)*u0 + t*u1)/l + 0.19783
			local v = ((1 - t)*v0 + t*v1)/l + 0.46832

			-- CIELUV->XYZ
			local y = (l + 16)/116
			y = y > 0.206896551724137931 and y*y*y or 0.12841854934601665*y - 0.01771290335807126
			local x = y*u/v
			local z = y*((3 - 0.75*u)/v - 5)

			-- XYZ->linear sRGB
			local r =  7.2914074*x - 1.5372080*y - 0.4986286*z
			local g = -2.1800940*x + 1.8757561*y + 0.0415175*z
			local b =  0.1253477*x - 0.2040211*y + 1.0569959*z

			-- Adjust for the lowest out-of-bounds component
			if r < 0 and r < g and r < b then
				r, g, b = 0, g - r, b - r
			elseif g < 0 and g < b then
				r, g, b = r - g, 0, b - g
			elseif b < 0 then
				r, g, b = r - b, g - b, 0
			end

			return C3(
				-- Apply gamma correction and clamp the result
				clamp(r < 3.1306684425e-3 and 12.92*r or 1.055*r^(1/2.4) - 0.055, 0, 1),
				clamp(g < 3.1306684425e-3 and 12.92*g or 1.055*g^(1/2.4) - 0.055, 0, 1),
				clamp(b < 3.1306684425e-3 and 12.92*b or 1.055*b^(1/2.4) - 0.055, 0, 1)
			)
		end
	end
end

-- // Return
return LerpCIELUV