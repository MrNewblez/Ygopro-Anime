--Scripted by Eerie Code
--Illusion Ninjitsu Art of Hazy Shuriken
function c700000007.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c700000007.actcon)
	c:RegisterEffect(e1)
	--Damage
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	--e2:SetCondition(c700000007.damcon)
	e2:SetCost(c700000007.damcost)
	e2:SetOperation(c700000007.damop)
	c:RegisterEffect(e2)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EFFECT_SELF_DESTROY)
	e4:SetCondition(c700000007.descon)
	c:RegisterEffect(e4)
end

function c700000007.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2b)
end
function c700000007.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c700000007.cfilter,tp,LOCATION_MZONE,0,1,nil)
end

function c700000007.damfil(c,tp)
	return c:IsControler(tp) and c:IsDiscardable()
end
function c700000007.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c700000007.damfil,1,e:GetHandler(),e:GetHandlerPlayer()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	--local dc=eg:Filter(Card.IsDiscardable,nil):Select(tp,1,1,nil)
	local dc=eg:Filter(c700000007.damfil,nil,e:GetHandlerPlayer()):Select(tp,1,1,nil)
	Duel.SendtoGrave(dc,REASON_COST+REASON_DISCARD)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
end
function c700000007.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,300,REASON_EFFECT)
end

function c700000007.desfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x2b)
end
function c700000007.descon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c700000007.desfilter,tp,LOCATION_MZONE,0,1,nil)
end