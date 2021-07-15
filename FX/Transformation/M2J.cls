Class FX.Transformation.M2J Extends Ens.DataTransformDTL [ DependsOn = (FX.M2J.Record, FX.Response.DBLoadMessage) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='FX.M2J.Record' targetClass='FX.Response.DBLoadMessage' create='new' language='objectscript' >
<assign value='source.CurrencyPair' property='target.CurrencyPair' action='set' />
<assign value='..Translate(source.Direction,"買売","売買")' property='target.BuySell' action='set' />
<assign value='"M2J"' property='target.Broker' action='set' />
<assign value='source.OrderUnit' property='target.TransactionUnit' action='set' />
<assign value='source.ProfitLoss' property='target.ProfitLoss' action='set' />
<assign value='source.AcquisitionPrice' property='target.ClosePrice' action='set' />
<assign value='..ConvertDateTime(source.OrderedDateTime,"%Y/%m/%d %T","%Y%m%d")' property='target.OpenDate' action='set' />
<assign value='..ConvertDateTime(source.EstablishedDateTime,"%Y/%m/%d %T","%Y%m%d")' property='target.CloseDate' action='set' />
<assign value='0' property='target.FundingCost' action='set' />
</transform>
}

}
