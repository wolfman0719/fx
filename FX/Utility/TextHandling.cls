Class FX.Utility.TextHandling Extends Ens.Rule.FunctionSet
{

ClassMethod GetRakutenSwapCurrency(pDetails As %String) As %String [ Final, Language = objectscript ]
{
  quit $piece($zstrip(pDetails,"<=>W")," ",3)
}

ClassMethod GetRakutenSwapBuySell(pDetails As %String) As %String [ Final, Language = objectscript ]
{
	
  quit $piece($zstrip(pDetails,"<=>W")," ",4)
}

ClassMethod GetRakutenSwapOpenPrice(pDetails As %String) As %String [ Final, Language = objectscript ]
{
  quit $piece($piece($zstrip(pDetails,"<=>W")," ",5),"]",2)
}

ClassMethod GetRakutenSwapUnit(pDetails As %String) As %String [ Final, Language = objectscript ]
{
  quit $inumber($piece($piece($zstrip(pDetails,"<=>W")," ",6),"]",2),",")
}

ClassMethod RemoveCamma(pNumber As %String) As %String [ Final, Language = objectscript ]
{
  quit $inumber(pNumber,",")
}

ClassMethod JDate2H(pJDate As %String) As %String [ Final, Language = objectscript ]
{
  set year =$piece(pJDate,"/",1)
  set month = $piece(pJDate,"/",2)
  set day = $piece(pJDate,"/",3)
  quit $zdateh(year_month_day,8)
}

ClassMethod GetGaitameBuySell(pBuy As %Integer, pSell As %Integer) As %String [ Final, Language = objectscript ]
{
  if +$get(pBuy)>0 Quit "売"
  if +$get(pSell)>0 Quit "買"
}

ClassMethod GetGaitameUnitNo(pBuy As %Integer, pSell As %Integer) As %Integer [ Final, Language = objectscript ]
{
  if +$get(pBuy)>0 Quit +pBuy*1000
  if +$get(pSell)>0 Quit +pSell*1000
}

ClassMethod GetGaitameFundingCost(pHandlingCost As %String, pSwap As %String) As %Integer [ Final, Language = objectscript ]
{
  quit +pHandlingCost -  pSwap
}

}
