/// RECORDMAP: Generated from RecordMap 'FX.RakutenSwap'
/// on 2019-10-18 at 15:40:59.819 [2019-10-18 06:40:59.819 UTC]
/// by user UnknownUser
Class FX.RakutenSwap.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property DeliveryDate As %String;

Property TransactionType As %String;

Property Currency As %String;

Property ProfitLoss As %Decimal(SCALE = 5);

Property TransactionDateTime As %String;

Property Details As %String(MAXLEN = 100);

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>DeliveryDate</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>Currency</Value>
</Value>
<Value name="5">
<Value>ProfitLoss</Value>
</Value>
<Value name="6">
<Value>TransactionDateTime</Value>
</Value>
<Value name="7">
<Value>Details</Value>
</Value>
<Value name="8">
<Value>TransactionType</Value>
</Value>
</Data>
<DataLocation>^FX.RakutenSwap.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^FX.RakutenSwap.RecordD</IdLocation>
<IndexLocation>^FX.RakutenSwap.RecordI</IndexLocation>
<StreamLocation>^FX.RakutenSwap.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
