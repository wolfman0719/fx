/// RECORDMAP: Generated from RecordMap 'FX.IGSecurity'
/// on 2019-10-18 at 15:38:16.433 [2019-10-18 06:38:16.433 UTC]
/// by user UnknownUser
Class FX.IGSecurity.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property ClosingRef As %String;

Property ClosedDateTime As %String;

Property OpeningRef As %String;

Property OpendDateTime As %String;

Property Market As %String;

Property Period As %String;

Property Direction As %String;

Property Size As %Integer;

Property Opening As %Decimal(SCALE = 5);

Property Closing As %Decimal(SCALE = 5);

Property TradeCurrency As %String;

Property ProfitLoss As %String;

Property Funding As %Decimal(SCALE = 2);

Property Borrowing As %Decimal(SCALE = 2);

Property Dividends As %Decimal(SCALE = 2);

Property LRPrem As %Decimal(SCALE = 2);

Property Others As %Decimal(SCALE = 2);

Property CommCurrency As %String;

Property Comm As %Decimal(SCALE = 2);

Property Total As %String;

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ClosingRef</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>OpeningRef</Value>
</Value>
<Value name="5">
<Value>OpendDateTime</Value>
</Value>
<Value name="6">
<Value>Market</Value>
</Value>
<Value name="7">
<Value>Period</Value>
</Value>
<Value name="8">
<Value>Direction</Value>
</Value>
<Value name="9">
<Value>Size</Value>
</Value>
<Value name="10">
<Value>Opening</Value>
</Value>
<Value name="11">
<Value>Closing</Value>
</Value>
<Value name="12">
<Value>TradeCurrency</Value>
</Value>
<Value name="13">
<Value>ProfitLoss</Value>
</Value>
<Value name="14">
<Value>Funding</Value>
</Value>
<Value name="15">
<Value>Borrowing</Value>
</Value>
<Value name="16">
<Value>Dividends</Value>
</Value>
<Value name="17">
<Value>LRPrem</Value>
</Value>
<Value name="18">
<Value>Others</Value>
</Value>
<Value name="19">
<Value>CommCurrency</Value>
</Value>
<Value name="20">
<Value>Comm</Value>
</Value>
<Value name="21">
<Value>Total</Value>
</Value>
<Value name="22">
<Value>ClosedDateTime</Value>
</Value>
</Data>
<DataLocation>^FX.IGSecurity.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^FX.IGSecurity.RecordD</IdLocation>
<IndexLocation>^FX.IGSecurity.RecordI</IndexLocation>
<StreamLocation>^FX.IGSecurity.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
