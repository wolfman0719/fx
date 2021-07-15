/// 
Class FX.Cube.TradingResult Extends %DeepSee.CubeDefinition [ DependsOn = FX.DB.Trade, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="TradingResult" displayName="TradingResult" disabled="false" abstract="false" sourceClass="FX.DB.Trade" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="Broker" disabled="false" hasAll="false" allCaption="All Broker" allDisplayName="Broker" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Broker" disabled="false" sourceProperty="Broker" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="CurrencyPair" disabled="false" hasAll="false" allCaption="All CurrencyPair" allDisplayName="CurrencyPair" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="CurrencyPair" disabled="false" sourceProperty="CurrencyPair" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="CloseDate" disabled="false" hasAll="false" allCaption="All CloseDate" allDisplayName="CloseDate" sourceProperty="CloseDate" type="time" calendar="gregorian" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="CloseDate" disabled="false" timeFunction="Year" list="false" useDisplayValue="true" useAsFilter="true" hidden="false">
      </level>
    </hierarchy>
  </dimension>
  <measure name="ProfitLoss" disabled="false" sourceProperty="ProfitLoss" aggregate="SUM" type="number" hidden="false" searchable="false">
  </measure>
  <measure name="Swap" disabled="false" sourceProperty="Swap" aggregate="SUM" type="number" hidden="false" searchable="false">
  </measure>
  <listing name="Details" disabled="false" listingType="table" fieldList="Broker,CurrencyPair,ProfitLoss,Swap,BuySell,OpenDate,CloseDate">
  </listing>
</cube>
}

Parameter DOMAIN;

}
