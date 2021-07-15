/// 
Class FX.BP.BuildDB Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2150' >
<context>
<property name='ExecutionType' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='DBMessage' type='FX.Response.DBLoadMessage' instantiate='0' />
<property name='ConfigName' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
</context>
<sequence xend='200' yend='1250' >
<assign name="Initialize" property="context.ConfigName" value="process.%PrimaryRequestHeader.SourceConfigName" action="set" xpos='200' ypos='250' >
<annotation><![CDATA[どの証券会社か特定する]]></annotation>
</assign>
<switch name='SecurityCompany' xpos='200' ypos='350' xend='200' yend='1050' >
<annotation><![CDATA[どの証券会社の情報か？]]></annotation>
<case condition='context.ConfigName="LoadRakuten"' name='Rakuten' >
<transform name='Rakuten' class='FX.Transformation.Rakuten' source='request' target='context.DBMessage' xpos='335' ypos='500' >
<annotation><![CDATA[楽天証券のデータを変換する]]></annotation>
</transform>
</case>
<case condition='context.ConfigName="LoadRakutenSwap"' name='RakutenSwap' >
<transform name='RakutenSwap' class='FX.Transformation.RakutenSwap' source='request' target='context.DBMessage' xpos='605' ypos='500' >
<annotation><![CDATA[楽天証券のスワップデータを変換する]]></annotation>
</transform>
</case>
<case condition='context.ConfigName="LoadIGSecurity"' name='IGSeculity' >
<transform name='IGSeculity' class='FX.Transformation.IGSeculity' source='request' target='context.DBMessage' xpos='875' ypos='500' >
<annotation><![CDATA[IG証券のデータを変換する]]></annotation>
</transform>
</case>
<case condition='context.ConfigName="LoadGaitameOnline"' name='GaitameOnline' >
<transform name='GaitameOnline' class='FX.Transformation.GaitameOnline' source='request' target='context.DBMessage' xpos='1145' ypos='500' >
<annotation><![CDATA[外為オンライン証券のデータを変換する]]></annotation>
</transform>
</case>
<case condition='context.ConfigName="LoadM2J"' name='M2J' >
<assign name="SetExecutionType" property="context.ExecutionType" value="request.DealType" action="set" xpos='1415' ypos='500' >
<annotation><![CDATA[取引タイプ（新規/決済）を取得する]]></annotation>
</assign>
<if name='SelectExecutionOnly' condition='context.ExecutionType="決済"' xpos='1415' ypos='600' xend='1415' yend='850' >
<annotation><![CDATA[決済データのみを抽出する]]></annotation>
<true>
<transform name='M2J' class='FX.Transformation.M2J' source='request' target='context.DBMessage' xpos='1550' ypos='750' >
<annotation><![CDATA[M2J証券のデータを変換する]]></annotation>
</transform>
</true>
</if>
</case>
<default/>
</switch>
<call name='InsertRecord' target='FX Data Load' async='1' xpos='200' ypos='1150' >
<annotation><![CDATA[データベースにレコードを書き込む]]></annotation>
<request type='FX.Request.DBLoadMessage' >
<assign property="callrequest.FundingCost" value="$translate(context.DBMessage.FundingCost,&quot;,&quot;,&quot;&quot;)" action="set" />
<assign property="callrequest.ProfitLoss" value="$translate(context.DBMessage.ProfitLoss,&quot;,&quot;,&quot;&quot;)" action="set" />
<assign property="callrequest.TransactionUnit" value="$translate(context.DBMessage.TransactionUnit,&quot;,&quot;,&quot;&quot;)" action="set" />
<assign property="callrequest.Broker" value="context.DBMessage.Broker" action="set" />
<assign property="callrequest.BuySell" value="context.DBMessage.BuySell" action="set" />
<assign property="callrequest.CloseDate" value="context.DBMessage.CloseDate" action="set" />
<assign property="callrequest.ClosePrice" value="context.DBMessage.ClosePrice" action="set" />
<assign property="callrequest.CurrencyPair" value="context.DBMessage.CurrencyPair" action="set" />
<assign property="callrequest.OpenDate" value="context.DBMessage.OpenDate" action="set" />
<assign property="callrequest.OpenPrice" value="context.DBMessage.OpenPrice" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
