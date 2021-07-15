Class FX.Transformation.IGSeculity Extends Ens.DataTransformDTL [ DependsOn = (FX.IGSecurity.Record, FX.Response.DBLoadMessage) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='FX.IGSecurity.Record' targetClass='FX.Response.DBLoadMessage' create='new' language='objectscript' >
<assign value='..Lookup("BuySell",source.Direction)' property='target.BuySell' action='set' />
<assign value='source.Size*10000' property='target.TransactionUnit' action='set' />
<assign value='##class(FX.Utility.TextHandling).RemoveCamma(source.ProfitLoss)' property='target.ProfitLoss' action='set' />
<assign value='source.Opening' property='target.OpenPrice' action='set' />
<assign value='source.Closing' property='target.ClosePrice' action='set' />
<assign value='source.Funding' property='target.FundingCost' action='set' />
<assign value='..ConvertDateTime(source.OpendDateTime,"%d-%m-%Y %T","%Y%m%d")' property='target.OpenDate' action='set' />
<assign value='..ConvertDateTime(source.ClosedDateTime,"%d-%m-%Y %T","%Y%m%d")' property='target.CloseDate' action='set' />
<assign value='..Piece(source.Market," ",1)' property='target.CurrencyPair' action='set' />
<assign value='"IGSeculity"' property='target.Broker' action='set' />
</transform>
}

}
