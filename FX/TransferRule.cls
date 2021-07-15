/// 
Class FX.TransferRule Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "Ens.Rule.GeneralBusinessRuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="" production="">
<ruleSet name="FileType" effectiveBegin="" effectiveEnd="">
<rule name="IG" disabled="false">
<when condition="Message.FileName [ &quot;tradeBreakdown&quot;">
<return>"IG"</return>
</when>
<when condition="Message.FileName [ &quot;成立&quot;">
<return>"M2J"</return>
</when>
<when condition="Message.FileName [ &quot;payment&quot;">
<return>"RakutenSwap"</return>
</when>
<when condition="Message.FileName [ &quot;rakuten&quot;">
<return>"Rakuten"</return>
</when>
<otherwise>
<return>"OTHERS"</return>
</otherwise>
</rule>
</ruleSet>
</ruleDefinition>
}

}
