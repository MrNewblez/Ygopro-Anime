--Number 23: Lancelot, Ghost Knight of the Underworld
function c511000183.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,8,2)
	c:EnableReviveLimit()
	--direct
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000183,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c511000183.condition)
	e2:SetTarget(c511000183.target)
	e2:SetOperation(c511000183.operation)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000183,1))
	e3:SetCategory(CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCondition(c511000183.negcon)
	e3:SetCost(c511000183.negcost)
	e3:SetTarget(c511000183.negtg)
	e3:SetOperation(c511000183.negop)
	c:RegisterEffect(e3)
end
c511000183.xyz_number=23
function c511000183.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetAttackTarget()==nil and e:GetHandler():GetOverlayCount()>0
end
function c511000183.filter(c,atk)
	return c:IsFaceup() and c:GetAttack()<=atk and c:IsDestructable()
end
function c511000183.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() and c511000183.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000183.filter,tp,0,LOCATION_MZONE,1,nil,c:GetAttack()*2) end
	local sg=Duel.GetMatchingGroup(c511000183.filter,tp,0,LOCATION_MZONE,nil,c:GetAttack()*2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511000183.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetMatchingGroup(c511000183.filter,tp,0,LOCATION_MZONE,nil,c:GetAttack()*2)
	Duel.Destroy(sg,REASON_EFFECT)
end
function c511000183.negcon(e,tp,eg,ep,ev,re,r,rp,chk)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and ep~=tp
		and Duel.IsChainDisablable(ev)
end
function c511000183.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511000183.negtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c511000183.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end