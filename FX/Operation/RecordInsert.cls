Class FX.Operation.RecordInsert Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Method InsertRecord(pRequest As FX.Request.DBLoadMessage, Output pResponse As Ens.StringResponse) As %Status
{
	set status = $$$OK
	
	$$$TRACE("証券会社 = "_pRequest.Broker)
	$$$TRACE("OpenDate = "_pRequest.OpenDate)
	$$$TRACE("FundingCost = "_pRequest.FundingCost)
	
	if pRequest.Broker'="" {
	  set record = ##class(FX.DB.Trade).%New()
	  set record.Broker = pRequest.Broker
	  set record.BuySell = pRequest.BuySell
	  if pRequest.CloseDate '= "" set record.CloseDate = $zdateh(pRequest.CloseDate,8)
	  set record.ClosePrice = pRequest.ClosePrice
	  set record.CurrencyPair = pRequest.CurrencyPair
	  set record.Swap = -pRequest.FundingCost
	  if pRequest.OpenDate '= "" set record.OpenDate = $zdateh(pRequest.OpenDate,8)
	  set record.OpenPrice = pRequest.OpenPrice
	  set record.ProfitLoss = +pRequest.ProfitLoss
	  set record.TransactionUnit = pRequest.TransactionUnit
	
	  set status = record.%Save()
	
	  set pResponse = ##class(Ens.StringResponse).%New()
	  
	  if status = $$$OK {
	     set pResponse.StringValue = "証券会社 "_pRequest.Broker_" のデータが追加されました。"
	  }
	  else {
	     set pResponse.StringValue = "証券会社 "_pRequest.Broker_" のデータが追加できませんでした。エラー: "_$system.Status.GetErrorText(status)
	  }
	}
	 
	Quit status
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="FX.Request.DBLoadMessage"> 
		<Method>InsertRecord</Method>
	</MapItem>
</MapItems>
}

}
