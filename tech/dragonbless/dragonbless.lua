function init()
  self.deltas = {0,0}
  self.hyp = 1
  self.Ddeltas = {0,0}
  self.Dhyp = 1
  self.setFacingDirection = nil
  self.energyPerSecond = (config.getParameter("energyCostPerSecond") / 60);
  self.activetimer = 0
  self.active= false
  self.available = true
  self.lastJump = false
  self.lock = true
end
function update(args,dt)
    mcontroller.controlParameters({
    })
	local myMousePos =  tech.aimPosition()
	local amIColliding = mcontroller.isColliding()
	local myVelocity = mcontroller.velocity()
	
	local direction = {(args.moves["right"] and 1 or 0) + (args.moves["left"] and -1 or 0) , (args.moves["up"] and 1 or 0) + (args.moves["down"] and -1 or 0)}
	
	self.deltas = { direction[1]*5, direction[2]*5 }
	self.hyp = math.sqrt((self.deltas[1] ^ 2) + (self.deltas[2] ^ 2))
	
	self.Ddeltas = world.distance(mcontroller.position(), tech.aimPosition())
	self.Dhyp = math.sqrt((self.Ddeltas[1] ^ 2) + (self.Ddeltas[2] ^ 2))
	if not mcontroller.onGround() and args.moves["jump"] then
		mcontroller.setVelocity({(self.deltas[1] / self.hyp * 15), (self.deltas[2] / self.hyp * 15)})
		if args.moves["up"] and args.moves["jump"] and not args.moves["run"] then
			if status.overConsumeResource("energy", self.energyPerSecond * 2 ) then
				mcontroller.setVelocity({-(self.Ddeltas[1] / self.Dhyp * 50), -(self.Ddeltas[2] / self.Dhyp * 50)})
			end
		elseif not args.moves["run"] or ( args.moves["left"] and args.moves["right"] ) then
			mcontroller.setVelocity({-(self.deltas[1] / self.hyp * 0), -(self.deltas[2] / self.hyp * 0)})
		end
	end
end
