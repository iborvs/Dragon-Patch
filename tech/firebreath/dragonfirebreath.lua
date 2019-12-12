function init()
	self.deltas = {0,0}
  self.setFacingDirection = nil
  self.energyPerSecond = (config.getParameter("energyCostPerSecond") / 60);
  self.projectileConfig = config.getParameter("techProjectileConfig")
  end
function update(args,dt)
	self.deltas = world.distance(mcontroller.position(), tech.aimPosition())
	local myMousePos =  tech.aimPosition()
	local diff = world.distance(tech.aimPosition(math.random(50)), mcontroller.position(math.random(50)))
	local aimAngle = math.atan(diff[2], diff[1])
	local myProjectileConfig = self.projectileConfig
	if self.deltas[1] <= 0 then
		self.setFacingDirection = 1;
	else
		self.setFacingDirection = -1;
	end
	mcontroller.controlFace(self.setFacingDirection)
	if args.moves["special1"]then
		if status.overConsumeResource("energy", self.energyPerSecond * 2 ) then
			world.spawnProjectile("dragontechcloud",mcontroller.position(), entity.id(),{math.cos(aimAngle), math.sin(aimAngle)},false,myProjectileConfig)
	
		end
	end
end