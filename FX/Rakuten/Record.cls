/// RECORDMAP: Generated from RecordMap 'FX.Rakuten'
/// on 2019-10-18 at 15:40:38.868 [2019-10-18 06:40:38.868 UTC]
/// by user UnknownUser
Class FX.Rakuten.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property ExecutionNo As %Integer;

Property CurrencyPair As %String;

Property TransactionType As %String;

Property Direction As %String;

Property Quantity As %String;

Property ExecutionRate As %Decimal(SCALE = 5);

Property ProfitLoss As %Decimal(SCALE = 5);

Property YenRate As %Decimal(SCALE = 5);

Property ProfitLossYen As %String;

Property OrderDateTime As %String;

Property ExecutionDateTime As %String;

Property Channel As %String;

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ExecutionNo</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>TransactionType</Value>
</Value>
<Value name="5">
<Value>Direction</Value>
</Value>
<Value name="6">
<Value>Quantity</Value>
</Value>
<Value name="7">
<Value>ExecutionRate</Value>
</Value>
<Value name="8">
<Value>ProfitLoss</Value>
</Value>
<Value name="9">
<Value>YenRate</Value>
</Value>
<Value name="10">
<Value>ProfitLossYen</Value>
</Value>
<Value name="11">
<Value>OrderDateTime</Value>
</Value>
<Value name="12">
<Value>ExecutionDateTime</Value>
</Value>
<Value name="13">
<Value>Channel</Value>
</Value>
<Value name="14">
<Value>CurrencyPair</Value>
</Value>
</Data>
<DataLocation>^FX.Rakuten.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^FX.Rakuten.RecordD</IdLocation>
<IndexLocation>^FX.Rakuten.RecordI</IndexLocation>
<StreamLocation>^FX.Rakuten.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
