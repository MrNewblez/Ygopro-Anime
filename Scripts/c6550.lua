--Scripted by Eerie Code
--The Phantom Knights of Dusty Robe
function c6550.initial_effect(c)
	--Increase ATK/DEF
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6550,0))
	e1:SetCategory(CATEGORY_DEFCHANGE+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,6550)
	e1:SetCondition(c6550.atkcon)
	e1:SetTarget(c6550.atktg)
	e1:SetOperation(c6550.atkop)
	c:RegisterEffect(e1)
	--Search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(6550,1))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,6550+1)
	e2:SetCost(c6550.thcost)
	e2:SetTarget(c6550.thtg)
	e2:SetOperation(c6550.thop)
	c:RegisterEffect(e2)
end

function c6550.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c6550.atkfil(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK)
end
function c6550.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c6550.atkfil(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c6550.atkfil,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c6550.atkfil,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,g:GetCount(),0,0)
end
function c6550.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and c:IsFaceup() then
		if Duel.ChangePosition(c,POS_FACEUP_DEFENCE) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(800)
			e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+RESET_END+RESET_OPPO_TURN)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENCE)
			tc:RegisterEffect(e2)
		end
	end
end

function c6550.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c6550.thfil(c)
	return c:IsSetCard(0x10df) and not c:IsCode(6550) and c:IsAbleToHand()
end
function c6550.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6550.thfil,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c6550.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c6550.thfil,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
