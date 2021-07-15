Class FX.Response.DBLoadMessage Extends Ens.Response
{

Property Broker As %String;

Property OpenDate As %String;

Property CloseDate As %String;

Property CurrencyPair As %String;

Property BuySell As %String;

Property TransactionUnit As %Integer;

Property OpenPrice As %Decimal(SCALE = 5);

Property ClosePrice As %Decimal(SCALE = 5);

Property ProfitLoss As %Integer;

Property FundingCost As %Integer;

Storage Default
{
<Data name="DBLoadMessageDefaultData">
<Subscript>"DBLoadMessage"</Subscript>
<Value name="1">
<Value>Broker</Value>
</Value>
<Value name="2">
<Value>OpenDate</Value>
</Value>
<Value name="3">
<Value>CloseDate</Value>
</Value>
<Value name="4">
<Value>CurrencyPair</Value>
</Value>
<Value name="5">
<Value>BuySell</Value>
</Value>
<Value name="6">
<Value>TransactionUnit</Value>
</Value>
<Value name="7">
<Value>OpenPrice</Value>
</Value>
<Value name="8">
<Value>ClosePrice</Value>
</Value>
<Value name="9">
<Value>ProfitLoss</Value>
</Value>
<Value name="10">
<Value>FundingCost</Value>
</Value>
</Data>
<DefaultData>DBLoadMessageDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
