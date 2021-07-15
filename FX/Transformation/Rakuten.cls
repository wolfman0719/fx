Class FX.Transformation.Rakuten Extends Ens.DataTransformDTL [ DependsOn = (FX.Rakuten.Record, FX.Response.DBLoadMessage) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='FX.Rakuten.Record' targetClass='FX.Response.DBLoadMessage' create='new' language='objectscript' >
<assign value='..Lookup("CurrencyPair",source.CurrencyPair)' property='target.CurrencyPair' action='set' />
<assign value='source.Direction' property='target.BuySell' action='set' />
<assign value='##class(FX.Utility.TextHandling).RemoveCamma(source.Quantity)' property='target.TransactionUnit' action='set' />
<assign value='source.ExecutionRate' property='target.ClosePrice' action='set' />
<assign value='##class(FX.Utility.TextHandling).RemoveCamma(source.ProfitLossYen)' property='target.ProfitLoss' action='set' />
<assign value='..ConvertDateTime(source.OrderDateTime,"%Y/%m/%d %H:%M","%Y%m%d")' property='target.OpenDate' action='set' />
<assign value='..ConvertDateTime(source.ExecutionDateTime,"%Y/%m/%d %H:%M","%Y%m%d")' property='target.CloseDate' action='set' />
<assign value='"Rakuten"' property='target.Broker' action='set' />
</transform>
}

}
