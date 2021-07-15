/// RECORDMAP: Generated from RecordMap 'FX.M2J'
/// on 2019-10-18 at 15:39:56.056 [2019-10-18 06:39:56.056 UTC]
/// by user UnknownUser
Class FX.M2J.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property CurrencyPair As %String;

Property Direction As %String;

Property DealType As %String;

Property OrderUnit As %Integer;

Property OrderedPrice As %Decimal(SCALE = 5);

Property EstablishedPrice As %Decimal(SCALE = 5);

Property AcquisitionPrice As %Decimal(SCALE = 5);

Property ProfitLoss As %Decimal(SCALE = 5);

Property OrderedDateTime As %String;

Property EstablishedDateTime As %String;

Property OrderNo As %Integer;

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CurrencyPair</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>DealType</Value>
</Value>
<Value name="5">
<Value>OrderUnit</Value>
</Value>
<Value name="6">
<Value>OrderedPrice</Value>
</Value>
<Value name="7">
<Value>EstablishedPrice</Value>
</Value>
<Value name="8">
<Value>AcquisitionPrice</Value>
</Value>
<Value name="9">
<Value>ProfitLoss</Value>
</Value>
<Value name="10">
<Value>OrderedDateTime</Value>
</Value>
<Value name="11">
<Value>EstablishedDateTime</Value>
</Value>
<Value name="12">
<Value>OrderNo</Value>
</Value>
<Value name="13">
<Value>Direction</Value>
</Value>
</Data>
<DataLocation>^FX.M2J.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^FX.M2J.RecordD</IdLocation>
<IndexLocation>^FX.M2J.RecordI</IndexLocation>
<StreamLocation>^FX.M2J.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
