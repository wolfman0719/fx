Class FX.Transformation.RakutenSwap Extends Ens.DataTransformDTL [ DependsOn = (FX.RakutenSwap.Record, FX.Response.DBLoadMessage) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='FX.RakutenSwap.Record' targetClass='FX.Response.DBLoadMessage' create='new' language='objectscript' >
<assign value='source.ProfitLoss' property='target.FundingCost' action='set' />
<assign value='..Lookup("CurrencyPair",##class(FX.Utility.TextHandling).GetRakutenSwapCurrency(source.Details))' property='target.CurrencyPair' action='set' />
<assign value='##class(FX.Utility.TextHandling).GetRakutenSwapBuySell(source.Details)' property='target.BuySell' action='set' />
<assign value='##class(FX.Utility.TextHandling).GetRakutenSwapUnit(source.Details)' property='target.TransactionUnit' action='set' />
<assign value='..ConvertDateTime(source.TransactionDateTime,"%Y/%m/%d %H:%M","%Y%m%d")' property='target.OpenDate' action='set' />
<assign value='##class(FX.Utility.TextHandling).GetRakutenSwapOpenPrice(source.Details)' property='target.OpenPrice' action='set' />
<assign value='"Rakuten"' property='target.Broker' action='set' />
<assign value='..ConvertDateTime(source.DeliveryDate,"%y/%m/%d","%Y%m%d")' property='target.CloseDate' action='set' />
</transform>
}

}
