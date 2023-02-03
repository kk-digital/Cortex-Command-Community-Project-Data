function Create(self)
	self.grenadeName = self:StringValueExists("GrenadeName") and self:GetStringValue("GrenadeName") or "Frag Grenade";
	self.grenadeTech = self:StringValueExists("GrenadeTech") and self:GetStringValue("GrenadeTech") or "Base.rte";

	self.isThrownDevice = self:NumberValueExists("IsThrownDevice");
	local appropriateGrenadeCreateFunction = self.isThrownDevice and CreateThrownDevice or CreateTDExplosive;
	self.grenadeObject = appropriateGrenadeCreateFunction(self.grenadeName, self.grenadeTech);

	self.bandolierKey =  self.grenadeTech .. "/" .. self.PresetName;
	self.bandolierMass = self:NumberValueExists("BandolierMass") and self:GetNumberValue("BandolierMass") or 1.5;

	self.replenishDelay = self:NumberValueExists("ReplenishDelay") and self:GetNumberValue("ReplenishDelay") or 0;

	self.grenadeMass = self:NumberValueExists("GrenadeMass") and self:GetNumberValue("GrenadeMass") or self.grenadeObject.Mass;
	self.grenadesPerBandolier = self:NumberValueExists("GrenadeCount") and self:GetNumberValue("GrenadeCount") or 3;
	self.grenadesRemainingInBandolier = self:NumberValueExists("GrenadesRemainingInBandolier") and self:GetNumberValue("GrenadesRemainingInBandolier") or self.grenadesPerBandolier;

	----------------------------------------
	-- Setup Grenade Bandolier Attachable --
	----------------------------------------
	self.attachable = CreateAttachable("Grenade Bandolier", "Base.rte");

	self.attachable:SetStringValue("BandolierName", self.PresetName);
	self.attachable:SetNumberValue("BandolierMass", self.bandolierMass);

	self.attachable:SetNumberValue("ReplenishDelay", self.replenishDelay);

	self.attachable:SetStringValue("GrenadeName", self.grenadeName);
	self.attachable:SetStringValue("GrenadeTech", self.grenadeTech);
	if self.isThrownDevice then
		self.attachable:SetNumberValue("GrenadeIsThrownDevice", 1);
	end
	self.attachable:SetNumberValue("GrenadeMass", self.grenadeMass);
	self.attachable:SetNumberValue("GrenadesPerBandolier", self.grenadesPerBandolier);
	if self.grenadesPerBandolier ~= self.grenadesRemainingInBandolier then
		self.attachable:SetNumberValue("GrenadesRemainingInBandolier", self.grenadesRemainingInBandolier);
	end
end

function OnAttach(self, newParent)
	local rootParent = self:GetRootParent();
	if IsAHuman(rootParent) then
		rootParent = ToAHuman(rootParent);
	end
	if rootParent and not rootParent:NumberValueExists(self.bandolierKey) then
		rootParent:AddAttachable(self.attachable);
		self.ToDelete = true;
	end
end