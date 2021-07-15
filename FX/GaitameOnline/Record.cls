/// RECORDMAP: Generated from RecordMap 'FX.GaitameOnline'
/// on 2019-10-21 at 16:07:28.525 [2019-10-21 07:07:28.525 UTC]
/// by user UnknownUser
Class FX.GaitameOnline.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property OrderNo As %Integer;

Property ExecutionDateTime As %String;

Property TransactionType As %String;

Property TargetOrderNo As %Integer;

Property CurrencyPair As %String;

Property SellNo As %Integer;

Property BuyNo As %Integer;

Property TransactionRate As %Decimal(SCALE = 5);

Property HandlingCost As %Integer;

Property YenRate As %Integer;

Property TradingPL As %Integer;

Property Swap As %Integer;

Property SettlementFee As %Integer;

Property SettlementPL As %String;

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>OrderNo</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>TransactionType</Value>
</Value>
<Value name="5">
<Value>TargetOrderNo</Value>
</Value>
<Value name="6">
<Value>CurrencyPair</Value>
</Value>
<Value name="7">
<Value>SellNo</Value>
</Value>
<Value name="8">
<Value>BuyNo</Value>
</Value>
<Value name="9">
<Value>TransactionRate</Value>
</Value>
<Value name="10">
<Value>HandlingCost</Value>
</Value>
<Value name="11">
<Value>YenRate</Value>
</Value>
<Value name="12">
<Value>TradingPL</Value>
</Value>
<Value name="13">
<Value>Swap</Value>
</Value>
<Value name="14">
<Value>SettlementFee</Value>
</Value>
<Value name="15">
<Value>SettlementPL</Value>
</Value>
<Value name="16">
<Value>ExecutionDateTime</Value>
</Value>
</Data>
<DataLocation>^FX.GaitameOnline.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^FX.GaitameOnline.RecordD</IdLocation>
<IndexLocation>^FX.GaitameOnline.RecordI</IndexLocation>
<StreamLocation>^FX.GaitameOnline.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
