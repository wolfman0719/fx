Class FX.Transformation.GaitameOnline Extends Ens.DataTransformDTL [ DependsOn = (FX.GaitameOnline.Record, FX.Response.DBLoadMessage) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='FX.GaitameOnline.Record' targetClass='FX.Response.DBLoadMessage' create='new' language='objectscript' >
<assign value='..ConvertDateTime(source.ExecutionDateTime,"%y-%m-%d %H:%M","%Y%m%d")' property='target.CloseDate' action='set' />
<assign value='source.CurrencyPair' property='target.CurrencyPair' action='set' />
<assign value='##class(FX.Utility.TextHandling).GetGaitameBuySell(source.BuyNo,source.SellNo)' property='target.BuySell' action='set' />
<assign value='##class(FX.Utility.TextHandling).GetGaitameUnitNo(source.BuyNo,source.SellNo)' property='target.TransactionUnit' action='set' />
<assign value='source.TransactionRate' property='target.ClosePrice' action='set' />
<assign value='##class(FX.Utility.TextHandling).GetGaitameFundingCost(source.HandlingCost,source.Swap)' property='target.FundingCost' action='set' />
<assign value='source.TradingPL' property='target.ProfitLoss' action='set' />
<assign value='"GaitameOnline"' property='target.Broker' action='set' />
</transform>
}

}
